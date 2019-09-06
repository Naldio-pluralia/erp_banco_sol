class SalaryBoard < ApplicationRecord
  has_many :salary_board_items, -> {order(paygrade: :asc)}, dependent: :destroy
  accepts_nested_attributes_for :salary_board_items
  enum status: {active: 0, inactive: 1}

  def self.latest
    SalaryBoard.order(id: :asc).last
  end

  def self.map_paygrades
    latest&.salary_board_items&.map(&:paygrade) || (1..10)
  end

  # def update_salary_board
  #   salary_board = self.dup
  #   salary_board.salary_board_items.build(salary_board_items.map{|s| {increment_value: s.increment_value}})
  #   base_salary = RemunerationSetting.last&.base_salary || 0
  #   curr_value = base_salary.round
  #   curr_paygrade = 0
  #   salary_board.salary_board_items.each do |item|
  #     increment_value = item.increment_value.round
  #     item.increment_value = increment_value
  #     curr_paygrade += 1
  #     item.paygrade = curr_paygrade
      
  #     item.base_value = curr_value
  #     curr_value += increment_value
  #     item.a_value = curr_value
  #     curr_value += increment_value
  #     item.b_value = curr_value
  #     curr_value += increment_value
  #     item.c_value = curr_value
  #     curr_value += increment_value
  #     item.d_value = curr_value
  #     curr_value += increment_value
  #   end
  #   salary_board.save
  # end

  validate :validates_items
  validates_presence_of :status
  private
  def validates_items
    base_salary = RemunerationSetting.latest&.base_salary || 0
    curr_value = base_salary.round
    curr_paygrade = 0
    self.salary_board_items.each do |item|
      if item.increment_value.nil?
        item.errors.add(:increment_value, errors_t('salary_board.salary_board_item', :blank))
        return
      end
      if item.increment_value <= 0
        item.errors.add(:increment_value, errors_t('salary_board.salary_board_item', :greater_than, count: 0))
      end

      increment_value = item.increment_value.round
      item.increment_value = increment_value
      curr_paygrade += 1
      item.paygrade = curr_paygrade
      
      item.base_value = curr_value
      curr_value += increment_value
      item.a_value = curr_value
      curr_value += increment_value
      item.b_value = curr_value
      curr_value += increment_value
      item.c_value = curr_value
      curr_value += increment_value
      item.d_value = curr_value
      curr_value += increment_value
    end
    if self.salary_board_items.map{|s| s.errors.messages if s.errors.messages.present?}.compact.present?
      errors.add(:created_at, :blank)
    end
  end
end
