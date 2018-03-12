// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//

// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//
//= require jquery
//= require jquery/jquery-3.1.1.min.js
//= require bootstrap
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require peity/jquery.peity.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require inspinia.js
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
	
 //    $('#user_search').on('keyup', function(e){
	// 	if (e.keyCode == 13)
	// 	{
	// 		 $.ajax({
 //            type: 'get',
 //            url: 'chats/search',
 //            dataType: 'script',
 //            data:{
 //                name : $(this).val()
 //            },
 //            success:function (msg) {
 //            }
 //    });
	// 	}
	// });
	$.ajax({
		type: 'get',
		url: 'application/count'
	})
});