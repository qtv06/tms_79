require "rails_helper"

RSpec.describe UserCourse, type: :model do
  describe "associations" do
    it do
      should belong_to :user
    end
  end
end
