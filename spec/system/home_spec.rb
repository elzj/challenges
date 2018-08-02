require 'rails_helper'

RSpec.describe "Test root path", type: :system, js: true do
  it "works" do
    visit '/'
    expect(page).to have_text("Challenges")
  end
end