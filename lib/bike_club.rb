class BikeClub
  attr_reader :name, :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker if biker.is_a?(Biker)
  end

  def most_rides
    bikers.max { |a, b| a.count_rides <=> b.count_rides }
  end
end