require 'rails_helper'

RSpec.describe 'Category new view page', type: :system do
  let!(:user) do
    User.create(name: 'test user', email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  let!(:category) do
    Category.create(user_id: user.id, name: 'category1', icon: 'https://images3.alphacoders.com/690/690494.jpg')
  end

  describe 'show correct form for a user' do
    before(:example) do
      allow_any_instance_of(ActionController::Base).to receive(:current_user).and_return(user)
      visit user_categories_path(user)
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end

    it 'displays the user\'s category' do
      expect(page).to have_content(category.name)
    end

    it 'displays the user\'s icon selector' do
      expect(page).to have_selector('img[src="https://images3.alphacoders.com/690/690494.jpg"]')
    end
  end
end
