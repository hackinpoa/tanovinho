class Purchase < ActiveRecord::Base
  before_validation :set_value
  belongs_to :user
  belongs_to :product

  private
    def set_value
      self.value = self.product.price
    end
end
