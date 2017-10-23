class Marker
  include Mongoid::Document
  embeds_many :pictures, :cascade_callbacks => true
  has_and_belongs_to_many :users
  has_many :invitations
  accepts_nested_attributes_for :pictures
  #field :name, type: String
  #field :locations

  field :from_latitude, type: :float
  field :from_longitude, type: :float
  field :to_latitude, type: :float
  field :to_longitude, type: :float
  field :location_from
  field :location_to
  field :departure_date, type: :date
  field :begin_at, type: :time
  field :end_at, type: :time
  field :created_by, type: :integer
  field :invitation_sent, type: :integer
  field :pending, type: Array, default: []
  field :active, type: Array, default: []
  validates :from_latitude, presence: true
  validates :from_longitude, presence: true
  validates :to_latitude, presence: true
  validates :to_longitude, presence: true
  validates :location_from, presence: true
  validates :location_to, presence: true

  before_destroy :remove_trip_id_from_all_users


  #validates :name, :presence => true
  #validates :latitude, :presence => true
  #validates :longitude, :presence => true
  #field :coordinates, :type => Array
  #field :address
  #include Geocoder::Model::Mongoid
	#geocoded_by :name               # can also be an IP address
	#after_validation :geocode 
  #geocoded_by :name
  #after_validation :name, :if => :name_changed?

  protected

  def remove_trip_id_from_all_users

    self.users.each do |user|
      user.marker_ids.delete(self.id)
      user.save!
    end
  end

  def join_marker
    
  end

end
