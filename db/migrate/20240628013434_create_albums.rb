class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.boolean :isPrivate
      t.integer :numOfLikes
      t.integer :numOfPhotos
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
