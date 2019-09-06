class CreateFunctionSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :function_settings do |t|
      t.integer :max_chairman_number, default: 1, null: false

      t.timestamps
    end
    FunctionSetting.create
  end
end
