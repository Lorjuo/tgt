require "test_helper"

# class TrainerTest < ActiveSupport::TestCase
#   before do
#     @trainer ||= FactoryGirl.create(:trainer)
#   end

#   test 'is valid' do
#     assert_equal true, @trainer.valid?
#   end
# end

describe Trainer do
  let(:trainer) { FactoryGirl.create(:trainer) }

  it "must be valid" do
    trainer.valid?.must_equal true
  end
end
