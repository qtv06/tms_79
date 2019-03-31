class AddMemberService
  def call users_id, course
    user_courses = []
    users = []
    UserCourse.transaction do
      users_id.each do |user_id|
        user_courses << UserCourse.new_user_course(user_id, course.id)
        user = User.find_by id: user_id
        users << user if user
      end

      UserCourse.import user_courses, validate: true
      
      UserNotifierMailer.send_mail_after_assign_trainee(users,
        course).deliver_later
    end
  end
end
