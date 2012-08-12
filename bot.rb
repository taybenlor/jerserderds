require 'twitter'
require './ermahgerd'

Twitter.configure do |config|
  config.consumer_key = "OQnvPUHbElulodydKqRfg"
  config.consumer_secret = "3SQYeQXd5Zfz7EBA77Im6jqOBwVvJlZmktSFvJzm58"
  config.oauth_token = "749158362-UuNrCEF1KXF3lTsk2yaqLKdlEnz6Ng1WNh6Hff3y"
  config.oauth_token_secret = "KPWMGy7jYnzLtXwBAIYQt4hrF37DXazBnaO8I26O8"
end

copying_user = "jessedodds"
myself = "jerserderds"

most_recent_time = Twitter.user_timeline(myself, count: 1).first.created_at

twats = Twitter.user_timeline(copying_user, exclude_replies: true).reject { |t| 
  t.created_at < most_recent_time
}

#twats = [Twitter.user_timeline(copying_user, exclude_replies:true).first]

twats.each do |twat|
  begin
    text = Ermahgerd.ternslert_terkst(twat.text.gsub('@', ''))
    Twitter.update text
    sleep 60 + rand(40)
  rescue
  end
end