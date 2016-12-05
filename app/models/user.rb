class User < ActiveRecord::Base
  
  after_create :friend_hibot

  acts_as_voter
  acts_as_taggable_on :interests
  attr_accessor :current_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
 	#
    scope :published, -> { where(state_facebook: true) }
    scope :published_twitter, -> { where(state_twitter: true) }

    validates :first_name, presence: true 
    validates :profile_name, presence: true, uniqueness: true,
    								format: {
                             #fix bug whit a profile_name
                             with: /[a-zA-Z0-9_-]/,
                             message: 'Must be formatted correctly.'
                           }
    # chat                       
    has_many :conversations, :foreign_key => :sender_id
    has_many :identities

    has_one :a_brief_about_yourself
    has_one :educational_detail
    has_one :work_experience

    has_many :comments
    has_many :statuses
    
    has_many :user_friendships
    has_many :friends, -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships
    has_many :pending_friends, 
              -> { where user_friendships: { state: "pending" } }, 
                 through: :user_friendships,
                 source: :friend
                 
    has_attached_file :avatar , styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed

    has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
    has_many :followers, through: :reverse_relationships, source: :follower

    include Tire::Model::Search
    include Tire::Model::Callbacks

    def self.search(params)
      tire.search(load: true) do
        query { string params[:query]} if params[:query].present?
      end
    end

    def full_name
    	first_name
    end

    def name
      "#{first_name} #{last_name}"
    end

    def to_param
      profile_name
    end

    def gravatar_url style=""
      if style == "thumb"
        "noperfil_thumb.png"
      else
        "noperfil.jpg"
      end
    end


  def self.find_for_facebook_oauth(auth)

    user = User.joins(:identities).where("identities.provider = ? AND identities.uid = ?", auth.provider, auth.uid).first    
    
    # The User was found in our database    
    return user if user    
    # Check if the User is already registered without Facebook      
    user = User.where(email: auth.info.email).first 

    return user if user
    user = User.create(
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      profile_name:  auth.info.name.gsub(/\s+/, ""),
      email: auth.info.email,
      avatar: process_url(auth.info.image),
      password: Devise.friendly_token[0,20])

    Identity.create_with_omniauth_facebook(auth, user.id)
    user
  end


    def facebook(user)
      identit = Identity.identity_facebook(user.id, "facebook").first
      @facebook ||= Koala::Facebook::API.new(identit.oauth_token_facebook)
    end


    def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
      user = User.joins(:identities).where("identities.provider = ? AND identities.uid = ?", auth.provider, auth.uid).first
      
      if user
        return user
      else
        registered_user = User.where(email: auth.uid + "@twitter.com").first
        if registered_user
          return registered_user
        else
          

          user = User.create(first_name: auth.extra.raw_info.name,
                              profile_name: auth.info.nickname,
                              avatar: process_url(auth.info.image),
                              email: auth.uid+"@twitter.com",
                              password: Devise.friendly_token[0,20],
                            )
          Identity.create_with_omniauth_twitter(auth, user.id)

          user
        end
      end
    end

    def self.connect_to_twitter(actual_user, auth)
      Identity.create_with_omniauth_twitter(auth, actual_user.id)
    end

    def self.connect_to_facebook(actual_user, auth)
      Identity.create_with_omniauth_facebook(auth, actual_user.id)
    end

    def twitter(user)
        identit = Identity.identity_twitter(user.id, "twitter").first
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['APP_ID_TWITTER']
          config.consumer_secret     = ENV['APP_SECRET_TWITTER']
          config.access_token        = identit.oauth_token_twitter
          config.access_token_secret = identit.oauth_secret_twitter
        end
    end

   def self.connect_to_linkedin(auth, signed_in_resource=nil)
      user = User.joins(:identities).where("identities.provider = ? AND identities.uid = ?", auth.provider, auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else

        user = User.create(first_name: auth.info.first_name + " " + auth.info.last_name,
                            profile_name: auth.info.nickname,
                            avatar: auth.info.image,
                            email: auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
        Identity.create_with_omniauth_twitter(auth, user.id)

        user
      end

    end
  end   

 def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private
    def self.process_url(uri)
      avatar_url = URI.parse(uri)
      avatar_url.scheme = 'https'
      avatar_url.to_s
    end

    def friend_hibot
      hibot = User.find_by_profile_name('hibot')
      UserFriendship.create(user_id: self.id, friend_id: hibot.id, state: "accepted")
    end

end
