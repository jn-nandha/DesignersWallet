$(document).ready(function(){
	$("#msg").animate({ scrollTop: $('#msg').height() }, "fast");
	
    $('#user_search').on('keyup', function(e){
		if (e.keyCode == 13)
		{
			 $.ajax({
            type: 'get',
            url: 'chats/search',
            dataType: 'script',
            data:{
                name : $(this).val()
            },
            success:function (msg) {
            }
    });
		}
	});
});
function remove(array, element) {
    return array.filter(e => e !== element);
}