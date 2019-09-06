class SalaryGrid < ApplicationRecord
  has_many :salary_families
  validates_presence_of :number, :code
  validates_uniqueness_of :number, scope: [:code]
  validates_numericality_of :number, greate_than: 0
  before_create :set_values

  def gs
    "GS#{number}"
  end

  def self.latest 
    where(code: SalaryGrid.maximum(:code))
  end

  def set_values
    remuneration_setting = RemunerationSetting.last
    base_value = remuneration_setting&.base_salary || 0
    update_factor = remuneration_setting&.update_factor || 0
    if number == 1
      self.value_100 = base_value
    else
      self.value_100 = (2..number).inject(base_value){|acc, n| acc = acc.plus_x_percent(update_factor).x_percent(100, 80)}
    end
    self.value_80 = value_100.x_percent(80)
    self.value_105 = value_100.x_percent(105)
    self.value_110 = value_100.x_percent(110)
    self.value_115 = value_100.x_percent(115)
    self.value_120 = value_100.x_percent(120)
    self.value_125 = value_100.x_percent(125)
  end
end
