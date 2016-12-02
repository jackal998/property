require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  before do
  end
  let!(:user) { User.create!(:email => 'aaa@bbb', :password => 'aaabbb')}
  it '#index' do
    # request.headers['Content-Type'] = 'application/json'
    get 'http://api.localhost/users.json', headers: { 'HTTP_J_TTOOKKEENN' => 'token'}
    expect(response.status).to eq(200)
    expect(response.body).to include(user.email)
    # JSON.parse
  end

end
