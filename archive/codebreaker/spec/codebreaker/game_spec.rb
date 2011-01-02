require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Codebreaker
  describe Game do
    before(:each) do
      @messenger = mock("messenger").as_null_object
      @game = Game.new(@messenger)
    end
    context "starting up" do
      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to Codebreaker!")
        @game.start(stub('generator', :code => %w[r g y c]))
      end      
      it "should prompt for the first guess" do
        @messenger.should_receive(:puts).with("Enter guess:")
        @game.start(stub('generator', :code => %w[r g y c]))
      end
    end
    context "marking a guess" do
      context "with all 4 colors correct in the correct places" do
        it "should mark the guess with bbbb" do
          @game.start(stub('generator', :code => %w[r g y c]))
          @messenger.should_receive(:puts).with("bbbb")
          @game.guess(%w[r g y c])
        end
      end
      context "with all 4 colors correct and 2 in the correct places" do
        it "should mark the guess with bbww" do
          @game.start(stub('generator', :code => %w[r g y c]))
          @messenger.should_receive(:puts).with("bbww")
          @game.guess(%w[r g c y])
        end
      end
      context "with all 4 colors correct and 1 in the correct place" do
        it "should mark the guess with bwww" do
          @game.start(stub('generator', :code => %w[r g y c]))
          @messenger.should_receive(:puts).with("bwww")
          @game.guess(%w[y r g c])
        end
      end      
      context "with 3 colors correct in the correct places" do
        it "should mark the guess with bbb" do
          @game.start(stub('generator', :code => %w[r g y c]))
          @messenger.should_receive(:puts).with("bbb")
          @game.guess(%w[r g y w])
        end
      end      
      context "with duplicates in the guess that match a peg in the code" do
        context "by color and position" do
          it "should add a single b to the mark" do
            @game.start(stub('generator', :code => %w[r y g c]))
            @messenger.should_receive(:puts).with("bbb")
            @game.guess(%w[r y g g])
          end
        end
      end      
      context "with 5 colors guessed" do
        it "should only mark the first 4" do
          @game.start(stub('generator', :code => %w[r g y c]))
          @messenger.should_receive(:puts).with("bww")
          @game.guess(%w[g r y g c])
        end
      end
      context "with the text 'reveal'" do
        it "should send the secret code to the messenger" do
          @game.start(stub('generator', :code => %w[r g y c]))
          @messenger.should_receive(:puts).with("r g y c")
          @game.guess(["reveal"])
        end
      end
    end
  end
end