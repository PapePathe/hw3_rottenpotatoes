# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! do |m|
      m.title        = movie[:title]
      m.rating       = movie[:rating]
      m.release_date = movie[:title]
    end
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    if uncheck
      step "I uncheck \"ratings[#{rating.strip}]\""
    else      
      step "I check \"ratings[#{rating.strip}]\""
    end    
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
Then /^I should (not )?see following ratings in movies: (.*)$/ do |yes_or_no, ratings|
  ratings.split(',').each do |rating|
    if yes_or_no
      puts yes_or_no
      assert page.has_no_xpath?('//td', :text => rating.strip), "#{rating.strip} should not be in the #movies table."
    else
      assert page.has_xpath?('//td', :text => rating.strip), "#{rating.strip} should be in the #movies table."
    end
    
  end
end
