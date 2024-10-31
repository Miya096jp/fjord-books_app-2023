# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @anna = FactoryBot.create(:anna)
    @report = FactoryBot.create(:report, user: @anna)
    visit root_url
    fill_in 'Eメール', with: 'anna@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'テスト'
    fill_in '内容', with: 'テストです'
    click_on '登録する'

    assert_text '日報が作成されました。'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_link 'この日報を編集'

    fill_in 'タイトル', with: '更新'
    fill_in '内容', with: '更新しました'
    click_on '更新する'
    assert_text '日報が更新されました。'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
  end
end
