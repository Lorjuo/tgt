require "test_helper"

describe "User" do
  describe "abilities" do
    let(:user){ FactoryGirl.create(:user) }
    let(:ability){ Ability.new(user) }


    # Default
    context "when has no special rights" do
      [Announcement, Department, Document, Event, Gallery, Image,
        Location, Message, NavigationElement, Page, Reference, Trainer,
        TrainingGroup, TrainingUnit, User]
        .each do |model|
        specify "cannot manage #{model}" do
          ability.can?(:create, model.new).must_equal false
          ability.can?(:update, model.new).must_equal false
          ability.can?(:destroy, model.new).must_equal false
        end
      end
    end


    # Has trainer profile
    context "when has trainer profile" do
      let(:trainer){ FactoryGirl.create(:trainer) }

      before(:all) do
        user.trainer = trainer
      end

      it "can update own profile" do
        ability.can?(:update, trainer).must_equal true
      end

    end


    # Has department
    context "when has department" do
      let(:department){ FactoryGirl.create(:department) }

      before(:all) do
        user.departments << department
      end

      it "can update own department" do
        ability.can?(:update, department).must_equal true
      end

    end


    # Is Editor
    context "when is editor" do
      let(:user){ FactoryGirl.create(:editor) }

      it "can manage announcements" do
        ability.can?(:create, Announcement.new).must_equal true
        ability.can?(:update, Announcement.new).must_equal true
        ability.can?(:destroy, Announcement.new).must_equal true
      end
    end


    # Is Admin
    context "when is admin" do
      let(:user){ FactoryGirl.create(:admin) }

      [Announcement, Department, Document, Event, Gallery, Image,
        Location, Message, NavigationElement, Page, Reference, Trainer,
        TrainingGroup, TrainingUnit, User]
        .each do |model|
        specify "can manage #{model}" do
          ability.can?(:create, model.new).must_equal true
          ability.can?(:update, model.new).must_equal true
          ability.can?(:destroy, model.new).must_equal true
        end
      end
    end
  end
end