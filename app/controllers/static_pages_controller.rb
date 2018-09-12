class StaticPagesController < ApplicationController
  before_action :authenticate_user!, :authenticate_suppervisor!
  def index; end
end
