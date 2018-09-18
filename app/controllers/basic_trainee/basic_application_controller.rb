class BasicTrainee::BasicApplicationController < ApplicationController
  layout "basic_application"
  before_action :authenticate_user!
end
