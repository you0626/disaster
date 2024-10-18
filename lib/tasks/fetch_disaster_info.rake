# lib/tasks/fetch_disaster_info.rake
namespace :disaster_info do
  desc "Fetch latest disaster info from JMA"
  task fetch_latest: :environment do
    require 'net/http'
    require 'json'
    require 'time'

    uri = URI("https://www.jma.go.jp/bosai/quake/data/list.json")
    response = Net::HTTP.get(uri)
    earthquake_data = JSON.parse(response)

    earthquake_data.each do |earthquake|
      title = "地震 - #{earthquake['hypocenter']['name']}"
      occurred_at = Time.parse(earthquake['origin_time'])
      details = "マグニチュード: #{earthquake['magnitude']}, 最大震度: #{earthquake['max_intensity']}"
      location = earthquake['hypocenter']['name']

      # 既存のレコードを確認してから保存
      unless DisasterNotification.exists?(occurred_at: occurred_at, title: title)
        DisasterNotification.create!(
          title: title,
          occurred_at: occurred_at,
          details: details,
          location: location
        )
      end
    end
  end
end