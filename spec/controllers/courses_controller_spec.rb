require "rails_helper"

RSpec.describe Course, type: :controller do
  describe "call back" do
    context "course not found" do
      before do
        get :update, params: {}
      end
    end
  end
end
