$(document).ready(function () {
	
		$(document).on('click',"#update_class",function () 
	   {	
	   	
	       	myFunction();
	    });
	}); 
	

	function myFunction() {
		
		var select_val = $('#mySelect').val();
		var punch_in_val = $('#input-punch_In-time').val();
		var punch_out_val = $('#input-punch_out-time').val();
		var user_id = $('#popup_edit_punch_user').val();
		
		debugger
		$.ajax({
			dataType:'script',
		    type:'post',
		    url:'/popup_update_punch',
		    data: { 
		    	user: user_id,
		    	status_id: select_val,
		    	punch_out: punch_out_val,
		     	punch_in: punch_in_val
		     },
    		success: function (result) {
		        //do somthing here
		        window.alert("popup,success!!");
		     },
		     error: function (){
		     	
		        window.alert("popup, something wrong!");
		     }
  		});
	}