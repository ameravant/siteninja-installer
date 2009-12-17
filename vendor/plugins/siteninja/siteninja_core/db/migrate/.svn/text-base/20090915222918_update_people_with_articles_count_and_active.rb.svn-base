class UpdatePeopleWithArticlesCountAndActive < ActiveRecord::Migration
  def self.up
    add_column :people, :articles_count, :integer, :default => 0
    for person in Person.all
      person.update_attributes(:articles_count => person.user.articles_count)
    end
    remove_column :users, :articles_count
    add_column :people, :active, :boolean, :default => true
  end

  def self.down
    add_column :users, :articles_count, :integer, :default => 0
    for user in User.all
      user.update_attributes(:articles_count => user.person.articles_count)
    end
    remove_column :people, :articles_count
    remove_column :people, :active
  end
end
