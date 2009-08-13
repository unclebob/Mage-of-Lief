require 'spec'

describe "Life Rules" do
  context "Already Living" do
    ALL_NEIGHBORS = (0..8).to_a
    STAYS_LIVING_NEIGHBOR_COUNTS = [2,3]
    STOPS_LIVING_NEIGHBOR_COUNTS = ALL_NEIGHBORS - STAYS_LIVING_NEIGHBOR_COUNTS

    def stays_alive?(neighbor_count)
      STAYS_LIVING_NEIGHBOR_COUNTS.include? neighbor_count
    end

    {STOPS_LIVING_NEIGHBOR_COUNTS => false, STAYS_LIVING_NEIGHBOR_COUNTS => true}.each_pair do |neighbor_counts, does_live|
      neighbor_counts.each do |neighbor_count|
        context "#{neighbor_count} neighbors" do
          it "#{does_live ? 'lives' : 'dies'}" do
            stays_alive?(neighbor_count).should == does_live
          end
        end
      end
    end

  end
  context "Already Dead" do

  end
end