class Category < ActiveRecord::Base
  extend ActsAsTree::TreeView
  
  before_validation :create_slug, if: :name_changed?
  acts_as_tree order: 'name'

  private

  def create_slug
    name_parameterized = self.name.parameterize
    while Category.where(slug: name_parameterized).count > 0 do
      name_parameterized = name_parameterized + "-1"
    end
    self.slug = name_parameterized
  end
end
