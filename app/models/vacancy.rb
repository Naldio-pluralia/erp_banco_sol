class Vacancy < ApplicationRecord
  has_many :applications, dependent: :destroy
  enum status: {active: 0, inactive: 1}
  enum target: {both: 0, internal: 1, external: 2}
  enum contract_type: { to_define: 0, fixed_term: 1, internship: 2}
                      #   indefinite_duration: 2,
                      #   job_type: 3, full_time: 4, permanent: 5, contract: 6,
                      #   temporary: 7, part_time: 8, freelance: 9, internship: 10,
                      #   casual: 11, fly_in_fly_out: 12
                      # }



  validates_presence_of :position, :status, :target, :contract_type, :offer_ends_at, :year_of_experience, :country, :province, :city, :job_description
  validate :validate_offer_end, on: :create
  before_create :generate_number

  def validate_offer_end
    return unless offer_ends_at.present?
    if offer_ends_at.to_date <= Date.current
      errors.add(:offer_ends_at, errors_t(:offer_ends_at, :after_todays_date))
    end
  end

  def present_number
    "BS#{format('%03d', number)}-#{created_at.year}" rescue number
  end

  def generate_number
    latest_n = Vacancy.where('extract(year from created_at) = ?', DateTime.now.year).map{|n| n.number.to_i rescue 0}.sort.last || 0
    self.number = latest_n + 1
  end

end
