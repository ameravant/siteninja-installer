class Admin::ImagesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_viewable
  before_filter :find_image, :except => [ :new, :create, :reorder, :index ]
  
  def index
    add_breadcrumb "Images"
    @images = @owner.images.sort_by(&:position)
    if @owner.images_count.blank?
      redirect_to [:new, :admin, @owner, :image]
    end
  end

  def new
    add_breadcrumb "Images", [:admin, @owner, :images]
    add_breadcrumb "New"
    @image = @owner.images.new
  end
  
  def create
    @image = @owner.images.build(params[:image])
    unless @owner.images_count < 2
      @image.position = @owner.images.maximum('position') + 1
    end
    if @image.save
      added_to = @title
      redirect_path = [:admin, @owner, :images]
      flash[:notice] = "Image added to #{added_to}"
      redirect_to redirect_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb "Images", [:admin, @owner, :images]
    add_breadcrumb "Edit"
  end
  
  def update
    if @image.update_attributes(params[:image])
      @image = @owner.images.build(params[:image])
      added_to = @owner.title
      redirect_path = [:admin, @owner, :images]
      flash[:notice] = "Image updated!"
      redirect_to redirect_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @image.destroy
    respond_to :js
  end
    
  def reorder
    params["images"].each_with_index do |id, position|
      Image.update(id, :position => position + 1)
    end
    render :nothing => true
  end
  
  private
  
    def find_viewable
      if params[:article_id]
        @owner = Article.find(params[:article_id])
        add_breadcrumb "Articles", admin_articles_path
      elsif params[:gallery_id]
        @owner = Gallery.find(params[:gallery_id])
        add_breadcrumb "Galleries", admin_galleries_path
      elsif params[:product_id]
        @owner = Product.find(params[:product_id])
        add_breadcrumb "Products", admin_products_path
      elsif params[:event_id]
        @owner = Event.find(params[:event_id])
        add_breadcrumb "Events", admin_events_path
      elsif params[:link_id]
        @owner = Link.find(params[:link_id])
        add_breadcrumb "Links", admin_links_path
      elsif params[:page_id]
        @owner = Page.find_by_permalink(params[:page_id])
        add_breadcrumb "Pages", admin_pages_path
      elsif params[:person_id]
        @owner = Person.find(params[:person_id])
        add_breadcrumb "People", admin_people_path
        @owner.title = @owner.name
      elsif params[:newsletter_id]
        @owner = Newsletter.find(params[:newsletter_id])
        add_breadcrumb "Newsletters", admin_newsletters_path
      end
      add_breadcrumb @owner.title, [:edit, :admin, @owner]
    end
    
    def find_image
      @image = Image.find params[:id]
    end
    
    def authorization
      authorize(@permissions['images'], "Images")
    end
    
end
