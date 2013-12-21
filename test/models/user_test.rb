#require "minitest/matchers"
#require "cancan/matchers"
require "test_helper"

describe User do
  describe "abilities" do
    let(:user){ nil }
    let(:ability){ Ability.new(user) }

    describe "when is an account manager" do
      let(:user){ FactoryGirl.create(:admin) }

      it "must be valid" do
        ability.can?(:destroy, Trainer.new).must_equal true
      end
    end
  end
end