## DEPRECATION NOTICE: Do not add new tests to this file!
##
## View and controller tests are deprecated in the Growstuff project. 
## We no longer write new view and controller tests, but instead write 
## feature tests (in spec/features) using Capybara (https://github.com/jnicklas/capybara). 
## These test the full stack, behaving as a browser, and require less complicated setup 
## to run. Please feel free to delete old view/controller tests as they are reimplemented 
## in feature tests. 
##
## If you submit a pull request containing new view or controller tests, it will not be 
## merged.





require 'rails_helper'

describe 'support/index.html.haml', :type => "view" do
  before(:each) do
    render
  end

  it 'should show support faq' do
    rendered.should have_content 'About Growstuff'
  end

  it 'should not mention Courtney any more' do
    rendered.should_not have_content 'Courtney'
    rendered.should_not have_content 'phazel'
  end
end
