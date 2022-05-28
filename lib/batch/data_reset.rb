class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    
    # 削除したものがあれば
    # if Notice.where("created_at < ?", 30.days.ago).present?
    #   Notice.where("created_at < ?", 30.days.ago).delete_allif 
    if Notice.where("created_at < ?", 2.minutes.ago).present?
      Notice.where("created_at < ?", 2.minutes.ago).delete_all
    # Notification.where("created_at < ?", 2.minutes.ago.beginning_of_day).delete_all
      p "30日前の通知を全て削除しました"
    end
  end

ends