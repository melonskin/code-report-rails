class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :avatar_url
      t.string :html_url
      t.string :name
      t.string :public_repos
      t.string :followers
      t.string :following
      t.timestamp :createat
      t.timestamp :updateat

      t.timestamps
    end
  end
end
