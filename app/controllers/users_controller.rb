class UsersController < ApplicationController

  # render new.rhtml
  
  def index 
  	@users = User.all
  end
  
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
      
        @project = current_user.projects.new(params[:project])
        @project.name = 'I am a sample project. You may delete me now, or rename me'
        @project.colour = '#3366FF'
    	@project.save
    	
    	@task = current_user.tasks.new(params[:task])
    	@task.name = 'I am a sample task. Just to show you how it works'
    	@task.description = 'You may delete me if you do not need me...'
    	@task.project_id = 1
    	@task.now = true
    	@task.later = false
    	@task.archived = false
    	@task.completeness = 0
    	@task.save    
         
    else
      render :action => 'new'
    end
   
  end

end
