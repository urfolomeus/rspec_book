require File.join(File.dirname(__FILE__), "..", "spec_helper")
require File.join(File.dirname(__FILE__), "..", "..", "features", "support", "stats")

module Codebreaker
  describe Stats do
    describe "#puts" do
      it "ignores messages that are not secret codes" do
        stats = Stats.new
        stats.puts "r y g this is not a secret code"
        stats.count_for('r', 1).should == 0
        stats.count_for('y', 2).should == 0
        stats.count_for('g', 3).should == 0
      end
    end
    describe "#codes" do
      before :each do
        @stats = Stats.new
      end
      context "with no codes" do
        it "returns an empty array" do
          @stats.codes.length.should == 0
        end
      end
      context "with one code" do
        it "returns an array with the given code as an array of colors" do
          @stats.puts "r y g b"
          @stats.codes.length.should == 1
          @stats.codes.should == [ %w[r y g b] ]
        end
      end
      context "with several codes" do
        it "returns the given codes as arrays of color" do
          @stats.puts "r y g b"
          @stats.puts "r g b w"
          @stats.codes.length.should == 2
          @stats.codes.should == [ %w[r y g b], %w[r g b w] ]
        end
      end
      context "with several codes and other messages" do
        it "returns the given codes as arrays of color and ignores the messages" do
          @stats.puts "r y g b"
          @stats.puts "r g b w"
          @stats.puts "reveal"
          @stats.puts "r c y b"
          @stats.puts "a test message"
          @stats.codes.length.should == 3
          @stats.codes.should == [ %w[r y g b], %w[r g b w], %w[r c y b] ]
        end
      end
    end
    context "with 1 code with r in position 1" do
      before :each do
        @stats = Stats.new
        @stats.puts "r y g b"
      end
      it "returns 1 for count_for('r', 1)" do
        @stats.count_for('r', 1).should == 1
      end
      it "returns 0 for count_for('y', 1)" do
        @stats.count_for('y', 1).should == 0
      end
    end
    context "with 2 codes with r in position 1 twice and y in position 2 once" do
      before :each do
        @stats = Stats.new
        @stats.puts "r y g b"
        @stats.puts "r g b w"
      end
      it "returns 2 for count_for('r', 1)" do
        @stats.count_for('r', 1).should == 2
      end
      it "returns 0 for count_for('y', 1)" do
        @stats.count_for('y', 1).should == 0
      end
      it "returns 1 for count_for('y', 2)" do
        @stats.count_for('y', 2).should == 1
      end
    end
  end
end