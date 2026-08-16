require 'rails_helper'

RSpec.describe 'Main', type: :request do
  describe 'PATCH /main/:token' do
    it 'updates a record and redirects to its token URL' do
      record = Record.create!(data: {})

      patch update_main_path(token: record.access_token), params: { goal: '更新した目標' }

      expect(response).to redirect_to(edit_main_path(token: record.access_token))
      expect(record.reload.data['goal']).to eq('更新した目標')
    end
  end
end
