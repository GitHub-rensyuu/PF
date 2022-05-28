class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    if Notice.where("created_at < ?", 30.days.ago).present?
      Notice.where("created_at < ?", 30.days.ago).delete_allif 
      p "30日前の通知を全て削除しました"
    end
  end
end