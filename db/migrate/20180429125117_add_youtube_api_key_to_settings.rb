class AddYoutubeApiKeyToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :youtube_api_key, :string
  end
end
