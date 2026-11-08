class CreateSiteConfigurations < ActiveRecord::Migration[8.1]
  def change
    create_table :site_configurations do |t|
      t.string :site_name
      t.string :tagline

      t.string :phone_number
      t.string :email
      t.text :address

      t.string :meta_title
      t.text :meta_description
      t.string :meta_keywords
      t.string :canonical_url
      t.string :robots, default: "index, follow"

      t.string :og_title
      t.text :og_description
      t.string :og_image_url
      t.string :og_type, default: "website"

      t.string :twitter_card, default: "summary_large_image"
      t.string :twitter_site

      t.string :google_analytics_id
      t.string :google_site_verification

      t.timestamps
    end
  end
end