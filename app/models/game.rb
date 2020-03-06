class Game < ApplicationRecord
  has_many :throws, dependent: :destroy
end
