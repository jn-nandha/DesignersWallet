class ManageController < ApplicationController

def manage_user
	@user = User.all
end	
end
