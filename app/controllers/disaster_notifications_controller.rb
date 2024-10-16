class DisasterNotificationsController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    # 地震データをAPIから取得
    uri = URI("https://www.jma.go.jp/bosai/quake/data/list.json")
    response = Net::HTTP.get(uri)

    # APIリクエストが成功しているか確認
    if response.nil? || response.empty?
      Rails.logger.error "APIレスポンスが空です。"
      @national_notifications = []
      return
    end

    earthquake_data = JSON.parse(response)

    # JSONデータの形式が想定通りか確認
    unless earthquake_data.is_a?(Array)
      Rails.logger.error "APIから返されたデータが期待した形式ではありません。: #{earthquake_data.inspect}"
      @national_notifications = []
      return
    end

    # デバッグ用に取得したデータをログに出力
    Rails.logger.info "取得した地震データ: #{earthquake_data.inspect}"

    one_week_ago = Time.zone.now - 1.week
    Rails.logger.info "一週間前の時間: #{one_week_ago}"

    # 災害通知をフィルタリング
    @national_notifications = earthquake_data.each_with_object([]) do |earthquake, notifications|
      origin_time = earthquake['origin_time']

      unless origin_time.present?
        Rails.logger.warn "origin_timeが存在しない地震データがあります。: #{earthquake.inspect}"
        next
      end

      begin
        occurred_time = Time.zone.parse(origin_time)
        Rails.logger.info "地震発生日時: #{occurred_time}"

        if occurred_time > one_week_ago
          notifications << {
            title: "地震",
            occurred_at: occurred_time,
            details: "マグニチュード: #{earthquake['magnitude']}, 最大震度: #{earthquake['max_intensity']}",
            location: earthquake['hypocenter']&.dig('name') || "場所不明"
          }
        end
      rescue => e
        Rails.logger.error "日付のパースに失敗しました: #{e.message}"
      end
    end

    # フィルタリングされた結果をログに出力
    Rails.logger.info "フィルタリングされた災害通知: #{@national_notifications.inspect}"
  end
end