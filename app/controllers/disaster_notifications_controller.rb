class DisasterNotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = DisasterNotification.all
  end

  def show
    @notification = DisasterNotification.find(params[:id])
  end

  def new
    @notification = DisasterNotification.new
  end

  def create
    @notification = DisasterNotification.new(notification_params)
    if @notification.save
      redirect_to @notification, notice: '災害通知が作成されました。'
    else
      render :new
    end
  end

  def edit
    @notification = DisasterNotification.find(params[:id])
  end

  def update
    @notification = DisasterNotification.find(params[:id])
    if @notification.update(notification_params)
      redirect_to @notification, notice: '災害通知が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @notification = DisasterNotification.find(params[:id])
    @notification.destroy
    redirect_to disaster_notifications_path, notice: '災害通知が削除されました。'
  end

  private

  def notification_params
    params.require(:disaster_notification).permit(:title, :description, :date)
  end
end