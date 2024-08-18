class ResumesController < ApplicationController 
  def show
    @resume = Resume.find(params[:id])
    render :show
  end
end