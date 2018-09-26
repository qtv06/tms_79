require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.new(name: "Jonh", email: "john@gmail.com", password: "12345678", password_confirmation: "12345678", phone_number: "1234567890")}

  context "columns" do
    it{should have_db_column(:name).of_type(:string)}
    it{should have_db_coumn(:email).of_type(:string)}
  end

  context "with validate name field" do
    it "is can't blank" do
      user.name = "  "
      expect(user).to_not be_valid
    end

    it "is shoudn't be longer than 50" do
      user.name = "as" * 30
      expect(user).to_not be_valid
    end
  end

  context "with validate phone number" do
    it "can't blank" do
      user.phone_number = "   "
      expect(user).to_not be_valid
    end

    it "have only 10 number" do
      user.phone_number = "2" * 11
      expect(user).to_not be_valid
    end
  end
end
