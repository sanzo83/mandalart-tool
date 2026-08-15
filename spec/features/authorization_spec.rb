require 'rails_helper'

RSpec.feature "Authorization", type: :feature do
  scenario 'ユーザー登録してログアウト、ログインする' do
    # 登録ページを開く
    visit "/users/sign_up"
    fill_in 'user_email', with: 'testtest@example.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button '無料ではじめる'
    # 登録に成功したことを検証する
    expect(page).to have_content 'アカウント登録が完了しました。'

    # メインページに遷移するので、ログアウト
    click_button 'ログアウト'
    visit '/users/sign_in'

    # ログインフォームにEmailとパスワードを入力する
    fill_in 'user_email', with: 'testtest@example.com'
    fill_in 'user_password', with: '123456'
    # ログインボタンをクリックする
    click_button 'ログイン'
    # ログインに成功したことを検証する
    expect(page).to have_content 'ログインしました。'
  end
end
