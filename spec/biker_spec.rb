require "rspec"
require "./lib/ride"
require "./lib/biker"

describe Biker do

  before :each do
    @biker = Biker.new("Kenny", 30)
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

    before :each do
      @biker.learn_terrain!(:hills)
      @biker.learn_terrain!(:gravel)
      
      @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

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

    it "can only log rides on terrain the biker knows" do
      athena = Biker.new("Athena", 15)
      splash_mountain = Ride.new({name: "Splash Mountain", distance: 4.9, loop: false, terrain: :log_ride})

      expect(athena.acceptable_terrain).to eq([])

      athena.log_ride(splash_mountain, 10.1)

      expect(athena.rides).to eq({})

      athena.learn_terrain!(:log_ride)
      athena.log_ride(splash_mountain, 10.1)

      expect(athena.rides).to eq({splash_mountain => [10.1]})
    end

    it "can only log rides with a total distance less than or equal to than their max distance" do
      ethan = Biker.new("Ethan", 10.1)
      ethan.learn_terrain!(:log_ride)
      splash_chute = Ride.new({name: "Splash Chute", distance: 5.1, loop: false, terrain: :log_ride})

      expect(ethan.max_distance).to eq 10.1
      expect(splash_chute.total_distance).to eq 10.2
      expect(ethan.rides).to eq({})

      ethan.log_ride(splash_chute, 56.7)

      expect(ethan.rides).to eq({})
    end

  end

  describe "#personal_record" do

    before :each do
      @biker.learn_terrain!(:hills)
      @biker.learn_terrain!(:gravel)
      
      @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end

    it "can report its personal record for a specific ride" do
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.personal_record(@ride1)).to eq 91.1
      expect(@biker.personal_record(@ride2)).to eq 60.9
    end

    it "returns false if asked for a personal record of a ride it hasn't completed" do
      expect(@biker.personal_record(@ride1)).to be false
    end

  end

  describe "helper methods" do

    describe "#acceptable_terrain?" do

      it "validates if a biker can bike a certain terrain" do
        expect(@biker.acceptable_terrain?(:hills)).to be false
        
        @biker.learn_terrain!(:hills)
        
        expect(@biker.acceptable_terrain?(:hills)).to be true
      end

    end

    describe "#bikeable_distance?" do

      it "validates if a distance is within a biker's range" do
        expect(@biker.max_distance).to eq 30

        expect(@biker.bikeable_distance?(29.5)).to be true
        expect(@biker.bikeable_distance?(30)).to be true
        expect(@biker.bikeable_distance?(30.1)).to be false
      end

    end

    describe "#count_rides" do
     
      before :each do
        @biker.learn_terrain!(:hills)
        @biker.learn_terrain!(:gravel)
        
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
      end
      
      it "can count the number of rides a Biker has taken" do
        expect(@biker.count_rides).to eq 0
        
        @biker.log_ride(@ride1, 92.5)
        
        expect(@biker.count_rides).to eq 1
        
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)
        
        expect(@biker.count_rides).to eq 4
      end
    
    end


  end

end


# 1. Create a Biker with attributes and a way to read that data

# 2. A Biker has a list of acceptable terrain and can learn new terrain

# 3/ Bikers can log a ride with a time. The Biker can keep track of all of its previous rides and times for those rides.

# 4. A Biker will not log a ride if the ride's terrain does not match their acceptable terrain. They also won't log a ride if the ride's total distance is greater than the Biker's max distance.

# 5. A Biker can report its personal record for a specific ride. This is the lowest time recorded for a ride. This method will return false if the Biker hasn't completed the ride

