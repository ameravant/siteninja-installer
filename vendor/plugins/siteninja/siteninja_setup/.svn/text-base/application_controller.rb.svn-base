class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  include AuthenticatedSystem
  filter_parameter_logging :password
  before_filter :get_siteninja_config
  before_filter :cms_for_layout, :only => [ :index, :show, :new, :create, :edit, :update, :comment ]
  
   $USA_STATES_ARRAY = [['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'], ['California', 'CA'], ['Colorado', 'CO'], ['Connecticut', 'CT'], ['Delaware', 'DE'], ['District of Columbia', 'DC'], ['Florida', 'FL'], ['Georgia', 'GA'], ['Hawaii', 'HI'], ['Idaho', 'ID'], ['Illinois', 'IL'], ['Indiana', 'IN'], ['Iowa', 'IA'], ['Kansas', 'KS'], ['Kentucky', 'KY'], ['Louisiana', 'LA'], ['Maine', 'ME'], ['Maryland', 'MD'], ['Massachusetts', 'MA'], ['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'], ['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], ['New Hampshire', 'NH'], ['New Jersey', 'NJ'], ['New Mexico', 'NM'], ['New York', 'NY'], ['North Carolina', 'NC'], ['North Dakota', 'ND'], ['Ohio', 'OH'], ['Oklahoma', 'OK'], ['Oregon', 'OR'], ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'], ['South Carolina', 'SC'], ['South Dakota', 'SD'], ['Tennessee', 'TN'], ['Texas', 'TX'], ['Utah', 'UT'], ['Vermont', 'VT'], ['Virginia', 'VA'], ['Washington', 'WA'], ['Wisconsin', 'WI'], ['West Virginia', 'WV'], ['Wyoming', 'WY']] unless const_defined?('USA_STATES_ARRAY')
  
  protected
  
  def add_breadcrumb(name, url = '')
    @breadcrumbs ||= []
    name = eval(name) if name =~ /_path|_url|@/  
    url = eval(url) if url =~ /_path|_url|@/  
    @breadcrumbs << [name, url]  
  end  

  def self.add_breadcrumb(name, url, options = {})
    before_filter options do |controller|  
      controller.send(:add_breadcrumb, name, url)  
    end  
  end  
  
  private 
  
  def cms_for_layout
    @menu = Page.visible
    @settings = Setting.first
    @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
    session[:template] = params[:template][:id] if params[:template]
    @templates = ["demo", "t3c2", "t3c3", "t3c4", "t3c5", "t3c6", "t3c7", "t4c1", "t4c2", "t4c3", "t4c4", "t5c2", "t5c3", "t5c4", "t5c5", "t5c6", "t5c7"] if @cms_config['website']['demo']
  end
  
  def get_siteninja_config
    @cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    @permissions = YAML::load_file("#{RAILS_ROOT}/config/permissions.yml")
  end
  
  # Used in all administrative controllers to determine whether or not a user has access to it.
  def authorize(controller_access, controller_title)
    if current_user
      unless current_user.has_role(controller_access)
        flash[:error] = "You do not have access to #{controller_title}."
        begin
          redirect_to(:last)
        rescue
          redirect_to("/")
        end
      end
    else
      redirect_to(new_session_path)
    end
  end
  
end
