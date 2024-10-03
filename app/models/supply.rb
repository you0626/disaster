class Supply < ApplicationRecord
  belongs_to :user

  class Supply < ApplicationRecord
    validates :name, presence: true
    validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :category, presence: true, inclusion: { in: ['necessary', 'stock'] }
  end
end