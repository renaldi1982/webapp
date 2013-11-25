

"#chat_login".onSubmit(function(event) {	
  	event.stop();  
	
  	this.send({  		
    	onSuccess: function() {    
    		var data = $.parseJSON(this.responseText);	    		    		    			    		    		
    		if(data.state == 1){
    			//alert("auth");
    			$('#field_chat').prop('disabled',false);    			
    			$('#input_chat').focus();
		   		$('#msg').text(data.msg).css({'font-weight': 'bold'});		   		
		   		$('#password_chat').prop('disabled', true);		   		
		   		$('#button_submit').prop('disabled', true);
		   		if($('#text_chat').val() == ""){
		   			$('#text_chat').append(data.time);
		   		}else{
		   			$('#text_chat').append("\n"+data.time);
		   		}		   					   				   	
    		}	    	
    		else{
    			$('#password_chat').focus();	
    			$('#password_chat').prop('value','');    					   		
    			alert("Wrong password, Please enter the right email password");    			    			    			   			
    		}   		    		    		
   		}
	});  		
  		  		  
});

"#chat_send".onSubmit(function(event){
	event.stop();
	
	this.send({
		onSuccess: function() {
			//alert("msg has been sent");				
			var data = $.parseJSON(this.responseText);	  
			$('#text_chat').prop('disabled', true);  
			if($('#text_chat').val() == ""){
		   			$('#text_chat').append(data.time);
		   		}else{
		   			$('#text_chat').append("\n"+data.chat+"\n"+data.msg+"\n");
		   	}
		   	$('#input_chat').focus();	
		   	$('#input_chat').prop('value', '');
		   	$('#input_send').prop('disabled', true);	 						
		}					
	});		
});
/*"#button_send".onClick(function(event){
	event.stop();	
	var input = $('#input_chat').val();		
	if($('#text_chat').val() == ""){		
		$('#text_chat').append(input);	
	}else{		
		$('#text_chat').append("\n"+input);		
	}			
});*/

"#button_change".onClick(function(event){
	event.stop();
	
	$('#input_send').prop('value','');	
	$('#input_send').prop('disabled', false);
	$('#input_send').focus();	
});

"#button_clear".onClick(function(event){
	event.stop();
	$('#text_chat').prop('value','');	
});
