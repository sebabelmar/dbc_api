class Listing
  include Mongoid::Document
  include Mongoid::Enum

    belongs_to :user

    field :name, :type => String
    field :description, :type => String
    field :price, :type => Integer
    field :location, :type => String
    field :experation_date, :type => Integer
    enum :status, [:active, :pending, :closed], :default => :active

end
