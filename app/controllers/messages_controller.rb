class MessagesController < ApplicationController
	before_filter :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
    if @conversation.with_hibot?
      reply = { body: HTTParty.post("http://52.91.190.38:8000/api/chatbot/", 
                :body => { :text => params[:message][:body]}).to_s } 
      @reply = @conversation.messages.build(reply)
      @reply.user_id = User.find_by_profile_name("hibot").id
      @reply.save!
    end

    @path = conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
