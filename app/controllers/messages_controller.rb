class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  #before_filter :authenticate_user!
  def index
    @messages = if params[:q].blank?
      Message.all.paginate(:per_page => 30, :page => params[:page])
  else
   poisk = Message.search(:include => [:address, :category, :subject, :address => :organization]) do |s|
      s.keywords params[:q], :highlight => true, :merge_continuous_fragments => true, :phrase_fields => {:title => 2.0, :from => 1.5}
    end
    poisk.results
    end
  @total_hits = poisk.total if poisk
  @total_messages = Message.all.length.to_s
  calc_properly

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end

  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to(@message, :notice => 'Message was successfully created.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end

  def search
    @search = Message.search(:include => [:address, :category, :subject, :organization]) do
      keywords[params[:q]]
    end
  end

  private
  def calc_properly
    @cl_result = 0
  Message.all.each do |mes|
    if mes.assigned_category.downcase == mes.category.title.downcase
      @cl_result += 1
    end
  end

  end

end

