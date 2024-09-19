function submit_me(){

	jQuery.post(
		the_ajax_script.ajaxurl, 
		jQuery("#theForm").serialize(),
		
		function(response_from_the_action_function)
			{
				jQuery("#submit_button").prop('disabled', true);
				jQuery("#response_area").fadeIn("500"); //animation
				jQuery("#response_area").html(response_from_the_action_function);
				}
	);
}
