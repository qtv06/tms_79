require "rails_helper"

RSpec.describe Course, type: :model do
  describe "db schema" do
    context "columns" do
      it do
        should have_db_column(:name).of_type(:string)
        should have_db_column(:description).of_type(:text)
        should have_db_column(:time_training).of_type(:integer)
      end
    end
  end

  describe "associations" do
    it do
      should have_many(:user_courses).dependent(:destroy)
      should have_many(:users).through(:user_courses).dependent(:destroy)
      should have_many(:course_subjects).dependent(:destroy)
      should have_many(:subjects).through(:course_subjects).dependent(:destroy)
    end
  end

  describe ".order_desc" do
    before {Course.delete_all}
    let!(:course1) {FactoryBot.create :course}
    let!(:course2) {FactoryBot.create :course}
    let!(:course3) {FactoryBot.create :course}

    it {expect(Course.order_desc).to match_array [course3, course2, course1]}
  end
end
