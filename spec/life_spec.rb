require 'spec'

ALL_NEIGHBORS = (0..8).to_a
STAYS_LIVING_NEIGHBOR_COUNTS = [2, 3]
STARTS_LIVING_NEIGHBOR_COUNTS = [3]
STAYS_DEAD_NEIGHBOR_COUNTS = ALL_NEIGHBORS-STARTS_LIVING_NEIGHBOR_COUNTS
TRANSITION_MAP = {:alive => STAYS_LIVING_NEIGHBOR_COUNTS, :dead => STAYS_DEAD_NEIGHBOR_COUNTS}

def the_other(state)
  state == :alive ? :dead : :alive
end

def transition(state, neighbor_count)
  TRANSITION_MAP[state].include?(neighbor_count) ? state : the_other(state)
end

Spec::Matchers.define :transition do
  match do |actual|
    state, neighbor_count = actual
    transition(state, neighbor_count) == (state == :alive ? :dead : :alive)
  end
end


describe "Life Rules" do
  {:dead => STAYS_DEAD_NEIGHBOR_COUNTS, :alive => STAYS_LIVING_NEIGHBOR_COUNTS}.each_pair do |state, neighbor_counts_that_do_not_transition|
    context state do
      neighbor_counts_that_do_not_transition.each do |neighbor_count|
        context "#{neighbor_counts_that_do_not_transition} neighbors" do
          it "does not transition" do
            [state, neighbor_count].should_not transition
          end
        end
      end
      (ALL_NEIGHBORS - neighbor_counts_that_do_not_transition).each do |neighbor_count|
        context "#{neighbor_counts_that_do_not_transition} neighbors" do
          it "does transition" do
            [state, neighbor_count].should transition
          end
        end
      end
    end
  end
end
