class SocialSecurityTaxSalary < ApplicationRecord
  belongs_to :salary
  belongs_to :social_security_tax
end
