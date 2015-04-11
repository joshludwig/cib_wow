require 'rest-client'

module WowLootFeed
  def self.get_item_name(id)
    item_result = RestClient.get "https://us.api.battle.net/wow/item/#{id}?locale=en_US&apikey=#{ENV['BLIZZARD_API_KEY']}"
    item_hash = JSON.parse(item_result)
    if item_hash['name'].nil?
      name = 'Raid Finder Loot'
    else
      name = item_hash['name']
    end
    name
  end

  def self.get_new_items(last_check)
    result = RestClient.get "https://us.api.battle.net/wow/guild/area-52/cib?fields=news&locale=en_US&apikey=#{ENV['BLIZZARD_API_KEY']}"
    result_hash = JSON.parse(result)
    item_loot = result_hash['news']
    item_loot.select! { |v| Time.at(v['timestamp']/1000).to_datetime > last_check }
    items = item_loot.map { |x| {character: x['character'], item: get_item_name(x['itemId']), url: "http://www.wowhead.com/item=#{x['itemId']}"} }
    items
  end

end

# usage
# timestamp for debugging
#last_check = Time.at(1428700980000/1000).to_datetime

#items = WowLootFeed::get_new_items last_check


