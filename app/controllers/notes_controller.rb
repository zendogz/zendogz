class NotesController < ApplicationController
  # GET /dogs/:dog_id/notes
  # GET /dogs/:dog_id/notes.json
  def index
    @dog = Dog.find(params[:dog_id])
    @notes = @dog.notes
  end

  # GET /dogs/:dog_id/notes/:id
  # GET /dogs/:dog_id/notes/:id.json
  def show
    @note = Note.find(params[:id])
  end

  # GET /dogs/:dog_id/notes/new
  def new
    @dog = Dog.find(params[:dog_id])
    @note = @dog.notes.build(note_params)
  end

  # GET /dogs/:dog_id/notes/:id/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /dogs/:dog_id/notes
  # POST /dogs/:dog_id/notes.json
  def create
    @dog = Dog.find(params[:dog_id])
    @note = @dog.notes.build(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/:dog_id/notes/:id
  # PATCH/PUT /dogs/:dog_id/notes/:id.json
  def update
    @note = Note.find(params[:id])
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/:dog_id/notes/:id
  # DELETE /dogs/:dog_id/notes/:id.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:note)
  end
end
