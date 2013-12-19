#require "minitest/matchers"
#require "cancan/matchers"
require "test_helper"

describe "User" do
  describe "abilities" do
    let(:user){ nil }
    let(:ability){ Ability.new(user) }

    context "when is an account manager" do
      let(:user){ FactoryGirl.create(:admin) }

      # it{ should be_able_to(:manage, User.new) }

      assert ability.can?(:destroy, Trainer.new)
    end
  end
end