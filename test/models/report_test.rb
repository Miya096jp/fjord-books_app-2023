# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @anna = FactoryBot.create(:anna)
    @report = FactoryBot.create(:report, user: @anna)
  end

  test '#editable? returns true for the report owner' do
    assert @report.editable?(@anna)
  end

  test '#editable? returns false for a different user' do
    other_user = FactoryBot.create(:bob)
    assert_not @report.editable?(other_user)
  end

  test '#created_on returns true when expected date and actual date are equal' do
    assert_equal Date.parse('Sun, 20 Oct 2024'), @report.created_on
  end

  test '#save_mentions returns true when report is saved' do
    assert @report.save
  end
end
