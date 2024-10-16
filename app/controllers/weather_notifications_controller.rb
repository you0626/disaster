class WeatherNotificationsController < ApplicationController
  require 'net/http'
  require 'json'

  def index
    # fetched_atで降順に並べた後、地方ごとにグループ化
    @weather_notifications = WeatherNotification.all.order(fetched_at: :desc)
    @grouped_notifications = @weather_notifications.group_by { |notification| notification.title }
  end
  
  def fetch_and_save
    # 地方ごとの地域IDを定義
    regions = {
      '北海道' => [
        '011000', # 宗谷地方
        '012000', # 上川・留萌地方
        '013000', # 網走・北見・紋別地方
        '014100', # 釧路・根室地方
        '015000', # 胆振・日高地方
        '016000', # 石狩・空知・後志地方
        '017000'  # 渡島・檜山地方
      ],
      '東北' => [
        '020000', # 青森県
        '030000', # 岩手県
        '040000', # 宮城県
        '050000', # 秋田県
        '060000', # 山形県
        '070000'  # 福島県
      ],
      '関東' => [
        '080000', # 茨城県
        '090000', # 栃木県
        '100000', # 群馬県
        '110000', # 埼玉県
        '120000', # 千葉県
        '130000', # 東京都
        '140000', # 神奈川県
        '190000'  # 山梨県
      ],
      '中部' => [
        '150000', # 新潟県
        '160000', # 富山県
        '170000', # 石川県
        '180000', # 福井県
        '200000', # 長野県
        '210000', # 愛知県
        '220000', # 静岡県
        '230000', # 岐阜県
        '240000', # 三重県
        '250000'  # 滋賀県
      ],
      '近畿' => [
        '260000', # 京都府
        '270000', # 大阪府
        '280000', # 兵庫県
        '290000', # 奈良県
        '300000'  # 和歌山県
      ],
      '中国' => [
        '310000', # 鳥取県
        '320000', # 島根県
        '330000', # 岡山県
        '340000', # 広島県
        '350000'  # 山口県
      ],
      '四国' => [
        '360000', # 徳島県
        '370000', # 香川県
        '380000', # 愛媛県
        '390000'  # 高知県
      ],
      '九州/沖縄' => [
        '400000', # 福岡県
        '410000', # 佐賀県
        '420000', # 長崎県
        '430000', # 熊本県
        '440000', # 大分県
        '450000', # 宮崎県
        '460100', # 鹿児島県（奄美地方除く）
        '471000', # 沖縄本島地方
        '472000', # 大東島地方
        '473000', # 宮古島地方気象台
        '474000'  # 八重山地方
      ]
    }

    # 各地域の情報を取得
    regions.each do |region_name, region_ids|
      region_ids.each do |region_id|
        url = "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/#{region_id}.json"
        response = Net::HTTP.get(URI(url))

        # デバッグ用にレスポンスの中身を確認
        Rails.logger.info "取得したデータ (地域ID: #{region_id}): #{response}"

        # レスポンスが空でないかチェック
        if response.present?
          data = JSON.parse(response)

          # 地方名を含めてデータを保存
          WeatherNotification.create!(
            title: "#{region_name}の気象情報",
            content: data['text'],
            fetched_at: Time.current
          )
        else
          Rails.logger.error "地域ID: #{region_id} の気象情報を取得できませんでした。"
        end
      end
    end

    flash[:notice] = '最新の気象情報を取得しました。'
    redirect_to weather_notifications_path
  end
end