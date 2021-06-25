FactoryBot.define do
  factory :task do
    name { 'task name' }
    association :project
  end
end
