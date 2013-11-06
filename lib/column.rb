class Column
  attr_accessor :occupied_until
  attr_accessor :training_units

  def initialize
    #@occupied_until = Time.new(2000,1,1,0,0)
    @training_units = Array.new
    reset_occupancy
  end

  def append (training_unit)
    if is_occupied?(training_unit[:time_begin])
      return false
    end
    @training_units << training_unit
    @occupied_until = training_unit[:time_end]
    return true
  end

  def reset_occupancy
    @occupied_until = Time.zone.local(2000,1,1,0,0)
  end

  def is_occupied? (time)
    time < @occupied_until
  end

  def next_occupancy(time, step)
    unless training_units.empty?

      # Fetch relevant training_unit
      training_unit = training_units.first

      if time >= training_unit[:time_begin]
        steps = 0
        begin 
          time += step
          steps += 1
        end while (time < training_unit[:time_end])
        @occupied_until = training_unit[:time_end]
        return {:steps => steps, :training_unit => training_units.shift}
      end
    end
    return nil
  end
end