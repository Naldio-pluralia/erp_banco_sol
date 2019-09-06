class Establishment < ApplicationRecord
  belongs_to :establishment_type
  belongs_to :municipality, optional: :true
  belongs_to :establishment, optional: :true
  belongs_to :position, optional: :true
  has_many :positions, dependent: :destroy
  has_many :establishments, dependent: :destroy


  enum status: {open: 0, in_construction: 1, closed: 2}

  validates_presence_of :name, :establishment_type_id, :status
  validates :name, format: {with: NAME_REGEX}, if: ->(user) {user.name.present?}
  validates_uniqueness_of :name
end
