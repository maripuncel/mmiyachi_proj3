class AdminsController < ApplicationController
  # authenticate admin
  before_filter :signed_in_admin, only: [:edit, :update, :show]
  before_filter :correct_admin, only: [:edit, :update, :show]

  # GET /admins/1
  # GET /admins/1.json
  def show
    @admin = Admin.find(params[:id])
    @posts = @admin.posts

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.json
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        sign_in @admin
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render json: @admin, status: :created, location: @admin }
      else
        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.json
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end

  private

    # authenticate admin
    # allows access to only signed in users
    def signed_in_admin
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    # allows access to only specific admin
    def correct_admin
      @admin = Admin.find(params[:id])
      redirect_to(root_path) unless current_admin?(@admin)
    end

end
