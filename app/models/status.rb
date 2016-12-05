class Status < ActiveRecord::Base
	#attr_accessible :content, :user_id
	acts_as_votable
	
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :content, length: { minimum: 2 }

	validates :user_id, presence: true	

	has_attached_file :image, s3_protocol: :https, styles: {thumb: '455x700', medium: '300x300'}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/	

	has_attached_file :video, s3_protocol: :https, styles: {
	   medium: {
          geometry: "640x480",
          format: 'mp4'
        },
        thumb: { geometry: "160x120", format: 'jpeg', time: 10}
	  }, processors: [:transcoder]
	  
    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
end
