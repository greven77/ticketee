module OauthHelper
	def auth_providers(*names)
		names.each do |name|
			concat(link_to "#{name}",
			user_omniauth_authorize_path(name),
			:id => "sign_in_with_#{name}")
		end
		nil
	end
end