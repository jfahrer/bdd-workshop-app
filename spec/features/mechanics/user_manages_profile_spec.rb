require 'rails_helper'

feature 'user manages profiles', js: true do
  before do
    # minimum profile exists
  end

  # errors
  scenario 'updating profile details fails' do
    When 'user tries to update their profile'
    But 'the database has gone down'
    Then 'an error message is shown'
  end

  context 'another profile exists' do
    scenario 'new handles must be unique' do
      When 'user tries to update handle to be the same as an existing one'
      Then 'a warning message is shown'
      When 'user refreshes the page'
      Then 'handle has not been updated'
      When 'user changes handle to something unique'
      Then 'profile is saved successfully'
    end

    scenario 'auto generating a new handle' do
      When 'user tries to update handle to be the same as an existing one'
      Then 'a warning message is shown'
      When 'user chooses to auto generate a handle'
      Then 'profile is saved successfully'
    end

    # warning
    scenario 'handle cannot be autogenerated' do
      When 'user tries to update handle to be the same as an existing one'
      But 'for some reason the handle cannot be generated at this time'
      Then 'a message is shown to try again later or contact support'
    end
  end

  describe 'profile pictures' do
    scenario 'uploading a profile picture' do
      When 'user uploads a profile picture'
      Then 'their uploaded picture is shown as the profile picture'
    end

    scenario 'selecting a gravatar as the profile picture' do
      When 'user chooses a gravatar for their profile picture'
      Then 'their selected gravatar is shown as the profile picture'
    end

    context 'profile picture has been uploaded to this users profile' do
      scenario 'switching between uploaded profile picture, gravatar and placeholder profile picture' do
        When 'user successfully uploads a new profile picture'
        Then 'profile picture is updated to new profile picture'
        When 'user deletes uploaded profile picture'
        Then 'profile picture is updated to placeholder'
        When 'user chooses gravatar'
        Then 'profile picture is updated to gravatar'
        When 'user successfully uploads a profile picture again'
        Then 'profile picture is updated to new profile picture'
        When 'user deletes uploaded profile picture'
        Then 'profile picture is updated to last selected gravatar'
      end
    end

    # warnings
    scenario 'uploading a profile picture fails' do
      When 'user attempts to upload a new profile picture'
      Then 'an error is thrown'
    end
  end
end