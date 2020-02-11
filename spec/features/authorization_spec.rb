require 'rails_helper'

RSpec.feature "Authorization", type: :feature do
  scenario 'ログインする' do
    # トップページを開く
    visit "/users/sign_in"
    # ログインフォームにEmailとパスワードを入力する
    fill_in 'user[email]', with: 'test1@example.com'
    fill_in 'user[password]', with: '123456'
    # ログインボタンをクリックする
    click_on 'ログイン'
    # ログインに成功したことを検証する
    expect(page).to have_content 'ログインしました。'
  end
end
