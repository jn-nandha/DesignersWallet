var FollowCaller = {
    abc: function(){
            $.ajax({
                type: 'get',
                url: 'follows/search',
                dataType: 'script',
                data:{
                    name : $('#follow_search').val()
                },
                success:function (msg) {
                    console.log("ok");   
                }
            });    
    }
};