class Account < ApplicationRecord
  self.abstract_class = true
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :role, foreign_key: :account_id, dependent: :destroy
  enum roles_mask: Role.roles_masks
  #
  attr_accessor :login, :temporary_password
  mount_uploader :avatar, AvatarUploader

  # true if employee is from hr
  def hr?
    hr_admin? || hr_supervisor? || hr_employee?
  end

  def toogle_menu
    self.update_columns(is_menu_minimized: !self.is_menu_minimized)
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def first_and_last_name
    "#{first_name} #{last_name}"
  end

  def full_abbr_name
    "#{first_name} #{last_name}"
  end

  # creates a user
  def create_user(current)
    self.temporary_password = rand(2**256).to_s(36).ljust(1, 'a')[0..9]
    self.password = temporary_password
    self.password_confirmation = temporary_password
    # TODO send password to employee's email or admin's email
    UserMailer.welcome_email(self, self.temporary_password) if save
  end

  # resets the passwor and sends it to the user
  def reset_and_send_password(current = nil)
    self.temporary_password = rand(2**256).to_s(36).ljust(1, 'a')[0..9]
    self.password = temporary_password
    self.password_confirmation = temporary_password
    UserMailer.password_reset(self, temporary_password).deliver_later if save
  end

  def generate_password(current = nil)
    self.temporary_password = rand(2**256).to_s(36).ljust(1, 'a')[0..9]
    self.password = temporary_password
    self.password_confirmation = temporary_password
    self.save
    # TODO send password to admin's email or displays it on screen
    # UserMailer.password_generate(self, temporary_password) if save
    self.temporary_password
  end

  # create role if user doesnt have one
  def create_rolebundle update
    return if self.role.present?
    role = Role.new(account_id: self.id, account_type: self.class.name)
    role.save
  end

  # list all routes
  def self.all_routes
    Rails.application.routes.routes.map {|r| r unless r.defaults[:controller].blank? || r.defaults[:controller].eql?('uploads') || r.defaults[:controller].includes?('rails/', 'users/', 'dashboard', 'admins', 'application', 'settings') || r.defaults[:action].eqls?('edit', 'new')}.compact.uniq
  end

  # get all routes grouped by the controller
  def self.all_routes_grouped
    all_routes.group_by {|r| r.defaults[:controller]}
  end

  def set_roles
    if role.present?
      role&.update_columns(permissions: permissions, roles_mask: roles_mask)
    else
      Role.create(premissions: permissions, roles_mask: roles_mask, account_id: id, account_type: self.class.name)
    end
  end


  def configure_permissions
    self.permissions = permissions.each {|p| p unless p.split(',').compact.uniq.blank?}.compact.uniq
  end

  validates :cellphone, format: {with: CELLPHONE_REGEX}, if: ->(account) {account.cellphone.present?}
  after_save :create_role
  before_save :configure_permissions
end
