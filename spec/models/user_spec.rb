require 'rails_helper'
describe "comment" do
  it "Hi" do
    expect(Comment.new.ispublic).to eq(true)
    # not_to
    # eq => be >1 / be >=0
  end
end