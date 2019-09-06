class CreateEmployeeChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_chapters do |t|
      t.references :employee_course, foreign_key: true
      t.references :chapter, foreign_key: true
      t.integer :status, default: 0, null: false


      t.timestamps
    end

    add_reference :employee_lessons, :employee_chapter, foreign_key: true, index: true
    add_reference :employee_exams , :employee_chapter, foreign_key: true, index: true
  end
end
