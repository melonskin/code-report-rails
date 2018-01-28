class UserController < ApplicationController
    skip_before_action :verify_authenticity_token
    def home
        
    end
    
    def create
        #@user = params[:username]
        #puts params[:username]
        redirect_to :controller => "user", :action=>"show", :username => params[:username]
    end
    
    def show
        @username = params[:username]
        render "show"
    end
    
    
end
