class Biker
  attr_reader :name, :max_distance, :rides, :acceptable_terrain

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = Hash.new { |hash, key| hash[key] = [] }
    @acceptable_terrain = []
  end

  def learn_terrain!(terrain)
    return nil unless terrain.is_a?(Symbol)

    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    terrain = ride.terrain
    distance = ride.total_distance

    if acceptable_terrain?(terrain) and bikeable_distance?(distance)
      @rides[ride] << time
    end
  end

  def acceptable_terrain?(terrain)
    acceptable_terrain.include?(terrain)
  end

  def bikeable_distance?(distance)
    max_distance >= distance
  end

  def personal_record(ride)
    rides.has_key?(ride) ? rides[ride].min : false
  end

  def count_rides
    ride_count = 0
    rides.values.each do |ride_times|
      ride_count += ride_times.length
    end
    ride_count
  end
end