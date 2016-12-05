class Identity < ActiveRecord::Base
	belongs_to :user
  
  scope :identity_twitter, -> (user_id, provider) { where(user_id: user_id).where(provider: provider) }
  scope :identity_facebook, -> (user_id, provider) { where(user_id: user_id).where(provider: provider) }


  def self.find_with_omniauth(auth)
    find_by(uid: auth.uid, provider: auth.provider)
  end

  def self.create_with_omniauth_facebook(auth, user_id)
    create(user_id: user_id, uid: auth.uid, provider: auth.provider, oauth_token_facebook: auth.credentials.token)
  end

  def self.create_with_omniauth_twitter(auth, user_id)
    create(user_id: user_id, uid: auth.uid, provider: auth.provider, oauth_token_twitter: auth.credentials.token, oauth_secret_twitter: auth.credentials.secret)
  end

  def self.create_with_omniauth_linkedin(auth, user_id)
    create(user_id: user_id, uid: auth.uid, provider: auth.provider)
  end
end
