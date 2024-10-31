# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email returns email if name is nil, otherwize returns name' do
    user = FactoryBot.create(:anna, name: nil)
    assert_equal 'anna@example.com', user.name_or_email
    user.name = 'anna'
    assert_equal 'anna', user.name_or_email
  end
end
