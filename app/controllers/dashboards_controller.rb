class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all
    @register  = RegisterEmploye.new
  end


def register

  puts "you reach here"
  @register  = RegisterEmploye.new
  @new_register = RegisterEmploye.new(name: params[:register_employe][:name], email: params[:register_employe][:email])
  #if @new_register.save
    respond_to do |format|
      if @new_register.save
        #HomeevalutionNotifier.send_signup_email(@homeevalution).deliver_now
       # RegistrationMailer.welcome_user(@user, generated_password).deliver

        format.html { redirect_to root_url, notice: 'Successfully Recieved request from employe.' }
        format.json { render :show, status: :created, location: @new_register }
      else
        format.html { render :register_employe }
        format.json { render json: @new_register.errors, status: :unprocessable_entity }
      end
    end

end  


def employes_registered

@registered_employes = RegisterEmploye.all

 end 

def add_new_employe

  @user = User.new

end

def send_invitation

@user = User.find(params[:id])
RegistrationMailer.invite_employe(@user).deliver

end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dashboard_params
      params.fetch(:dashboard, {})
    end
end
