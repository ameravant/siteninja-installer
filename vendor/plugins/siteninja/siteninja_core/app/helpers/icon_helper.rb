module IconHelper
  
  # Spinner icon to use in hidden divs for AJAX feedback.
  def spinner
    image_tag spinner_loc, :id => "ajax_spinner", :size => "16x16", :class => "icon", :alt => "One moment..."
  end

  # Outputs icon file with automatic confirm for Trash icons, let's you optionally
  # specify the size of the icon.
  def icon(filename, link=nil, alt=nil, path="#{icons_loc}/", size='16x16', color='gray')
    image_path = "#{icons_loc}/#{color}/#{size}/#{filename}.png"
    image_options = { :size => size, :class => "icon", :alt => (alt ? alt : filename) }
    if link
      myconfirm = (filename == "Trash" ? "Are you sure you want to delete this?" : nil)
      link_to image_tag(image_path, image_options), link, :class => "icon", :confirm => myconfirm
    else
      image_tag image_path, image_options
    end
  end
  
  def css_icon(filename, path="#{icons_loc}/", size='16x16', color='gray')
    "#{icons_loc}/#{color}/#{size}/#{filename}.png"
  end
  
  def large_icon(filename, link=nil, alt=nil, path="#{icons_loc}/gray/32x32", size='32x32')
    image_path = "#{path}/#{filename}.png"
    image_options = { :size => size, :class => "large-icon", :alt => (alt ? alt : filename) }
    if link
      myconfirm = (filename == "Trash" ? "Are you sure you want to delete this?" : nil)
      link_to image_tag(image_path, image_options), link, :class => "icon", :confirm => myconfirm
    else
      image_tag image_path, image_options
    end
  end
  
  # Outputs a trash icon that uses AJAX and different status icons during the delete call
  def trash_icon(record, link, record_name)
    link_to_remote(
      image_tag("#{icons_loc}/gray/16x16/Trash.png", :class => "icon", :alt => "Delete #{record_name}", :id => "#{dom_id(record)}_trash_icon"),
      {
        :url => link,
        :method => :delete,
        :loading => "$('#{dom_id(record)}_trash_icon').src = '#{spinner_loc}'",
        :failure => "$('#{dom_id(record)}_trash_icon').src = '#{exclamation_loc}'",
        :success => "$('#{dom_id(record)}_trash_icon').src = '#{ok_loc}'",
        :confirm => "Really delete #{record_name}? There is no undo!",
        :delay => 1
      }, :class => "icon")
  end
  
  # The next three icons include all featurable icon functionality
  def defeature_icon(record, link, record_name, display)
    if @cms_config['features']['feature_box']
      link_to_remote(
        image_tag("#{icons_loc}/green/16x16/Star.png", :class => "icon", :title => "Remove #{record_name} from homepage", :alt => "Remove #{record_name} from homepage", :id => "#{dom_id(record)}_defeature_icon", :style => "display: #{display};"),
        {
          :url => link,
          :method => :delete,
          :loading => "$('#{dom_id(record)}_defeature_icon').src = '#{spinner_loc}'",
          :failure => "$('#{dom_id(record)}_defeature_icon').src = '#{exclamation_loc}'",
          :success => "$('#{dom_id(record)}_defeature_icon').src = '#{icons_loc}/green/16x16/Star.png'; $('#{dom_id(record)}_defeature_icon').hide(); $('#{dom_id(record)}_feature_icon').show()",
          :delay => 1
        }, :class => "icon")
    else
      ""
    end
  end
  
  def feature_icon(record, link, record_name, display)
    if @cms_config['features']['feature_box']
      link_to_remote(
        image_tag("#{icons_loc}/red/16x16/Star.png", :class => "icon", :title => "Feature #{record_name} on homepage", :alt => "Feature #{record_name} on homepage", :id => "#{dom_id(record)}_feature_icon", :style => "display: #{display};"),
        {
          :url => link,
          :method => :create,
          :failure => "$('#{dom_id(record)}_feature_icon').src = '#{exclamation_loc}'",
          :loading => "$('#{dom_id(record)}_feature_icon').src = '#{spinner_loc}'",
          :success => "$('#{dom_id(record)}_feature_icon').src = '#{icons_loc}/red/16x16/Star.png'; $('#{dom_id(record)}_feature_icon').hide(); $('#{dom_id(record)}_defeature_icon').show()",
          :delay => 1
        }, :class => "icon")
    else
      ""
    end
  end
  
  def disabled_feature_icon(record, link, record_name)
    if @cms_config['features']['feature_box']
      link_to(image_tag("#{icons_loc}/gray/16x16/Star.png", :class => "icon", :title => "#{record_name} must have images to be featured on the homepage.", :alt => "#{record_name} must have images to be featured on the homepage.", :id => "#{dom_id(record)}_feature_icon"), link, :class => "icon")
    else
      ""
    end
  end
  
  def icon_with_text(filename, currobject, imagepath='/plugin_assets/siteninja_core/images/icons/gray/16x16', size='16x16')
    image_path = "#{imagepath}/#{filename}.png"
    image_options = { :size => size, :class => "icon", :id => "#{currobject.id}_delete_icon" }
    ajax_url = [:admin, currobject]
    confirm_text = "Really delete this?"
    case filename
      when "Trash":
        link_to_remote(image_tag(image_path, image_options), :url => ajax_url, :method => :delete, :confirm => confirm_text) + "&nbsp;" + link_to_remote("Delete", :url => ajax_url, :method => :delete, :loading => "$('#{currobject.id}_delete_icon').src = '#{spinner_loc}'", :confirm => confirm_text)
    end
  end

  # Outputs asset icon file based on filename extention.
  def asset_file_type_icon(filename, link_url)
    ext = case filename.match(/\.\w+/).to_s
      when /(aac|bmp|diz|log|mpv2|rar|ttf|wzv|ac3|bup|dll|hlp|m4a|msi|rb|txt|xls|ace|cab|doc|m4p|music|reg|uis|xlsx|ade|cat|docx|ie7|mmf|nfo|rtf|upload|xml|adp|chm|dos|ifo|mmm|one|safari|url|xsl|ai|cmd|download|inf|mov|pdd|scp|vcr|zap|aiff|css|dvd|ini|movie|pdf|search|video|zip|aspx|csv|dwg|iso|mp2|php|sql|vob|au|cue|dwt|isp|mp2v|png|swf|wba|avi|dat|emf|java|pps|sys|wma|bak|default|exc|jfif|mp4|ppt|theme|wmv|bat|der|fav|mpe|pptx|tif|wpl|bin|dic|print|tiff|wri|blue-ray|divx|font|js|psd|tmp|wtx)/: $1
      when /(gif|png|jpeg|jpg)/: "jpeg"
      when /(mpg|mpeg)/: "mpeg"
      when /fla/: "flash"
      when /htm/: "html"
      when /doc/: "word"
      when /flv/: "video"
      when /(mp3|audio)/: "ac3"
      else "default"
    end
    link_to image_tag("#{icons_loc}/file_types/#{ext}.png", :width => 48, :alt => ext.upcase), link_url, :class => "lightview", :rel => "set[assets]"
  end

end
