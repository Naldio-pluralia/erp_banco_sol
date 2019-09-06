class EmployeeWorkPeriod < ApplicationRecord
  belongs_to :employee, class_name: 'Employee'

  def unallowed_dates
    []#EmployeeWorkPeriod.where.not(id: id).where(employee_id: employee_id).map{|e| self.until.present? ? (e.since..e.until).to_a : e.since}.flatten.compact.uniq.map{|d| I18n.l(d)}
  end

  def present_until
    self.until.present? ? I18n.l(self.until) : I18n.t(:until_today)
  end
  

  validates_presence_of :since
  validates_uniqueness_of :since, scope: [:employee_id]
  validates_uniqueness_of :until, scope: [:employee_id], if: ->(work_period){work_period.until.present?}
  validate :validates_dates

  private
  def validates_dates
    if self.since.present?
      # Error if start date greater the todays date
      if since > Date.current
        errors.add(:since, errors_t(:since, :before_or_todays_date))
      end
    end

    if self.until.present?
      # Error if finish date greater than today
      if self.until > Date.current
        errors.add(:until, errors_t(:until, :before_or_todays_date))
      end

    else
      has_an_unclosed_work_period = EmployeeWorkPeriod.where.not(id: id).where(employee_id: employee_id, until: nil).exists?
      if has_an_unclosed_work_period
        errors.add(:until, errors_t(:until, :close_the_open_period_first))
      end
    end

    if self.since.present? && self.until.present?
      # Error if since date bigger than until date
      if self.since > self.until
        errors.add(:since, errors_t(:since, :before_or_x_date, x: I18n.l(self.since)))
        errors.add(:until, errors_t(:until, :after_or_x_date, x: I18n.l(self.until)))
      end

      has_a_started_work_period = EmployeeWorkPeriod.where(employee_id: employee_id).where.not(id: id, until: nil).where(since: self.since..self.until).exists?
      has_a_finished_work_period = EmployeeWorkPeriod.where(employee_id: employee_id).where.not(id: id, until: nil).where(until: self.since..self.until).exists?
      
      # error if there is an employee_work_period between the start and finish date of this one
      if has_a_started_work_period || has_a_finished_work_period
        errors.add(:since, errors_t(:since, :divergent_dates, x: I18n.l(self.since)))
        errors.add(:until, errors_t(:until, :divergent_dates, x: I18n.l(self.until)))
      end
    end
  end
end
