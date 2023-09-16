require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /users/:user_id/categories/:id' do
    let!(:user) do
      User.create(name: 'test user', email: 'user@example.com', password: 'password',
                  password_confirmation: 'password')
    end
    let!(:category) do
      Category.create(user_id: user.id, name: 'category1', icon: 'https://images3.alphacoders.com/690/690494.jpg')
    end
    it 'renders the correct template' do
      get user_categories_path(user_id: user.id, id: category.id)
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end
end
