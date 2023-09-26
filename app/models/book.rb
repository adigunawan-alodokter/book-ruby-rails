class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  belongs_to :author, class_name: 'Author'
end

