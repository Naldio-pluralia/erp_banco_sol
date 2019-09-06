class FunctionAutonomyLevel < ApplicationRecord
    has_and_belongs_to_many :functions, association_foreign_key: :next_sgad_function_id, foreign_key: :function_autonomy_level_id, class_name: Function.name
    validates_presence_of :name
    validates_uniqueness_of :name
end
