class CreateReactAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :react_albums do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :album, foreign_key: true
      t.timestamps
    end
  end
end
