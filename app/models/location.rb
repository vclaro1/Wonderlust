class Location < ActiveRecord::Base
	belongs_to :trip
	has_many :interests, :dependent => :destroy
	has_many :tips, :dependent => :destroy
	has_many :photos, :dependent => :destroy
end
