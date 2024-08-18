class ChatsController < ApplicationController 

  def index 
  end
    
  def create 
    @chat = Chat.create(prompt: Prompt::StartChat.initial_prompt, questions_and_answers: [Prompt::StartChat.initial_message])
    redirect_to chat_path(@chat)
  end

  def show 
    @chat = Chat.find(params[:id])
  end

  def update 
    @chat = Chat.find(params[:id])

    UpdateChat.new(@chat, chat_params[:message]).update
  end

  private

  def chat_params
    params.require(:chat).permit(:message)
  end
end