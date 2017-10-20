class Picture
  include Mongoid::Document
  include Mongoid::Paperclip
  embedded_in :marker, :inverse_of => :pictures


  has_mongoid_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
