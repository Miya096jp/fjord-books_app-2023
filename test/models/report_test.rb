# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @anna = users(:anna)
    @report = reports(:first_report)
  end

  test '#editable? returns true for the report owner' do
    assert @report.editable?(@anna)
  end

  test '#editable? returns false for a different user' do
    other_user = users(:bob)
    assert_not @report.editable?(other_user)
  end

  test '#created_on retuns true when expected date and actual date are equal' do
    assert_equal Date.parse('Sun, 20 Oct 2024'), @report.created_on
  end
end
