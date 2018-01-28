
class UserController < ApplicationController
    skip_before_action :verify_authenticity_token
    def home
        
    end
    
    def create
        username = params[:username]
        
        #return redirect_to :controller => "user", :action=>"show", :username => username
        
        baseurl = "http://api.github.com/" 
        profileUrl = baseurl + "users/" + username
        reposUrl = baseurl + "users/" + username + "/repos"
        
        repos = HTTParty.get(reposUrl).parsed_response
        if !repos || repos.length < 5
            return redirect_to "home"
        end
        logger.info repos
        User.where(:login => username).destroy_all
        reposInfo = []
        repos.each do |repo|
            repoInfo = {}
            logger.info repo["name"]
            repoInfo[:repoName] = repo["name"]
            repoInfo[:lang] = repo["language"]
            repoInfo[:created_at] = repo["created_at"]
            repoInfo[:updated_at] = repo["updated_at"]
            repoInfo[:commits_url] = repo["commits_url"]
            reposInfo.push(repoInfo)
        end
        langRes = getLangRes(reposInfo)
        commitsRes = countCommits(reposInfo, username)
        
        
        user_params = {}
        user_params["commits_num"] = commitsRes["commits_num"]
        user_params["big_repo_commits_num"] = commitsRes["big_repo_commits_num"]
        user_params["big_repo"] = commitsRes["big_repo"]
        user_params["late_commit_time"] = commitsRes["late_commit_time"]
        user_params["late_commit_repo"] = commitsRes["late_commit_repo"]
        user_params["most_commits_time"] = commitsRes["most_commits_time"]
        user_params["most_commits_num"] = commitsRes["most_commits_num"]
        user_params["old_repo_time"] = commitsRes["old_repo_time"]
        user_params["old_repo"] = commitsRes["old_repo"]
        user_params[:lang1] = (langRes.length > 0) ? langRes[0][0] : nil
        user_params[:lang1num] = (langRes.length > 0) ? langRes[0][1] : nil
        user_params[:lang2] = (langRes.length > 1) ? langRes[1][0] : nil
        user_params[:lang2num] = (langRes.length > 1) ? langRes[1][1] : nil
        user_params[:lang3] = (langRes.length > 2) ? langRes[2][0] : nil
        user_params[:lang3num] = (langRes.length > 2) ? langRes[2][1] : nil
        user_params[:avatar_url] = user[:avatar_url]
        user_params[:html_url] = user[:html_url]
        user_params[:name] = user[:name]
        user_params[:public_repos] = user[:public_repos]
        user_params[:followers] = user[:followers]
        user_params[:following] = user[:following]
        user_params[:login] = user[:login]
        user_params[:createat] = user[:created_at]
        user_params[:updateat] = user[:updated_at]

        User.create(user_params)
        #puts params[:username]
        redirect_to :controller => "user", :action=>"show", :username => username
    end
    
    def show
        @username = params[:username]
        @image = User.find_by_login(@username).avatar_url
        @user = User.find_by_login(@username)
        @keyword = getKeyword(@user)
        render "show"
    end
    
    def getKeyword(user)
        
        if user.followers.to_i > 100
            return "POPULAR"
        elsif user.commits_num.to_i > 200
            return "CONSISTENT"
        elsif user.lang1 == "Java"
            return "STRONG"
        elsif user.lang1 == "C"
            return "OLD SCHOOL"
        elsif user.public_repos.to_i > 20
            return "RICH"
        elsif user.following > 100
            return "FRIEND"
        elsif user.login.length > 15
            return "FREE"
        else
            return "OPEN"
        end
        
    end
    
    def getLangRes(reposInfo)
        langs = {}
        reposInfo.each do |repo|
            if !langs.key?(repo[:lang])
                langs[repo[:lang]] = 0
            end
            langs[repo[:lang]] += 1
        end
        langs.sort_by{|_key, value| value}
        nLang = (langs.length < 3) ? langs.length : 3
        langRes = []
        langs.each do |lang|
            if nLang == 0
                break
            end
            langRes.push(lang)
            nLang -= 1
        end
        return langRes
    end
    
    def countCommits(reposInfo, username)
        old_repo = nil
        old_repo_time = "9999-09-13T19:39:51Z"
        commits_num = 0
        big_repo_commits_num = 0
        big_repo = nil
        late_commit_time = 0
        late_commit_repo = nil
        most_commits_time = nil
        most_commits_num = 0
      
        late_commit_ptime = 0
        most_commits_hash = {}
        baseurl = "http://api.github.com/repos/" + username
        reposInfo.each do |repo|
            repoName = repo[:repoName]
            commitsUrl = baseurl + "/" + repoName + "/commits?page=1&per_page=200"
            commits = HTTParty.get(commitsUrl).parsed_response
            commitsNum = commits.length
            commits_num += commitsNum
            if commitsNum > big_repo_commits_num
                big_repo_commits_num = commitsNum
                big_repo = repoName
            end
            if old_repo_time > repo[:created_at]
                old_repo_time = repo[:created_at]
                old_repo = repoName
            end
            commits.each do |commit|
                datetime = commit["commit"]["author"]["date"]
                #"2017-09-13T19:39:51Z"
                date = datetime[0, 10]
                time = datetime[11, 8]
                if !most_commits_hash.key?(date)
                    most_commits_hash[date] = 0
                end
                most_commits_hash[date] += 1
                if most_commits_hash[date] > most_commits_num
                    most_commits_num = most_commits_hash[date]
                    most_commits_time = datetime
                end
                hour = time[0, 2].to_i
                hour = (hour > 0 && hour < 5) ? hour + 24 : hour
                min = time[3, 2].to_i
                sec = time[6, 2].to_i
                ptime = hour * 3600 + min * 60 + sec
                if ptime > late_commit_ptime
                    late_commit_ptime = ptime
                    late_commit_time = datetime
                    late_commit_repo = repoName
                end
            end
        end
        res = {}
        res["commits_num"] = commits_num
        res["big_repo_commits_num"] = big_repo_commits_num
        res["big_repo"] = big_repo
        res["late_commit_time"] = late_commit_time
        res["late_commit_repo"] = late_commit_repo
        res["most_commits_time"] = most_commits_time
        res["most_commits_num"] = most_commits_num
        res["old_repo_time"] = old_repo_time
        res["old_repo"] = old_repo
        return res
    end
end