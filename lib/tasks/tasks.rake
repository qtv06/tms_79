namespace :tasks do
  desc "Generate task of subject"
  task generate_task_of_subject: :environment do
    Subject.all.each do |subject|
      10.times do
        Task.create(name: "A", description: "B", subject_id: subject.id)
      end
    end
  end
end
