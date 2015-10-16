class Listing
  include Mongoid::Document

    belongs_to :user

    field :name, :type => String
    field :description, :type => String
    field :price, :type => Integer
    field :location, :type => String
    field :experation_date, :type => Integer
    field :status, :type => String, :default => "active"

end
