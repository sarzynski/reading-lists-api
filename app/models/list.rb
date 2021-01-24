class List < ApplicationRecord
  has_many :books, dependent: :destroy

  validates_presence_of :name, :created_by
end
