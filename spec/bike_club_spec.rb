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

  end
  
end