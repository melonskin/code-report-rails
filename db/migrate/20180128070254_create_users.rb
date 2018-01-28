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
      t.string :createat
      t.string :updateat
      t.string :lang1
      t.string :lang2
      t.string :lang3
      t.string :lang1num
      t.string :lang2num
      t.string :lang3num
      t.string :commits_num
      t.string :late_commit_repo
      t.string :late_commit_time
      t.string :old_repo
      t.string :old_repo_time
      t.string :most_commits_time
      t.string :most_commits_num
      t.string :big_repo
      t.string :big_repo_commits_num
    end
  end
end
