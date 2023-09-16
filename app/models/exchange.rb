class Exchange < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :categories, join_table: :categories_exchanges
  validates :name, presence: true
  validates :categories, presence: { message: 'must select at least one category' }
  validates :amount, presence: true, numericality: { only_integer: true }
end
