require 'rails_helper'

RSpec.describe 'Exchange', type: :request do
  describe 'GET /users/:user_id/categories/:id/exchanges' do
    let!(:user) do
      User.create(name: 'test user', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    end

    let!(:category) do
      Category.create(user_id: user.id, name: 'category1', icon: 'https://images3.alphacoders.com/690/690494.jpg')
    end

    let!(:exchange) do
      Exchange.create(author_id: user.id, name: 'category1', category_ids: category.id)
    end

    it 'renders the correct template' do
      get user_category_exchanges_path(user_id: user.id, category_id: category.id)
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end
end
