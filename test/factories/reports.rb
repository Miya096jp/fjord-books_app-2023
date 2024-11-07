# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '日報1' }
    content { 'http://localhost:3000/reports/2の日報とhttp://localhost:3000/reports/3の日報をメンションします' }
    created_at { 'Sun, 20 Oct 2024 16:43:57.988382000 JST +09:00' }
    association :user
  end

  trait :mentioned_report1 do
    title { '日報2' }
    content { 'この日報はhttp://www.localhost:3000/reports/2です' }
  end

  trait :mentioned_report2 do
    title { '日報3' }
    content { 'この日報はhttp://www.localhost:3000/reports/3です' }
  end

  trait :mentioned_report3 do
    title { '日報4' }
    content { 'この日報はhttp://www.localhost:3000/reports/4です' }
  end
end
