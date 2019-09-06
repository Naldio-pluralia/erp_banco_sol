class Application < ApplicationRecord
  belongs_to :vacancy, optional: true
  belongs_to :employee, optional: true
  has_many :object_attachments, as: :object, dependent: :destroy
  enum relevance: {unset: 0, relevant: 1, irrelevant: 2}
  enum civil_status: {single: 0, married: 1}

  validates :email, format: {with: EMAIL_REGEX}, if: ->(application) {application.email.present? && application.id.present?}
  validates :cellphone, format: {with: CELLPHONE_REGEX}, if: ->(application) {application.cellphone.present? && application.id.present?}
  # validates_presence_of :name, :email, :cellphone, :birthdate, :dependents_number
end
