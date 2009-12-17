class Admin::FeaturesController < AdminController
  before_filter :authorization
  before_filter :find_owner
  add_breadcrumb "Features", "admin_features_path", :only => [ :index ]
  
  def new
    unless @image
      unless @owner.images.empty? or !@owner.features.empty?
        feature = @owner.features.new
        feature.save
      else
        flash[:notice] = "\"#{@owner.title}\" must have attached images to be featured on the homepage."
        redirect_to [:new, :admin, @owner, :image]
      end
    else
      @owner.features.new.save
    end
  end
  
  def create
    unless @image
      unless @owner.images.empty? or !@owner.features.empty?
        feature = @owner.features.new
        feature.save
        # flash[:notice] = "#{feature.featurable_type} \"#{@owner.title}\" is now featured on the homepage."
      else
        flash[:notice] = "#{feature.featurable_type} \"#{@owner.title}\" must have attached images to be featured on the homepage."
        redirect_to [:admin, feature.featurable]
      end
    else
      @owner.features.new.save
    end
  end
    
  def destroy
    @owner.features.first.destroy
  end

  
  def index
    @features = Feature.find(:all, :order => :position)
  end
  
  def reorder
    params["features"].each_with_index do |id, position|
      Feature.update(id, :position => position + 1)
    end
    render :nothing => true
  end
  
  private
  
  def find_owner
    if params[:article_id]
      @owner = Article.find params[:article_id]
    elsif params[:gallery_id]
      @owner = Gallery.find params[:gallery_id]
    elsif params[:product_id]
      @owner = Product.find params[:product_id]
    elsif params[:event_id]
      @owner = Event.find(params[:event_id])
    elsif params[:link_id]
      @owner = Link.find(params[:link_id])
    elsif params[:page_id]
      @owner = Page.find_by_permalink params[:page_id]
    elsif params[:image_id]
      @owner = Image.find_by_id params[:image_id]
      @image = true
    end
  end
  
  def authorization
    authorize(@permissions['features'], "Features")
  end
  
end
