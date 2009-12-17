module ImagePathsHelper

  def spinner_loc
    "#{icon_domain}/plugin_assets/siteninja_core/images/spinner.gif"
  end
  
  def ok_loc
    "#{icon_domain}/plugin_assets/siteninja_core/images/icons/green/16x16/Ok.png"
  end
  
  def move_loc
    "#{icon_domain}/plugin_assets/siteninja_core/images/icons/gray/16x16/Direction Vert.png"
  end
  
  def icons_loc
    "#{icon_domain}/plugin_assets/siteninja_core/images/icons"
  end
  
  def exclamation_loc
    "#{icon_domain}/plugin_assets/siteninja_core/images/icons/red/16x16/Exclamation.png"
  end
  
  def trash_loc
    "#{icon_domain}/plugin_assets/siteninja_core/images/icons/gray/16x16/Trash.png"
  end
  
  def icon_domain
    YAML::load_file("#{RAILS_ROOT}/config/cms.yml")['website']['icon_domain']
  end

end