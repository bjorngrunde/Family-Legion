class AddProfileMetaDataToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :profile_meta_data, :text
  end
end
