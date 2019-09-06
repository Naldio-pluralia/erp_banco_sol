class Pelouro < ApplicationRecord
  belongs_to :employee
  has_many :directorates
  has_many :organic_units
  validates_presence_of :employee_id, :name, :abbreviation, :title, :title_abbreviation
  validates_uniqueness_of :employee_id, :name, :abbreviation, :title, :title_abbreviation
  validate :validates_max_number_of_chairman

  def validates_max_number_of_chairman
    return unless is_chairman
    max_chairman_number = FunctionSetting.latest.max_chairman_number
    charman_size = Pelouro.all.where(is_chairman: true).where.not(id: id).size
    if charman_size >= max_chairman_number
      errors.add(:is_chairman, "Já Atingiu o número máximo de PCAs")
    end
  end

  def name_and_abbr
    "#{name} (#{abbreviation})"
  end

  def title_and_abbr
    "#{title} (#{title_abbreviation})"
  end
end
