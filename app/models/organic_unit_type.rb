class OrganicUnitType < ApplicationRecord
  has_many :organic_units, dependent: :destroy

  validates_presence_of :name
  validates :name, format: {with: NAME_REGEX}, if: ->(user) {user.name.present?}

end
