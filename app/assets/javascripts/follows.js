var FollowCaller = {
    init: function(){

        if (e.keyCode == 13)
        {
          $.ajax({
            alert("hi");
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
}