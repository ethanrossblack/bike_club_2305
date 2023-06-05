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
  end
end