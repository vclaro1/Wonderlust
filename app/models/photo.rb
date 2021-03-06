class Photo < ActiveRecord::Base
	belongs_to :location
	has_attached_file :image, styles: { big: "800x800>" ,medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    include PublicActivity::Model
	tracked
end

