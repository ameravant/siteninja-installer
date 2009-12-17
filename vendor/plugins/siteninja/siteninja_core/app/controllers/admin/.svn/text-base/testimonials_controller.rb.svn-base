class Admin::TestimonialsController < AdminController
  before_filter :authorization
  before_filter :find_owner
  before_filter :find_testimonial , :only => [:edit, :update, :destroy]
  add_breadcrumb "Testimonials", "admin_testimonials_path", :only => [ :index ]

  def new
    add_breadcrumb "New"
    @testimonial = @owner.testimonials.new
  end

  def update
    if @testimonial.update_attributes(params[:testimonial])
      redirect_path = [:admin, @owner, :testimonials]
      flash[:notice] = "The testimonial has been updated."
      redirect_to redirect_path
    else
      render :action => "edit"
    end
  end

  def create
    @testimonial = @owner.testimonials.build(params[:testimonial])
    if @testimonial.save
      redirect_path = [:admin, @owner, :testimonials]
      flash[:notice] = "Testimonial added to #{@owner.title}"
      redirect_to redirect_path
    else
      render :action => "new"
    end
  end

  def destroy
    @testimonial.destroy
    # flash[:notice] = "#{testimonial.quotable_type} \"#{@owner.title}\" has been removed from the homepage."
  end


  def index
    if @owner != nil
      @testimonials = @owner.testimonials
    else
      @testimonials = Testimonial.find(:all)
    end
  end

  def reorder
    params["testimonials"].each_with_index do |id, position|
      Testimonial.update(id, :position => position + 1)
    end
    render :nothing => true
  end

  private

  def find_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def find_owner
    if params[:article_id]
      @owner = Article.find params[:article_id]
    elsif params[:gallery_id]
      @owner = Gallery.find params[:gallery_id]
    elsif params[:product_id]
      @owner = Product.find params[:product_id]
    elsif params[:page_id]
      @owner = Page.find_by_permalink params[:page_id]
    end
  end
  
  def authorization
    authorize(@permissions['testimonials'], "Testimonials")
  end
  
end

