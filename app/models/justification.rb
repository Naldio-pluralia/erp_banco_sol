class Justification < NextSgad::Justification
  # belongs_to :position
  # belongs_to :assessment
  belongs_to :employee
  # belongs_to :department
  has_and_belongs_to_many :attendances, association_foreign_key: :next_sgad_attendance_id, foreign_key: :next_sgad_justification_id
  enum status: {pending: 0, approved: 1, disapproved: 2, in_progress: 3}
  enum first_approval_status: {pending: 0, approved: 1, disapproved: 2}, _prefix: :first
  enum second_approval_status: {pending: 0, approved: 1, disapproved: 2}, _prefix: :second
  
  mount_uploaders :documents, AttachmentsUploader
  # disapproved if both disapproved
  # approved if both approved
  # pending if both pending
  # in_progress if not first, second nor third
  attr_accessor :dates

  # gives first approval
  def first_approve
    update(first_approval_status: 1)
  end

  # gives second approval
  def second_approve
    update(second_approval_status: 1)
  end

  # gives first approval
  def first_disapprove
    update(first_approval_status: 2)
  end

  # gives second disapproval
  def second_disapprove
    update(second_approval_status: 2)
  end

  # Return an arrays of dates associated to this justification
  def days
    attendances.order(date: :asc).map(&:date)
  end

  validates_presence_of :employee_id, :attendance_ids
  validate :validate_attendances_uniqueness, on: :create
  before_destroy :change_attendances_status_before_destroy
  after_save :after_save_update_justifications

  private
  # chek if an attendance olready has a justification it return an error
  def validate_attendances_uniqueness
    attendances.each do |attendance|
      next if attendance.justification_ids.blank?
      errors.add(:attendance_ids, "a falta de #{attendance.date.month}/#{attendance.date.year} já tem justificativo.")
    end
  end

  def change_attendances_status_before_destroy
    # -1 stands for unjustified
    attendances.update_all(justification_status: -1)

  end

  def after_save_update_justifications
    if first_pending? && second_pending?
      update_columns(status: 0)

    elsif first_approved? && second_approved?
      update_columns(status: 1)

    elsif first_disapproved? && second_disapproved?
      update_columns(status: 2)

    else
      update_columns(status: 3)

    end
    attendances.where.not(justification_status: status).update_all(justification_status: Justification.statuses[status])
  end
end
