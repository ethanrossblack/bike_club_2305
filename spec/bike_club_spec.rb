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

end