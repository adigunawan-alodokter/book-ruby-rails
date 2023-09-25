class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :bio, type: String
end
