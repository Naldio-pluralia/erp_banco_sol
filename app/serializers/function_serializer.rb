class FunctionSerializer < ActiveModel::Serializer
  attributes *Function.column_names
end
