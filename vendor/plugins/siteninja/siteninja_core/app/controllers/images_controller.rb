class ImagesController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  add_breadcrumb "Home", "root_path"
  
  def show
    if params[:article_id]
      @owner = Article.find params[:article_id]
      @page = Page.find_by_permalink!('blog')
      @article_categories = ArticleCategory.active
      @article_archive = Article.published.group_by { |a| [a.published_at.month, a.published_at.year] }
      @article_authors = User.active.find(:all, :conditions => "articles_count > 0")
      @article_tags = Article.published.tag_counts.sort_by(&:name)
      add_breadcrumb 'Articles', blog_path
      add_breadcrumb @owner.title, @owner
    elsif params[:gallery_id]
      @owner = Gallery.find params[:gallery_id]
      @galleries = Gallery.public
      @page = Page.find_by_permalink!('galleries')
      add_breadcrumb "Galleries", galleries_path
      add_breadcrumb @owner.title, @owner
    elsif params[:product_id]
      @owner = Product.find params[:product_id]
      @page = Page.find_by_permalink!('products')
    elsif params[:page_id]
      @owner = Page.find_by_permalink params[:page_id]
      @page = Page.find_by_permalink!(@owner.permalink)
      add_breadcrumb @owner.title, @owner
    end
    @image = Image.find_by_id(params[:id])
    @previous_image = @owner.images.find(:first, :conditions => {:position => (@image.position.to_i - 1)})
    @next_image = @owner.images.find(:first, :conditions => {:position => (@image.position.to_i + 1)})
    add_breadcrumb @image.image_title
  end
end
