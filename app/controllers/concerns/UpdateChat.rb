class UpdateChat 
  def initialize(chat, message)
    @chat = chat
    @message = message
  end
    
  def update  
    @chat_gpt = ChatGpt.new

    if @chat.open? 
      messages = build_messages
      
      @chat.update(questions_and_answers: @chat.questions_and_answers + [@message])
      
      update_chat
      response = send_gpt_message(messages)

      @chat.update(questions_and_answers: @chat.questions_and_answers + [parse_gpt_response(response)])

      if response.choices[0].message.content.include?(Prompt::StartChat.farewell) 
        
        messages = [{ 'role' => 'system', 'content' => Prompt::ResumeChat.resume_chat(@chat.join_messages) }]
        response = send_gpt_message(messages)
        resume_hash = parse_gpt_response_json(response)
        
        @resume = Resume.create(chat: @chat)
        @chat.update(status: :closed)
        @resume.update(resume_hash) if resume_hash.class == Hash
      end
    end
  end

  private

  def update_chat
    Turbo::StreamsChannel.broadcast_update_to('chats', target: 'ongoing_chat', partial: 'chats/chat', locals: { chat: @chat })
  end

  def build_messages 
    if @chat.questions_and_answers.size == 1 
      messages = [
        { 'role' => 'system', 'content' => @chat.prompt },
        { 'role' => 'assistant', 'content' => @chat.questions_and_answers.first },
        { 'role' => 'user', 'content' => @message }
      ]
    else
      messages = @chat.questions_and_answers.map.with_index { |qa, index| { 'role' => index.even? ? 'user' : 'assistant', 'content' => qa} }
      messages.unshift({ 'role' => 'system', 'content' => @chat.prompt })
      messages << { 'role' => 'user', 'content' => @message}
    end

    messages
  end

  def send_gpt_message(messages)
    gpt_response = @chat_gpt.send_message(messages)
    JSON.parse(gpt_response.to_json, object_class: OpenStruct)
  end

  def parse_gpt_response(response)
    response.choices[0].message.content
  end

  def parse_gpt_response_json(response)
    response_json_markdown = parse_gpt_response(response)
    response_json = response_json_markdown.gsub(/```json\n/, '').gsub(/\n```/, '')
    JSON.parse(response_json, symbolize_names: true)
  end
end