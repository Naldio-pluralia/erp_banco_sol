class CourseOptionalFunctionSerializer < ActiveModel::Serializer
  attributes :id
  has_one :course
  has_one :function
end
