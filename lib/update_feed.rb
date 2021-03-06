# get loot
# timestamp for debugging
# last_check = Time.at(1428701100000/1000).to_datetime

live = '{"text": "Loot feed is live","username": "loot-bot", "icon_emoji": ":metal:"}'
RestClient.post "https://hooks.slack.com/services/#{ENV['SLACK_API_KEY']}", live

loot_thread = Thread.new {
  last_check = DateTime.now + (1/24.0)
  while true
    items = WowLootFeed::get_new_items last_check
    unless items.empty?
      last_check = Time.at(items[0][:timestamp]/1000).to_datetime
    end
# update slack
    payloads = SlackWebHook::create_payloads(items)
    SlackWebHook::update_slack(payloads)
    sleep 5
  end
}
loot_thread.run
