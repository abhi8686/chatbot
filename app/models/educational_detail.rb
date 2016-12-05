class EducationalDetail < ActiveRecord::Base
	belongs_to :user

	validates :collageName, presence: true
	validates :courseName, presence: true
	validates :location, presence: true

end
