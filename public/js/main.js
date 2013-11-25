$(document).ready(function() {
	$('#chk_pass').change(function(){
	  
	  if(this.checked) {
	  		    
	    $('#password').val("");
	    $('#password').prop("disabled", false);
	    
	  } else {
	     
	    $('#password').val("Old password"); 	   
	    $('#password').prop('disabled', true);  
	     
	  }
	});
});
