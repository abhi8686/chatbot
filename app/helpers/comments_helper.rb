module CommentsHelper
	def broadcast(channel, &block)
	  message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
	  uri = URI.parse("http://localhost:9292/faye")
	  Net::HTTP.post_form(uri, :comment => message.to_json)
	end
end
