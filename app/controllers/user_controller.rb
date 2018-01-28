
class UserController < ApplicationController
    skip_before_action :verify_authenticity_token
    def home
        
    end
    
    def create
        username = params[:username]
        User.where(:login => username).destroy_all
         
        user = Octokit.user username
        user_params = {}
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
        render "show"
    end
    
    
end
