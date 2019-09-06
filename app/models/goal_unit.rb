class GoalUnit < NextSgad::GoalUnit
  enum status: {active: 0, inactive: 1}

  validates_presence_of :singular_name, :plural_name
end
