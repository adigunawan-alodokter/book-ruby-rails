class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :author, type: String
end

