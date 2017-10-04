class Invitation
  include Mongoid::Document
  before_create :convertInArray

  belongs_to :user
  belongs_to :marker
  field :send_to_list, type: Array, default: []
  field :send_to
  field :email_body
  field :status

  def convertInArray
  	puts self.inspect
  	puts '***********SELF************'
  	self.send_to_list << self.send_to.split(',').map{ |v| v.strip}
  	puts self.inspect
  end

  #  def send_to_list=(arg)
  #   self.tags = arg.split(',').map { |v| v.strip }
  # end

  # def send_to_list
  #   self.tags.join(', ')
  # end


end
