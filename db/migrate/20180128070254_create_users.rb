class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :avatarurl
      t.string :htmlurl
      t.string :name
      t.string :repos
      t.string :followers
      t.string :following
      t.timestamp :createat
      t.timestamp :updateat

      t.timestamps
    end
  end
end
