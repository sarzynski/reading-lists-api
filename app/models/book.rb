class Book < ApplicationRecord
  belongs_to :list

  validates_presence_of :title
  validates_presence_of :author
end
