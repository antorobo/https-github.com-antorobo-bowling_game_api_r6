class SpecialValidator < ActiveModel::Validator
  def validate(record)
    #checks to see whether this particular throws pins are not crossing the 10 pins for the frame.
    if Throw.all.where(game_id:record.game_id)!=[]
      if Throw.all.where(game_id:record.game_id).last&.game_complete != 0
        record.errors[:notice] << "Game over!"
      elsif record.pins >
        (# finds previous throw and ensures it is the first throw && that it was not a strike.
        if Throw.all.where(game_id:record.game_id).last.throwId % 2 != 0 && Throw.all.where(game_id:record.game_id).last.pins < 10
          10 - Throw.all.where(game_id:record.game_id).last.pins
        else
          10
        end
        )
         record.errors[:notice] << "This number of pins cannot be left standing if the previous throw score entered was correct"
      end
    end


  end
end
