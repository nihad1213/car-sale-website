class AddHeroStatsToSiteConfigurations < ActiveRecord::Migration[8.1]
  def change
    add_column :site_configurations, :listings_count, :string
    add_column :site_configurations, :dealers_count, :string
    add_column :site_configurations, :satisfaction_rate, :string
  end
end
