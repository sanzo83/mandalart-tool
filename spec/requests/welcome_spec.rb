require 'rails_helper'

RSpec.describe 'Welcome', type: :request do
  it 'renders the top page' do
    get root_path

    expect(response).to have_http_status(:ok)
  end
end
