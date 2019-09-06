class CreateIndividualGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_goals do |t|
      t.references :employee, foreign_key: {to_table: :next_sgad_employees}, index: true
      t.decimal :individual_value, nul: false, default: 0.0
      t.decimal :supervisor_value, nul: false, default: 0.0
      t.decimal :pca_value, nul: false, default: 0.0
      t.references :pertence, polymorphic: true

      t.timestamps
    end
    # carregar o menu
    Plugin.generate_side_menu true
  end
end
