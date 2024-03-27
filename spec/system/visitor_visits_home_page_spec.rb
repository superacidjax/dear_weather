require 'rails_helper'

RSpec.describe 'Visitor views home page', type: :system do

  before { driven_by(:rack_test) }

  it 'views the home page' do
    visit root_path
    expect(page).to have_content('Dear Weather')
  end
end

