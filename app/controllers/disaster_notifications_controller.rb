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

    one_month_ago = Time.zone.now - 1.month
    Rails.logger.info "一ヶ月前の時間: #{one_month_ago}"

    # 災害通知をフィルタリング（震度3以上）
    @national_notifications = earthquake_data.each_with_object([]) do |earthquake, notifications|
      origin_time = earthquake['at'] # 発生時刻を取得（'at'を使用）

      unless origin_time.present?
        Rails.logger.warn "発生時刻が存在しない地震データがあります。: #{earthquake.inspect}"
        next
      end

      begin
        occurred_time = Time.zone.parse(origin_time)

        # 最大震度を取得
        max_intensity = earthquake['maxi'] # 震度情報を取得

        Rails.logger.info "地震データ: 最大震度: #{max_intensity}, 発生日時: #{occurred_time}"

        if occurred_time > one_month_ago && max_intensity.to_i >= 3
          notifications << {
            title: "地震",
            occurred_at: occurred_time,
            details: "マグニチュード: #{earthquake['mag']}, 最大震度: #{max_intensity}",
            location: earthquake['anm'] || "場所不明" # 地震の発生場所を取得
          }
        end
      rescue => e
        Rails.logger.error "日付のパースに失敗しました: #{e.message}"
      end
    end

    # フィルタリングされた結果をログに出力
    Rails.logger.info "フィルタリングされた災害通知: #{@national_notifications.inspect}"

    # @national_notificationsが空である場合の処理
    if @national_notifications.empty?
      Rails.logger.warn "過去1ヶ月間に震度3以上の地震がありません。"
    end
  end
end