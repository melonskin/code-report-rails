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
      t.string :lang1
      t.string :lang2
      t.string :lang3
      t.string :lang1num
      t.string :lang2num
      t.string :lang3num
      t.string :commits_num
      t.string :late_commit_repo
      t.timestamp :late_commit_time
      t.string :old_repo
      t.timestamp :old_repo_time
      t.timestamp :most_commits_time
      t.string :big_repo
      t.string :big_repo_commits_num

      t.timestamps
    end
  end
end
