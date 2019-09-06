class FixVacancyReferenceOnApplication < ActiveRecord::Migration[5.1]
  def change
    remove_reference :applications, :application, foreign_key: true, index: true
    add_reference :applications, :vacancy, foreign_key: true, index: true
  end
end
