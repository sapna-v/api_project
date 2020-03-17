class User < ApplicationRecord
  #Validations
  before_save :default_values
  validates_presence_of :name, :email, :password_digest
  validates :email, uniqueness: true

  #encrypt password
  has_secure_password
  has_and_belongs_to_many :tags

  def default_values
    #Available - A, Disable - D
    self.status ||= 'A'
  end

  def self.valid_field?(field)
    column_names = self.column_names
    column_names.delete("password")
    column_names.include? field
  end

  def disable
    self.status = "D"
    self
  end

  def self.public_fields
    self.select('name, age, gender, address, email')
  end
end