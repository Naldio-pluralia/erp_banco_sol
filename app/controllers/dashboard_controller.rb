class DashboardController < ApplicationController
  before_action :authenticate_account!

  def index
    # redirect_to root_url unless user_signed_in?
    @assessment = Assessment.active.last
    
    if current.is?(:employee)

      @employees = current.team_members
      return unless @assessment.present?
      @skills = current.employee.get_function_employee_skills.includes(:skill).sort_by{|s| s.skill.name}
      #@employee_goals = current.employee.employee_goals.where(goal_id: @assessment.goals.map(&:id)) antigo recurso
      @employee_goals = current.employee.get_function_employee_skills.includes(:skill).sort_by{|s| s.skill.name}

      @my_chart_data = {labels: [], datasets: []}
      @team_chart_data = {labels: [], datasets: []}
      my_dataset = {data: [], border_color: '#f9b232', background_color: 'rgba(255, 238, 100, 0.49)', border_width: 2, label: current.user.full_name, line: {tension: '100'}}

      @skills.each do |skill|
        @my_chart_data[:labels] << skill.skill.name.truncate(8)
        my_dataset[:data] << skill.value
      end

      @eg = {}
      @employee_hash = current.team_members.index_by(&:id)
      @skills.each do |skill|
        @team_chart_data[:labels] << skill.skill.name
        skill.skill.employee_skills.each do |employee_skill|
          next unless @employee_hash[employee_skill.employee_id].present?
          @eg[employee_skill.employee_id] = {data: [], border_color: "rgb(#{employee_skill.employee_id}, 39, 176)", background_color: "rgba(#{employee_skill.employee_id}, 39, 176, 0.1)", border_width: '2', label: "#{@employee_hash[employee_skill.employee_id].first_name} #{@employee_hash[employee_skill.employee_id].last_name}", line: {tension: '100'}} if @eg[employee_skill.employee_id].nil?
          @eg[employee_skill.employee_id][:data] << employee_skill.value
        end
      end
      @team_spider_data = RadarChartData.new(@skills.map {|g| [[g.skill.name.truncate(10), "#{g.employee.first_name} #{g.employee.last_name}"], g.value]}.to_h).get_data
      @team_chart_data[:datasets] = @eg.values
      @my_chart_data[:datasets] << my_dataset

      @attendances_data = RadarChartData.new(Attendance.all.order(date: :asc).group_by {|a| [t(a.date.strftime('%B')), t(a.status)]}).get_data
      @department_attendances_data = RadarChartData.new(current.department.attendances.order(date: :asc).group_by {|a| [t(a.date.strftime('%B')), t(a.status)]}).get_data if current.department&.present?
      @my_attendances_data = RadarChartData.new(current.position.attendances.order(date: :asc).group_by {|a| [t(a.date.strftime('%B')), t(a.status)]}).get_data if current.position&.present?

      @my_objectives_list = @assessment.employee_goals.objective.where(employee_id: current.employee.id)

    else

    end


  end
end
