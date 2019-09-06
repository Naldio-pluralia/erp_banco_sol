class SettingsController < ApplicationController
  before_action :authenticate_account!
  load_and_authorize_resource
  def show
  end

  def edit
    @config = Setting.last
  end
end
