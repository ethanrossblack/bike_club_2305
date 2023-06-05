require "rspec"
require "./lib/ride"
require "./lib/biker"

describe Biker do
  before :each do
    @biker = Biker.new("Kenny", 30)

    @ride1 = ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe "#initialize" do
    it "exists" do
      expect(@biker).to be_a Biker
    end

    it "has readable attributes" do
      expect(@biker.name).to eq "Kenny"
      expect(@biker.max_distance).to eq 30
    end

    it "starts with no rides" do
      expect(@biker.rides).to eq({})
      expect(@biker.rides).to be_a Hash
    end

    it "starts with no accpetable terrain" do
      expect(@biker.acceptable_terrain).to eq([])
    end
  end

  describe "#learn_terrain!" do
    it "can learn terrain" do
      @biker.learn_terrain!(:gravel)
      @biker.learn_terrain!(:hills)

      expect(@biker.acceptable_terrain).to eq [:gravel, :hills]
    end

    it "only accepts terrain arguments as a symbol" do
      @biker.learn_terrain!(:gravel)
      
      expect(@biker.acceptable_terrain).to eq [:gravel]
      
      @biker.learn_terrain!("hills")
      
      expect(@biker.acceptable_terrain).to eq [:gravel]
    end
  end

  describe "#log_ride" do
    it "can log a ride" do
      @biker.log_ride(@ride1, 92.5)

      expect(@biker.rides).to eq({@ride1 => [92.5]})

      @biker.log_ride(@ride2, 60.9)
      
      expect(@biker.rides).to eq({@ride1 => [92.5], @ride2 => [60.9]})
    end
    
    it "can keep track of all previous times for each ride" do
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.rides).to eq({@ride1 => [92.5, 91.1], @ride2 => [60.9, 61.6]})
    end
  end
end


# 1. Create a Biker with attributes and a way to read that data

# 2. A Biker has a list of acceptable terrain and can learn new terrain

# 3/ Bikers can log a ride with a time. The Biker can keep track of all of its previous rides and times for those rides.

# 4. A Biker will not log a ride if the ride's terrain does not match their acceptable terrain. They also won't log a ride if the ride's total distance is greater than the Biker's max distance.

# 5. A Biker can report its personal record for a specific ride. This is the lowest time recorded for a ride. This method will return false if the Biker hasn't completed the ride

