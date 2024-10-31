# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'first_report' }
    content { 'This is the first report.' }
    created_at { 'Sun, 20 Oct 2024 16:43:57.988382000 JST +09:00' }
    association :user
  end
end
