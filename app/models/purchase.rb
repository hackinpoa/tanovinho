class Purchase < ActiveRecord::Base
  after_initialize :init
  before_validation :set_value
  belongs_to :user
  belongs_to :product

  private
    def init
      self.status = 'created'
    end

    def set_value
      self.value = self.product.price
    end
end
