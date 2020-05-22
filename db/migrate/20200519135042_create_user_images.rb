class CreateUserImages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_images do |t|
      t.string :image_url
      t.boolean :is_cover_active
      t.boolean :is_profile_active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
