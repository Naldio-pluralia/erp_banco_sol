class AddIsSystemAbsenceToAbsenceTypes < ActiveRecord::Migration[5.1]
  def up
    add_column :absence_types, :is_system_absence, :boolean, default: false, null: false
    AbsenceType.create!(name: 'Falta Automática', is_system_absence: true, kind: :absence, description: 'Ausência criada pelo sistema')
  end

  def down
    remove_column :absence_types, :is_system_absence
  end
end
