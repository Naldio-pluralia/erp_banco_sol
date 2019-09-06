class Directorate < ApplicationRecord
  belongs_to :pelouro, optional: true
  belongs_to :directorate_area
  has_many :functions, dependent: :restrict_with_exception
  validates_presence_of :name, :abbreviation
  validates_uniqueness_of :name, :abbreviation
  def p_name
    "(#{abbreviation}) #{name}"
  end
  def abbreviation
    super.present? ? super.upcase : nil
  end
end
