class Item
  include Mongoid::Document

  belongs_to :user

  field :name, :type => String
  field :description, :type => String
  field :price, :type => Integer

end
