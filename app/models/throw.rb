class Throw < ApplicationRecord
  belongs_to :game
  validates :pins, presence: true
  validates_with SpecialValidator, on: :create # for validating second throw of a frame and game is over or not
  before_create :calculate_params


  private


  def calculate_params
    #set initial throwId
    self.throwId = (Throw.all.where game_id:self.game_id).maximum(:throwId).to_i+1
    #correct throwId if there was a strike called for the previous frame

    if self.throwId > 1 && previous_throw.throwId % 2 != 0 && previous_throw.frame_complete == 1
      self.throwId +=1
    end
    #binding.pry
    #set frameId
    first_throw ? (self.frameId = (Throw.all.where game_id:self.game_id).maximum(:frameId).to_i+1 ):( self.frameId = (Throw.all.where game_id:self.game_id).maximum(:frameId).to_i)
    #set frame_score
    first_throw ? self.frame_score = self.pins : self.frame_score = (previous_throw.pins + self.pins)
    #set special calls for strike
    first_throw && self.pins == 10 ? self.special_calls = 2 : 0
    #set frame complete if its a strike
    first_throw && self.pins == 10 ? self.frame_complete = 1 : 0
    #set special calls for spare
    !first_throw && self.pins < 10 && self.frame_score >= 10 ? self.special_calls = 1 : 0
    #set frame complete if its the second throw
    !first_throw ? self.frame_complete = 1 : 0
    #binding.pry

    # bonus for spare

    prev_throw
    if self.throwId > 2 && previous_throw&.special_calls == 1
      prev_throw.update(bonus1:self.pins)
    end
    # bonus for strike   previous frames last throw(whether 1st or 2nd throw)
    if self.throwId > 2 && prev_throw.special_calls == 2 && prev_throw.bonus1 == 0
      #binding.pry
      prev_throw.update(bonus1:self.pins)
    end
    #bonus for strike    if second throw of frame
    if self.throwId > 3 && self.throwId % 2 == 0 && prev_throw.special_calls == 2 && prev_throw.bonus2 == 0
      #binding.pry
      prev_throw.update(bonus2:self.pins)
    end
    #bonus for strike
    previous_2throw
    if self.throwId > 4 && self.throwId % 2 != 0 && previous_2throw.special_calls == 2 && previous_2throw.bonus2 == 0
      #binding.pry
      previous_2throw.update(bonus2:self.pins)
    end


    #setting end of game marker

    #end of game at throw 20
    self.throwId == 20 && self.frame_score < 10 ? self.game_complete = 1 : 0
    # end of game at throw 21
    self.throwId > 20 && prev_throw.special_calls == 1 ? self.game_complete = 1 : 0
    # end of game ar throw above 21
    self.throwId > 21 ? self.game_complete = 1 : 0

  end

  def first_throw
    self.throwId % 2 != 0
  end

  def previous_throw
    Throw.where(game_id:self.game_id,throwId:self.throwId-1)[0]
  end

  def prev_frmId
    self.frameId-1
  end

  def prev_throw
    #binding.pry
    Throw.all.where(game_id:self.game_id, frameId:prev_frmId).last
  end

  def prev_2frmId
    self.frameId-2
  end

  def previous_2throw
    Throw.all.where(game_id:self.game_id, frameId:prev_2frmId).last
  end


end