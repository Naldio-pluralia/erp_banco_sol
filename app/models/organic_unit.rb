class OrganicUnit < ApplicationRecord
  belongs_to :organic_unit_type
  belongs_to :organic_unit, optional: true
  has_many :organic_units, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :efectives, through: :positions
  has_many :employee_skills, through: :efectives

  validates_presence_of :organic_unit_type, :name
  validates_uniqueness_of :name
  #validates :name, format: {with: NAME_REGEX}, if: ->(user) {user.name.present?}

end
