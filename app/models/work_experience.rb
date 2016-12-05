class WorkExperience < ActiveRecord::Base
	belongs_to :user

	validates :companyName, presence: true
	validates :designation, presence: true
	validates :location, presence: true

end
