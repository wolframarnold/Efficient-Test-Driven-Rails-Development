Given /^I make a (\w+) request to (\S+) with post body$/ do |verb, url, post_body|
  post_body_ruby = JSON.parse(post_body)
  send(verb.downcase, url, post_body_ruby)
end

Then /^I should get a (\d+) response code$/ do |response_code|
  response.response_code.should == response_code.to_i
end

And /^there should be an? (\w+) record with (\w+)=="([^"]+)"$/ do |model_class, key, val|
  ActiveRecord.const_get(model_class).exists?({key.to_sym => val}).should be_true
end
