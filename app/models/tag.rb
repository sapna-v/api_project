class Tag < ApplicationRecord
  validates_presence_of :name
  validates :name, uniqueness: true

  has_and_belongs_to_many :users

  def self.public_fields
    self.select('name')
  end

  def self.valid_field?(field)
    column_names = self.column_names
    column_names.include? field
  end
end
