require "rails_helper"

RSpec.describe User, type: :model do
  describe "db schema" do
    context "columns" do
      it do
        should have_db_column(:email).of_type(:string)
        should have_db_column(:name).of_type(:string)
        should have_db_column(:password_digest).of_type(:string)
        should have_db_column(:address).of_type(:string)
        should have_db_column(:phone_number).of_type(:string)
        should have_db_column(:avatar).of_type(:string)
        should have_db_column(:role).of_type(:integer)
      end
    end
  end

  describe "validations" do
    it do
      should validate_presence_of :name
      should validate_length_of(:name).
        is_at_most(50).with_message("is too long (maximum is 50 characters)")
      should validate_presence_of :email
      should validate_presence_of :phone_number
      should validate_length_of(:phone_number).
        is_at_least(10).with_message("is too short (minimum is 10 characters)")
      should validate_presence_of :address
      should validate_length_of(:address).
        is_at_most(200).with_message("is too long (maximum is 200 characters)")
      should validate_presence_of :password
      should validate_length_of(:password).
        is_at_least(6).with_message("is too short (minimum is 6 characters)")
    end
  end

  describe "associations" do
    it do
      should have_many(:user_courses).dependent(:destroy)
      should have_many(:user_tasks).dependent(:destroy)
      should have_many(:courses).through(:user_courses).dependent(:destroy)
    end
  end

  describe "role" do
    it do
      should define_enum_for(:role).with([:suppervisor, :trainee])
    end
  end

  describe "scope city DESC" do
    let(:user1) {FactoryBot.create(:user, name: "viet hieu_1")}
    let(:user2) {FactoryBot.create(:user, name: "viet hieu_2")}
    it "orders by ascending city" do
      expect(User.newest).to eq([user2, user1])
    end
  end
end
