$(document).ready(function() {
	$('#chk_pass').change(function(){
	  
	  if(this.checked) {
<<<<<<< HEAD
	  		    
=======
	  	
	     //$('#password').val('',$('#password').data('previous_value'));
>>>>>>> 639cc153cc5157a8527b2f6e2934d32995abad57
	    $('#password').val("");
	    $('#password').prop("disabled", false);
	    
	  } else {
<<<<<<< HEAD
	     
=======
	     //$('#password').data('previous_value',$('#password').val());
>>>>>>> 639cc153cc5157a8527b2f6e2934d32995abad57
	    $('#password').val("Old password"); 	   
	    $('#password').prop('disabled', true);  
	     
	  }
	});
});
