require "rails_helper"

RSpec.describe Subject, type: :model do
  context "columns" do
    it{should have_db_column(:name).of_type(:string)}
    it{should have_db_column(:description).of_type(:text)}
    it{should have_db_column(:created_at).of_type(:datetime)}
  end

  context "relationship" do
    it{is_expected.to have_many :tasks}
    it{is_expected.to have_many :course_subjects}
  end
end
