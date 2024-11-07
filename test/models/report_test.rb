# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @anna = FactoryBot.create(:anna)
    @bob = FactoryBot.create(:bob)
    @report = FactoryBot.create(:report, user: @anna)
    FactoryBot.create(:report, :mentioned_report1, user: @bob)
    FactoryBot.create(:report, :mentioned_report2, user: @bob)
    FactoryBot.create(:report, :mentioned_report3, user: @bob)
  end

  test '#editable? returns true for the report owner' do
    assert @report.editable?(@anna)
  end

  test '#editable? returns false for a different user' do
    other_user = @bob
    assert_not @report.editable?(other_user)
  end

  test '#created_on returns true when expected date and actual date are equal' do
    assert_equal Date.parse('Sun, 20 Oct 2024'), @report.created_on
  end

  test '#save_mentions adds new mentions to report_mention table' do
    @report.save!
    assert_equal [2, 3], @report.mentioning_reports.map(&:id)
  end

  test '#save_mentions updates mentions when content is changed' do
    @report.update!(title: 'Updated', content: 'http://localhost:3000/reports/3とhttp://localhost:3000/reports/4をメンション', user: @anna)
    assert_equal [3, 4], @report.mentioning_reports.map(&:id)
  end
end
