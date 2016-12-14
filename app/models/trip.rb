class Trip < ActiveRecord::Base
	belongs_to :user
	has_many :locations, :dependent => :destroy	
	has_attached_file :image, styles: { medium: "300x300>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	acts_as_votable

end
