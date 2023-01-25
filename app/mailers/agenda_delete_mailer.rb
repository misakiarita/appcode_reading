class AgendaDeleteMailer < ApplicationMailer
  def agenda_delete_mailer(team_members)
    @team_members = team_members

    mail to: @team_members.map(&:email).join(",")
  end
end
