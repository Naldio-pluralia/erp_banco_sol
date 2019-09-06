class EstablishmentType < ApplicationRecord
  has_many :establishment

  validates_presence_of :name
  validates :name, format: {with: NAME_REGEX}, if: ->(user) {user.name.present?}

end
