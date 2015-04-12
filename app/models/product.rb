class Product < ActiveRecord::Base
  include Priceable
  validates :name, :description, :price, :price_paid, presence: true
  validate :has_correct_price?
  attachment :product_image
  acts_as_taggable
  before_validation :create_slug, if: :name_changed?
  belongs_to :user

  def has_correct_price?
    if price >= price_paid
      errors.add(:price, 'O preço de venda deve ser menor que o preço que você pagou')
    end
  end

  def self.condition_options
    (1..5)
  end

  def self.filter(filter_params)
    products = self.all


    conditions = (filter_params['condition'] || {}).select { |k, v| v == "1" }.keys.map(&:to_i)
    if conditions.any?
      conditions = filter_params['condition'].select { |k, v| v == "1" }.keys.map(&:to_i)
      products = products.where('condition in (:conditions)', {conditions: conditions})
    end

    products
  end

  def price=(val)
    super(price_to_number val)
  end

  def price_paid=(val)
    super(price_to_number val)
  end

  def saving
    ( 1 - ( price / price_paid ) ) * 100
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
