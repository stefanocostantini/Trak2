class ArchivesController < ApplicationController
  
  before_filter :login_required
  
  def index
    @archives = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'updated_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  
  end
  
  def delete
  	
  	@archive = current_user.tasks.find(params[:id])
    @archive.destroy

    @archives = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'updated_at DESC')
    
  end
  
  def recycle
  
  	@archive = current_user.tasks.find(params[:id])
  	
  	@archive.completeness = 0
  	@archive.now = true
  	@archive.later = false
  	@archive.archived = false
  	@archive.save
  	
  	@archives = current_user.tasks.find(:all, :conditions => { :archived => true }, :order => 'updated_at DESC')

  end
	
end
