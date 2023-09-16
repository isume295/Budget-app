require 'rails_helper'

RSpec.describe 'Exchange index view page', type: :system do
  let!(:user) do
    User.create(name: 'test user', email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  let!(:category) do
    Category.create(user_id: user.id, name: 'category1', icon: 'https://images3.alphacoders.com/690/690494.jpg')
  end

  let!(:exchange) do
    Exchange.create(author_id: user.id, name: 'category1', amount: 30, category_ids: category.id)
  end

  describe 'show correct exchange index for a users category' do
    before(:example) do
      allow_any_instance_of(ActionController::Base).to receive(:current_user).and_return(user)
      visit user_categories_path(user)
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      click_link category.name
    end

    it 'displays the user\'s category exchange name' do
      expect(page).to have_content(exchange.name)
    end

    it 'displays the user\'s category exchange amount' do
      expect(page).to have_content(exchange.amount)
    end
  end
end
