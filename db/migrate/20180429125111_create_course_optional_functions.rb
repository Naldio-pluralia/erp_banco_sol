class CreateCourseOptionalFunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :course_optional_functions do |t|
      t.references :course, foreign_key: true
      t.references :function, foreign_key: {to_table: :next_sgad_functions}

      t.timestamps
    end
  end
end
