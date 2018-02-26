class Users::PasswordsController < Devise::PasswordsController
	prepend_before_action :require_no_authentication
	# append_before_action :assert_reset_token_passed, only: :edit


	def create
	    resource = User.find_by_email(user_params)
		if resource.present?
		    resource = resource.send_reset_password_instructions
		    render :json=>{:status=>true, :message=> "Reset password send your email address.", :reset_password_token=>resource}
		else
			render :json=>{:status=>false, :message=> "Email does not exit Plase provide valid email address."}
		end
	end

	def update
		response = {:status=> false, :message=> "invalid token"}
		if params[:reset_token].present?
			if (params[:users][:password]==params[:users][:password_confirmation])
				user  = User.find_by_reset_password_token(params[:reset_token])
				if user.present?
					if user.update(password_params)
						# send_reset_password_instructions_notification(user.reset_password_token)
						response = {:status=>true, :message => "We're contacting you to notify you that your password has been changed."}
					else
						response = {:status=>false, :errors=>user.errors.full_messages}	
					end
				else

				end
			else
				response = {:status=>false, :message => "password and confirm password does not matches."}
			end
		end
		render :json=>response
	end

	def user_params
	  	params.require(:email)
	end

	def password_params
		params.require(:users).permit!
		
	end
 
end