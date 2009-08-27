class TasksController < ApplicationController
  
  in_place_edit_for :task, :name
  in_place_edit_for :task, :description
  in_place_edit_for :task, :completeness

  before_filter :login_required
  
  # GET /tasks
  # GET /tasks.xml
  def index
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
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end
  
  def set_to_now
    @task = current_user.tasks.find(params[:id])
    @task.now = true
    @task.later = false
    @task.archived = false
    @task.save
    
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
  end
  
  def set_to_later
    @task = current_user.tasks.find(params[:id])
    @task.now = false
    @task.later = true
    @task.archived = false
    @task.save
    
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
  end
  
  def set_to_archived
    @task = current_user.tasks.find(params[:id])
    @task.now = false
    @task.later = false
    @task.archived = true
    @task.completeness = 100
    @task.updated_at = Time.now
    @task.save
    
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
  end
  
    
  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = current_user.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = current_user.tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = current_user.tasks.new(params[:task])
    @task.description = 'Click to add a note'
    @task.now = true
    @task.later = false
    @task.archived = false
    @task.completeness = 0
    @task.save
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    
    #respond_to do |format|
     # if @task.save
      #  flash[:notice] = 'Task was successfully created.'
       # format.html { redirect_to :action => 'index' }
        #format.xml  { render :xml => @task, :status => :created, :location => @task }
     # else
      #  format.html { render :action => "new" }
       # format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      #end
    #end
  
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = current_user.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    
    @tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')

   # respond_to do |format|
   #   format.html { redirect_to(tasks_url) }
   #   format.xml  { head :ok }
   # end
 
  end
  
  def delete_now
  
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    	
 	@tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
   
  end 
  
  def delete_later
  
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    	
    @tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')

  end
  
   def delete_archived
  
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    @tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')

  end
  
  
  def set_task_completeness
	task = Task.find(params[:id])
	task.completeness = params[:value]
	task.save
	@tasks_now = current_user.tasks.find(:all, :conditions => { :now => true }, :order => 'id DESC')
	@tasks_later = current_user.tasks.find(:all, :conditions => { :later => true }, :order => 'id DESC')
	@tasks_archived = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'id DESC')
	@task = task
  end
  
  def tooltip
  end
  
end
