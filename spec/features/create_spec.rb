require 'rails_helper'

RSpec.feature 'Create', type: :feature do
  scenario 'マンダラート新規登録から編集、削除まで' do
    # 新規登録画面へ
    visit '/main/new'

    fill_in 'goal', with: 'テスト目標goal'
    fill_in 'main_target1', with: 'テスト目標1'
    fill_in 'main_target2', with: 'テスト目標2'
    fill_in 'main_target3', with: 'テスト目標3'
    fill_in 'main_target4', with: 'テスト目標4'
    fill_in 'main_target5', with: 'テスト目標5'
    fill_in 'main_target6', with: 'テスト目標6'
    fill_in 'main_target7', with: 'テスト目標7'
    fill_in 'main_target8', with: 'テスト目標8'

    click_on '次へ：行動を広げる →'

    # 作成直後に編集画面へ遷移する
    expect(page).to have_content 'テスト目標goal'

    find("input[name='target1_1']").set('テストです')
    click_on '一時保存する'

    # 編集機能が動いているか
    expect(find("input[name='target1_1']").value).to eq 'テストです'

    # 一覧画面へ
    visit '/main/index'
    within(find('.record-card', text: 'テスト目標goal')) do
      click_button '削除'
    end

    # ちゃんと削除されているか
    expect(page).not_to have_content 'テスト目標goal'
  end
end
