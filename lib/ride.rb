class Ride
  attr_reader :name, :distance, :terrain

  def initialize(ride_details)
    @name = ride_details[:name]
    @distance = ride_details[:distance]
    @loop  = ride_details[:loop]
    @terrain = ride_details[:terrain]
  end


  def loop?
    @loop
  end

  def total_distance
    loop? ? distance : distance * 2
  end
end