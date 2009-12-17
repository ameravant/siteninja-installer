class TestimonialsController < ApplicationController
  before_filter :find_owner_and_get_page
  
  
  def index
    add_breadcrumb "Testimonials"
    @testimonials = @owner.testimonials
  end
  
  def show
    add_breadcrumb "Testimonial"
    @testimonial = Testimonial.find(params[:id])
  end
  
  def find_owner_and_get_page
    @page = Page.find_by_permalink!("testimonials")
    add_breadcrumb "Home", root_path
    if params[:article_id]
      @owner = Article.find(params[:article_id])
      add_breadcrumb @cms_config['site_settings']['blog_title'], blog_path
    elsif params[:gallery_id]
      @owner = Gallery.find(params[:gallery_id])
    elsif params[:product_id]
      @owner = Product.find(params[:product_id])
    elsif params[:page_id]
      @owner = Page.find_by_permalink(params[:page_id])
      @page = Page.find_by_permalink(params[:page_id])
      add_breadcrumb @page.title, "/#{@page.permalink}"
    else
      @owner = Page.find_by_permalink("testimonials")
    end
    
    #build sidebar based on owner model
    if @owner.kind_of?(Page)
      articles = Article.published
      @article_categories = ArticleCategory.active
      @article_archive = articles.group_by { |a| [a.published_at.month, a.published_at.year] }
      @article_authors = Person.active.find(:all, :conditions => "articles_count > 0")
      @article_tags = articles.tag_counts.sort_by(&:name)
      @recent_articles = articles[0...5]
      if @page.show_events? and @cms_config['modules']['events']
        @events = Event.future[0..2]
      end
      unless @owner.permalink == "testimonials"
        add_breadcrumb @owner.title, @owner unless @owner == @page
      end
    elsif @owner.kind_of?(Article)
      @article_categories = ArticleCategory.active
      @article_archive = Article.published.group_by { |a| [a.published_at.month, a.published_at.year] }
      @article_authors = Person.active.find(:all, :conditions => "articles_count > 0")
      @article_tags = Article.published.tag_counts.sort_by(&:name)
    elsif @owner.kind_of?(Product)
      
    elsif @owner.kind_of?(Gallery)
      
    end
  end
end
