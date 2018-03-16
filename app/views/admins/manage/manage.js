$('#abc').html("<%= j(render partial: 'manage/manage_user', locals: { userslist: @users }) %>");
