class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]

  # GET /videos or /videos.json
  def index
    @videos = Video.all.nao_assistidos.order(:created_at)
  end

  # GET /videos/1 or /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  def create
    video_id = params[:video][:youtube_id][/v=([^&]+)/, 1]
    video = Yt::Video.new id: video_id
    titulo = video.title
    canal = video.channel_title

    @video = Video.new(youtube_id: video_id, titulo: titulo, canal: canal, desejo: params[:video][:desejo])

    respond_to do |format|
      if @video.save
        format.html { redirect_to root_path, notice: "Video was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    @video.update(assistido: :true)
    redirect_to root_path, notice: "Video foi marcado como assistido." 
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy!

    respond_to do |format|
      format.html { redirect_to videos_url, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:titulo, :canal, :youtube_id, :desejo)
    end
end
