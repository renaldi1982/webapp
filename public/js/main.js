$(document).ready(function() {
	$('#chk_pass').change(function(){
	  
	  if(this.checked) {
	  	
	     //$('#password').val('',$('#password').data('previous_value'));
	    $('#password').val("");
	    $('#password').prop("disabled", false);
	    
	  } else {
	     //$('#password').data('previous_value',$('#password').val());
	    $('#password').val("Old password"); 	   
	    $('#password').prop('disabled', true);  
	     
	  }
	});
});
