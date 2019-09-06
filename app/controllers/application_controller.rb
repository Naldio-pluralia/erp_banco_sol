class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :null_session, prepend: true
  before_action :check_position, except: [:pick_position, :select_position]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_page_name
  attr_accessor :dom_id
  include ApplicationHelper
  helper_method :xeditable?, :curr_date


  # What to do after redirecting
  rescue_from CanCan::AccessDenied do |exception|
    # p exception.action
    # p exception.subject
    flash[:error] = :not_allowed_to_execute_this_action.ts
    redirect_to not_allowed_url
  end

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password, :last_name, :middle_name, :first_name, :avatar, :login, :email, :cellphone]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def toogle_menu
    current_account&.toogle_menu()
    respond_to do |format|
      format.json { render json: {} }
    end
  end

  def check_position
    redirect_to employee_pick_position_path(current.employee.id) if current.employee.present? && current.position.nil?
  end

  def set_helper_params # Link para a pagina anterior
    @redirect_to = params[:redirect_to]

    if @redirect_to.present?
      @redirect_to = nil unless @redirect_to.first(4).eql?('http')
    end

    @redirect_to = nil if @redirect_to.eql?('')
    # pega o link para voltar mandado por parâmetro
    @link_back_for = params[:link_back_for]
  end

  def set_page_name
    @page_name = t("pages.#{params[:controller].gsub('/', '.')}.#{params[:action]}", default: [:"pages.defaults.#{params[:action]}", ''])
  end

  def controller_t(key, options = {})
    if key.to_s.first == "."
      path = controller_path.gsub("/", ".")

      key = "#{path}.#{action_name}#{key}"
      default = [key.split('.').first, 'defaults', key.split('.').last].join('.').to_sym
      controllers_default = ['controllers_defaults', key.split('.').last].join('.').to_sym
      last_default = key.split('.').last.to_s.humanize.split.map(&:capitalize).join(' ')
      options[:default] ||= [controllers_default, default, last_default]
    end
    I18n.translate(key, options)
  end

  def resolve_layout
    if params[:layout_type].blank? && action_name.include?('partial_view_')
      'partial_view_application'
    elsif params[:layout_type] == 'no_layout'
      false
    elsif params[:layout_type].present?
      params[:layout_type]
    else
      'application'
    end
  end

  def resolve_render(default_action = params[:action].to_sym)
    params[:render_view].present? ? params[:render_view].to_sym : default_action
  end

  def _l
    l_name = false
    if params[:_l] == 'no_layout'
      l_name = false
    elsif params[:_l].blank?
      l_name = 'application'
    else
      l_name = params[:_l]
    end
  end

  def curr_date
    if params[:period].present?
      month, year = params[:period].split('/')
      DateTime.new(year.to_i, month.to_i)
    else
      DateTime.now
    end
  end

  def xeditable? object = nil
    true # Or something like current_user.xeditable?
  end
end
