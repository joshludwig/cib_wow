# example curl command
# curl -X POST --data-urlencode 'payload={"text": "This is posted to <#general> and comes from *monkey-bot*.", "channel": "#general", "username": "monkey-bot", "icon_emoji": ":monkey_face:"}' https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX

module SlackWebHook
  def self.create_payloads(items)
    payloads = items.map { |x|
      {
          text: "#{x[:character]}: <#{x[:url]}|#{x[:item]}>",
          channel: '#wow-loot-feed',
          username: 'loot-bot',
          icon_emoji: ':metal:'
      }
    }
    payloads
  end

  def self.update_slack(payloads)
    unless payloads.empty?
      payloads.each do |payload|
        RestClient.post "https://hooks.slack.com/services/#{ENV['SLACK_API_KEY']}", payload.to_json
      end
    end
  end
end
