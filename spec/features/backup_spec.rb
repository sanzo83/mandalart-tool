require 'rails_helper'

RSpec.feature 'Backup', type: :feature do
  scenario 'JSONバックアップを読み込んで編集を再開する' do
    visit root_path
    attach_file 'backup', Rails.root.join('spec/fixtures/mandala-note.json')
    click_button 'ファイルを開く'

    expect(page).to have_content 'バックアップした目標'
    expect(find("input[name='target1_1']").value).to eq '具体的な行動'
  end
end
