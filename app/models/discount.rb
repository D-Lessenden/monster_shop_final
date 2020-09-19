class Discount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name, :percent, :num_of_items
end
