class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_suppervisor!
  def index; end
end
