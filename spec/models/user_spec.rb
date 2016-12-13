require 'rails_helper'
describe "comment" do
  before do
    @user = User.new()
  end
  # let(:c) {Category.new(rrrr)}
  it "Hi" do
    expect(Comment.new.ispublic).to eq(true)
    expect(@user.nil?).to eq(false)
    # not_to
    # eq => be >1 / be >=0
  end
  it "User" do
    expect(@user.present?).to eq(true)
  end
end