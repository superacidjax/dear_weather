require 'rails_helper'

RSpec.describe 'Visitor gets weather for location', type: :system do

  before { driven_by(:rack_test) }

  it 'gets weather for a specific US address' do
    visit root_path
    VCR.use_cassette('usa_address') do
      fill_in 'query', with: '1 Apple Park Way, Cupertino, CA, 95014'
      click_button 'Get Weather'
    end
    expect(page).to have_content('Current Weather for 1 Apple Park Way, Cupertino, CA, 95014')
  end

  it 'gets weather for a specific non-US address' do
    visit root_path
    VCR.use_cassette('non_usa_address') do
      fill_in 'query', with: 'Sabadell, Spain 08205'
      click_button 'Get Weather'
    end
    expect(page).to have_content('Current Weather for Sabadell, Spain 08205')
  end

  it 'correctly displays cached weather' do
    $redis.flushall
    visit root_path
    VCR.use_cassette('77088') do
      fill_in 'query', with: '77088'
      click_button 'Get Weather'
    end
    expect(page).to_not have_content('This cached report')

    # this should load from cache 
    VCR.use_cassette('77088') do
      fill_in 'query', with: '77088'
      click_button 'Get Weather'
    end
    expect(page).to have_content('This cached report')

    # traveling ahead to 31 minutes so it get fresh weather
    travel_to Time.now + 31.minutes
    VCR.use_cassette('77088') do
      fill_in 'query', with: '77088'
      click_button 'Get Weather'
    end
    expect(page).to_not have_content('This cached report')
  end
end
