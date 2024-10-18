# lib/tasks/fetch_weather_info.rake
namespace :weather_info do
  desc "Fetch weather information from JMA"
  task fetch: :environment do
    require 'net/http'
    require 'open-uri'
    require 'nokogiri'

    # 気象庁のXMLデータを取得するURL
    url = 'https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.xml'

    # XMLデータを取得
    xml_data = URI.open(url).read

    # Nokogiriでパース
    doc = Nokogiri::XML(xml_data)

    # 必要な情報を抽出（例: タイトルや詳細など）
    title = doc.xpath('//Title').text
    body_text = doc.xpath('//Text').text

    # 取得したデータをログに出力（あるいはデータベースに保存）
    Rails.logger.info "タイトル: #{title}"
    Rails.logger.info "詳細: #{body_text}"

    # 取得したデータをデータベースに保存する例
    WeatherNotification.create!(
      title: title,
      content: body_text,
      fetched_at: Time.zone.now
    )
  end
end