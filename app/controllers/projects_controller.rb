class ProjectsController < ApplicationController

  in_place_edit_for :project, :name
  in_place_edit_for :project, :colour


  # GET /projects
  # GET /projects.xml
  def index
    @projects = current_user.projects.find(:all, :order => 'name ASC')
    
    @tasks = current_user.tasks.find(:all)
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
    
    @tasks_now_count = current_user.tasks.count(:all, :conditions => { :now => true })
    @tasks_later_count = current_user.tasks.count(:all, :conditions => { :later => true})
    @tasks_archived_count = current_user.tasks.count(:all, :conditions => { :archived => true})
    
    @tasks_now_avg = current_user.tasks.average('completeness',:conditions => { :now => true })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = current_user.projects.find(params[:id])
    
    @tasks = current_user.tasks.find(:all)
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
    
    @tasks_now_count = current_user.tasks.count(:all, :conditions => { :now => true })
    @tasks_later_count = current_user.tasks.count(:all, :conditions => { :later => true})
    @tasks_archived_count = current_user.tasks.count(:all, :conditions => { :archived => true})
    
    @tasks_now_avg = current_user.tasks.average('completeness',:conditions => { :now => true })
    @projects = current_user.projects.find(:all, :order => 'name ASC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = current_user.projects.new
    @tasks = current_user.tasks.find(:all)
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
    
    @tasks_now_count = current_user.tasks.count(:all, :conditions => { :now => true })
    @tasks_later_count = current_user.tasks.count(:all, :conditions => { :later => true})
    @tasks_archived_count = current_user.tasks.count(:all, :conditions => { :archived => true})
    
    @tasks_now_avg = current_user.tasks.average('completeness',:conditions => { :now => true })
    @projects = current_user.projects.find(:all, :order => 'name ASC')


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = current_user.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = current_user.projects.new(params[:project])
    @project.save
    
	#redirect_to :controller => 'projects', :action => 'index'
	@projects = current_user.projects.find(:all, :order => 'name ASC')
	
	
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = current_user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  #def destroy
   # @project = current_user.projects.find(params[:id])
   # @project.destroy
    
   # redirect_to :controller => 'projects', :action => 'index'
      
      
   # end
    
   def delete
    	
    @project = current_user.projects.find(params[:id])
    @project.destroy
    	
    @projects = current_user.projects.find(:all, :order => 'name ASC')
      
   end

end
