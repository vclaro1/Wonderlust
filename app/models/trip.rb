class Trip < ActiveRecord::Base
	include Shared::Callbacks
	acts_as_followable
	belongs_to :user
	has_many :locations, :dependent => :destroy	
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	acts_as_votable
	accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :all_blank

	include PublicActivity::Model
	tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

    default_scope -> { order( 'cached_votes_total DESC') }


    validates_presence_of :user

	

end
