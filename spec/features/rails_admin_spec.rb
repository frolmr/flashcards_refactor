require 'rails_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper

describe 'Admin user' do
  before do
    create(:user, admin: true)
    visit root_path
    login('test@test.com', '12345', 'Войти')
  end
  it 'should access admin panel' do
    visit rails_admin.dashboard_path
    expect(current_path).to eq rails_admin.dashboard_path
  end
end

describe 'Non admin user' do
  before do
    create(:user)
    visit root_path
    login('test@test.com', '12345', 'Войти')
  end
  it 'should not access admin panel' do
    expect { visit rails_admin.dashboard_path }.to raise_error(Pundit::NotAuthorizedError)
  end
end
