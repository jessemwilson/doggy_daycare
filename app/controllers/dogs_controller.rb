class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :all_breeds, only: [:new, :edit, :index]
  before_action :all_owners, only: [:new, :edit]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin!, except: [:index, :show]


  # GET /dogs
  # GET /dogs.json
  def index

    #if we have parameter, then only give me dogs that match
    if params[:search]
      @dogs = Dog.where("name LIKE ?", "%#{params[:search]}%")
      if @dogs.size.zero?
        flash[:notice] = "Sorry, no result found."
        @dogs =Dog.all
      end
    elsif params[:breed_id]
      @dogs =Dog.where(breed_id: params[:breed_id])
    else
      #else give me all dogs
      @dogs = Dog.order("name")    
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
    
  end

  # GET /dogs/1/edit
  def edit
   
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)

    respond_to do |format|
      if @dog.save
        format.html { redirect_to dogs_path, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to dogs_path, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    def all_breeds
     @breeds=Breed.order("breed_name")

  end

  def all_owners
        @owners=Owner.order("last_name")
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :breed_id, :owner_id, :med_cond, :vet, :dob, :avatar, :in_daycare)
    end
end
