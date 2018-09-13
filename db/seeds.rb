name = Faker::Name.name
email = "vanquang451@gmail.com"
address = Faker::Address.street_address
password = "12345678"
password_confirmation = "12345678"
phone_number = Faker::PhoneNumber.phone_number
role = "suppervisor"
User.create!(name: name, email: email, address: address, password: password, password_confirmation: password_confirmation, phone_number: phone_number, role: role)

5.times do
  name = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph(4)
  time_training = Faker::Number.number(2)

  Course.create!(name: name, description: description, time_training: time_training)
end

5.times do
  name = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph(4)
  content = Faker::Lorem.paragraph(10)

  Subject.create!(name: name, description: description, content: content)
end

subjects = Subject.take(4)
course = Course.last
users = User.all

subjects.each do |sub|
  CourseSubject.create!(course_id: course.id, subject_id: sub.id, status: "open")
end

users.each do |user|
  UserCourse.create!(user_id: user.id, course_id: course.id, status: "active", date_join: Time.now, finished_at: Time.now.utc.end_of_month)
end
