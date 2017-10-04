class TripMailer < ApplicationMailer
	default :from => "eifion@asciicasts.com"
	def invite(invitation)
		@invitation = invitation
		puts '*********************************'
		puts @invitation.inspect
		mail(to: @invitation.send_to, subject: 'Invitation to join Trip')
	end
end
