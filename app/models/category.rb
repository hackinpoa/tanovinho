class Category < ActiveRecord::Base
  before_validation :create_slug, if: :name_changed?

  private

  def create_slug
    name_parameterized = self.name.parameterize
    while Category.where(slug: name_parameterized).count > 0 do
      name_parameterized = name_parameterized + "-1"
    end
    self.slug = name_parameterized
  end
end
