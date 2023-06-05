require "rspec"
require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

describe BikeClub do

  before :each do
    @bike_club = bike_club = BikeClub.new("2305 Bike Club")
  end

  describe "#initialize" do

    it "exists" do
      expect(@bike_club).to be_a BikeClub
    end

    it "has a name" do
      expect(@bike_club.name).to eq "2305 Bike Club"
    end

    it "starts with no bikers" do
      expect(@bike_club.bikers).to eq []
    end

  end

  describe "#add_biker" do
    
    before :each do
      @ethan = Biker.new("Ethan", 100)
      @zahava = Biker.new("Zahava", 101)
    end

    it "can add a biker" do
      @bike_club.add_biker(@ethan)
      @bike_club.add_biker(@zahava)

      expect(@bike_club.bikers).to eq [@ethan, @zahava]
    end

    it "can only add Biker objects" do
      not_a_biker = "I am a string, not a biker"

      @bike_club.add_biker(not_a_biker)

      expect(@bike_club.bikers).to eq []
    end
  
  end

  describe "#most_rides" do

    before :each do
      @ethan = Biker.new("Ethan", 100)
      @zahava = Biker.new("Zahava", 101)

      @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
      @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
      @splash_mountain = Ride.new({name: "Splash Mountain", distance: 4.9, loop: true, terrain: :log_ride})

      @ethan.learn_terrain!(:gravel)
      @ethan.learn_terrain!(:hills)
      @ethan.learn_terrain!(:log_ride)
      @zahava.learn_terrain!(:gravel)
      @zahava.learn_terrain!(:hills)

      @ethan.log_ride(@ride1, 92.5)
      @zahava.log_ride(@ride1, 91.1)
      @ethan.log_ride(@ride2, 60.9)
      @zahava.log_ride(@ride2, 61.6)
      @ethan.log_ride(@splash_mountain, 50.1)
    end

    it "can tell us which Biker has logged the most rides" do
      expect(@ethan.rides.length).to eq 3
      expect(@zahava.rides.length).to eq 2

      @bike_club.add_biker(@zahava)

      expect(@bike_club.most_rides).to eq @zahava

      @bike_club.add_biker(@ethan)

      expect(@bike_club.most_rides).to eq @ethan
    end

  end
end