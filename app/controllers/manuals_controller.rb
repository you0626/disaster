# app/controllers/manuals_controller.rb
class ManualsController < ApplicationController
  def index
    # ここでマニュアルのリストを取得して返します
    manuals = [
      { title: "地震マニュアル", path: earthquake_manual_index_path },
      { title: "台風マニュアル", path: typhoon_manual_index_path }
    ]
    render json: manuals
  end
end