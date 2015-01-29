class CreateShortUrlsTable < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.timestamps
      t.string :forward
    end
  end
end
