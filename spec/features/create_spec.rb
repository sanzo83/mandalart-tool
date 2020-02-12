require 'rails_helper'

RSpec.feature "Create", type: :feature do

  scenario 'マンダラート新規登録から編集、削除まで' do
    # 登録ページを開く
    visit "/users/sign_up"
    fill_in 'user_email', with: 'testtest@example.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on '登録'

    # 新規登録画面へ
    visit "/main/new"

    fill_in 'goal', with: 'テスト目標goal'
    fill_in 'main_target1', with: 'テスト目標1'
    fill_in 'main_target2', with: 'テスト目標2'
    fill_in 'main_target3', with: 'テスト目標3'
    fill_in 'main_target4', with: 'テスト目標4'
    fill_in 'main_target5', with: 'テスト目標5'
    fill_in 'main_target6', with: 'テスト目標6'
    fill_in 'main_target7', with: 'テスト目標7'
    fill_in 'main_target8', with: 'テスト目標8'

    click_on '登録'

    # ちゃんと一覧に登録されているか
    expect(page).to have_content 'テスト目標goal'

    click_on '詳細'
    find("input[name$='target1_1']", visible: false).set('テストです')
    click_on '登録'

    # 編集機能が動いているか
    expect(page).to have_content 'テストです'

    # 一覧画面へ
    visit "/main/index"
    click_on '削除'

    # ちゃんと削除されているか
    expect(page).not_to have_content 'テスト目標goal'

  end
end
