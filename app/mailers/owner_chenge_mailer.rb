class OwnerChengeMailer < ApplicationMailer
  def owner_chenge_mailer(team)
    @team = team
    @user = User.find(@team.owner_id)
    mail to: @user.email, subject: "チームリーダーの権限移譲"
  end
end
