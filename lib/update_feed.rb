# get loot
# timestamp for debugging
# last_check = Time.at(1428701100000/1000).to_datetime

loot_thread = Thread.new {
  last_check = DateTime.now + (1/24.0)

  while true
    puts 'Get items'
    items = WowLootFeed::get_new_items last_check
    puts 'Got items'
# update slack
    payloads = SlackWebHook::create_payloads(items)
    puts 'Send to slack'
    SlackWebHook::update_slack(payloads)
    puts 'Sent to slack'
    last_check = DateTime.now + (1/24.0)
    sleep 15
  end
}
loot_thread.run
