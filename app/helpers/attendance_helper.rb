
module AttendanceHelper
  def justification_status(obj)
    if obj.status == "pending"
      return "Pendente"
    else
      return obj
    end
  end
end