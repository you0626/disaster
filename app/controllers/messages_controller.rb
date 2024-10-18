class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]

  # メッセージ一覧表示 (最新100件)
  def index
    @messages = Message.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
                       .order(updated_at: :desc)
                       .limit(100)

    # 101件目以降の古いメッセージを削除
    Message.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
           .order(updated_at: :desc)
           .offset(100)
           .delete_all  # destroy_all から delete_all へ変更
  end

  def new
    @message = Message.new
    @friends = current_user.friends  # フレンドを選べるようにする
  end

  # メッセージ作成
  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    if @message.save
      flash[:notice] = "メッセージが送信されました。"
      redirect_to messages_path
    else
      flash[:alert] = "メッセージの送信に失敗しました。"
      @friends = current_user.friends  # 失敗した場合も再度フレンドを表示
      render :new
    end
  end

  # メッセージ編集ページ表示
  def edit
  end

  # メッセージの更新
  def update
    if @message.update(message_params)
      flash[:notice] = "メッセージが更新されました。"
      redirect_to messages_path
    else
      flash[:alert] = "メッセージの更新に失敗しました。"
      render :edit
    end
  end

  # メッセージの削除
  def destroy
    @message.destroy
    flash[:notice] = "メッセージが削除されました。"
    redirect_to messages_path
  end

  private

  # メッセージを取得
  def set_message
    @message = Message.find(params[:id])
  end

  # ストロングパラメータ
  def message_params
    params.require(:message).permit(:recipient_id, :content)
  end
end