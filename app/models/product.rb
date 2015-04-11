class Product < ActiveRecord::Base
  include Priceable
 
  attachment :product_image
  acts_as_taggable
  before_validation :create_slug, if: :name_changed?
  belongs_to :user

  def price=(val)
    super(price_to_number val)
  end

  private

  def create_slug
    name_parameterized = self.name.parameterize
    while Category.where(slug: name_parameterized).count > 0 do
      name_parameterized = name_parameterized + "-1"
    end
    self.slug = name_parameterized
  end

end
