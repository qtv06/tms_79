class CoursesController < ApplicationController
  def index
    @courses = Course.all.order_desc
  end
end
