// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require private_pub
//= require turbolinks
//= require jquery-fileupload/basic
//= require bootstrap
//= require bootstrap-switch
//= require js-routes
//= require_tree .

	var ready = function() {
		
		$('.btn-toggle').click(function(e) {
			e.preventDefault();

			var user_id = $(this).data('user-id');
			
			$.ajax({
			    url: "/users/" + user_id + "/state_facebook",
			    type: 'PATCH'
			 });
			$(this).find('.btn').toggleClass('active'); 
		    if($(this).find('.btn-info').size() > 0) {
		    	$(this).find('.btn').toggleClass('btn-info');
		    }
		    else{
		    	$(this).find('.btn').toggleClass('btn-default');
		    }
		    	       
		});

		$('.btn-toggle2').click(function(e) {
			e.preventDefault();

			var user_id = $(this).data('user-id');
			
			$.ajax({
			    url: "/users/" + user_id + "/state_twitter",
			    type: 'PATCH'
			 });
			$(this).find('.btn').toggleClass('active'); 
		    if($(this).find('.btn-info').size() > 0) {
		    	$(this).find('.btn').toggleClass('btn-info');
		    }
		    else{
		    	$(this).find('.btn').toggleClass('btn-default');
		    }
		    	       
		});
	 



	    $('.start-conversation').click(function(e) {
	        e.preventDefault();

	        var sender_id = $(this).data('sid');
	        var recipient_id = $(this).data('rip');

	        $.post("/conversations", { sender_id: sender_id, recipient_id: recipient_id }, function(data) {
	            chatBox.chatWith(data.conversation_id);
	        });
	    });


	    $(document).on('click', '.toggleChatBox', function(e) {
	        e.preventDefault();

	        var id = $(this).data('cid');
	        chatBox.toggleChatBoxGrowth(id);
	    });

	   

	    $(document).on('click', '.closeChat', function(e) {
	        e.preventDefault();

	        var id = $(this).data('cid');
	        chatBox.close(id);
	    });


	 

	    $(document).on('keydown', '.chatboxtextarea', function(event) {

	        var id = $(this).data('cid');
	        chatBox.checkInputKey(event, $(this), id);
	    });

	

	    $('a.conversation').click(function(e) {
	        e.preventDefault();

	        var conversation_id = $(this).data('cid');
	        chatBox.chatWith(conversation_id);
	    });


	}

	$(document).ready(ready);
	$(document).on("page:load", ready);
