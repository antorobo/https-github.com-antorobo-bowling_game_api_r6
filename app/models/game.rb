class Game < ApplicationRecord
  has_many :throws, dependent: :destroy

  def scoreboard
    Hash.new.tap do |score|
      score[:game_id] = id
      score[:pins] = throws.where(throwId:[1..20]).sum(:pins)
      score[:bonus_points] = throws.where(throwId:[1..20]).sum"(bonus1) + (bonus2)"
      score[:total_score] = score[:pins] + score[:bonus_points]
      score[:status] = throws.last.game_complete==1 ? "Game Over" : "Game On"
    end
  end
end
