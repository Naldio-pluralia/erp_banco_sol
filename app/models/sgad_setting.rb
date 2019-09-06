class SgadSetting < NextSgad::Setting
  # This class can't be instantiated... accessing the singleton is done using the 'instance' method
  # such as: Setting.instance
  #
  # in the same matter the 'add' method is done by calling it on the instance
  # such as: Setting.instance.add "is_active", true
  # 
end
