require 'dm-timestamps'

class Link

  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :url,    String
  property :created_by, String
  property :created_on, Date
  property :description, Text

  has n, :tags, :through => Resource

end