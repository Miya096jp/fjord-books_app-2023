# frozen_string_literal: true

FactoryBot.define do
  factory :anna, class: 'User' do
    email { 'anna@example.com' }
    name { 'anna' }
    password { 'password' }
  end

  factory :bob, class: 'User' do
    email { 'bob@example.com' }
    name { 'bob' }
    password { 'password' }
  end
end
