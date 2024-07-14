class CreateReactPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :react_photos do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :photo, foreign_key: true
      t.timestamps
    end
  end
end
