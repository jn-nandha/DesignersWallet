$(document).ready(function(){
	$('#user_search').on('keyup', function(e){
		if (e.keyCode == 13)
		{
			 $.ajax({
            type: 'get',
            url: 'follows/search',
            dataType: 'script',
            data:{
                name : $(this).val()
            },
            success:function (msg) {
                console.log(msg);   
            }
    });
		}
	});
});
