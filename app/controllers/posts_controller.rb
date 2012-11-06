class PostsController < ApplicationController

  # authenticate admin
  before_filter :signed_in_admin, only: [:edit, :update, :show]
  before_filter :correct_admin, only: [:edit, :update, :show]
  respond_to :html, :xml, :json

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # Creates new comment
  # Input: author and content strings
  # Output: new comment with author and content attributes set, votes = 0
  def comment
    set_cors_headers
    if @post = Post.find(params[:id])
      @author = params[:author].to_s
      @content = params[:content].to_s
      @comment = @post.comments.create(author: @author,
                                      content: @content,
                                      votes: 0,
                                      priority: 0)
    end
  end

  # Returns comment information in HTML
  # Sorts comments by votes, highest to lowest
  def retrieve
    set_cors_headers
    if @post = Post.find(params[:id])
      @priority = @post.comments.where('priority = 1').all.sort_by(&:votes).reverse
      @comments = @post.comments.where('priority < 1').all.sort_by(&:votes).reverse
      respond_with(@comments.to_json)
    end
  end

  # Sets priority bit for comment
  def priority
    @post = Post.find(params[:id])
    if @comment = Comment.find(params[:cid])
      @comment.set_priority
    end
    redirect_to @post
  end

  # Alters vote count of specified comment
  # Input: comment ID
  # Output: updated comment with new vote count
  def vote
    set_cors_headers
    cookies[:voted] = Hash.new if ! cookies[:voted]
    if @post = Post.find(params[:id])
      @post.increment_votes(params[:comment_id].to_i)
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_admin.posts.create(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  # Cross Origin Policy
  def set_cors_headers
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
    headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Referer, User-Agent"
    headers["Access-Control-Max-Age"] = "3600"
  end

  def resource_preflight
    set_cors_headers
    render :text => "", :content_type => "text/plain"
  end

  def resources
    set_cors_headers
    render :text => "OK here is your restricted resource!"
  end

  private

    # authenticate admin
    # ensure admin accessing post information is signed in
    def signed_in_admin
      redirect_to signin_url, notice: "Please sign in" unless signed_in?
    end

    # ensure admin accessing post information is the owner
    def correct_admin
      @post = Post.find(params[:id])
      @admin = Admin.find_by_id(@post.admin_id)
      redirect_to(root_path) unless current_admin?(@admin)
    end

end
