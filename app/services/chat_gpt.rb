class ChatGpt 
  def initialize
    @client = OpenAI::Client.new
  end

  def send_message(messages)
    @client.chat(
      parameters: {
        model: "gpt-4-turbo",
        messages: ,
        temperature: 0.7,
        # max_tokens: 500,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0,
      }
    )
  end
end