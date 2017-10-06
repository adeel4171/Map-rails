class TripMailer < ApplicationMailer
	default :from => "eifion@asciicasts.com"
	def invite(invitation)
		@invitation = invitation
		mail(to: @invitation.send_to.join(','), subject: 'Invitation to join Trip')
	end
end