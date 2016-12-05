module MessagesHelper
  def self_or_other(message)
    message.user == current_user ? "self" : "other"
  end

  def message_interlocutor(message)
    message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end

  def broadcast(channel, &block)
	  message = {:channel => channel, :data => capture(&block)}
	  uri = URI.parse("http://localhost:9292/faye")
	  Net::HTTP.post_form(uri, :message => message.to_json)
	end
end
