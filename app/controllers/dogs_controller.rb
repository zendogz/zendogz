class DogsController < ApplicationController

  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = Dog.for(current_user)
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
    @dog = Dog.find(params[:id])
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
    @dog = Dog.find(params[:id])
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    respond_to do |format|
      if @dog.save
        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dog }
      else
        format.html { render action: 'new' }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    @dog = Dog.find(params[:id])
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :breed, :colour, :born_on)
    end

    def current_resource
      @current_resource ||= Dog.find(params[:id]) if params[:id]
    end

end
