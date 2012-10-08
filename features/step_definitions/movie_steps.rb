# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.should match /#{e1}.*?#{e2}/m
end

Then /I should see all of the movies/ do
  Movie.all.each do |movie_record|
    movie_title = movie_record.title
    if page.respond_to? :should
      page.should have_content(movie_title)
    else
      assert page.has_content?(movie_title)
    end
  end  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  splited_Str = rating_list.split
  if uncheck
    splited_Str.each do |rate|
      uncheck("ratings_#{rate}")
    end
  else
    splited_Str.each do |rate|
      check("ratings_#{rate}")
    end
  end
end


Then /^the director of "(.*?)" should be "(.*?)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  assert_equal movie.director, director
end


