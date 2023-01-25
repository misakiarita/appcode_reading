class AgendasController < ApplicationController
  before_action :set_agenda, only: %i[show edit update destroy]

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: I18n.t('views.messages.create_agenda') 
    else
      render :new
    end
  end

  def destroy
    # binding.pry
    if current_user.id == @agenda.user_id
      @agenda.destroy
      redirect_to dashboard_url, notice: I18n.t('views.messages.delete_agenda')
      AgendaDeleteMailer.agenda_delete_mailer(@agenda.team.members).deliver 
    elsif current_user.id == @agenda.team.owner_id 
      @agenda.destroy
      redirect_to dashboard_url, notice: I18n.t('views.messages.delete_agenda')
      AgendaDeleteMailer.agenda_delete_mailer(@agenda.team.members).deliver 

    else
      redirect_to dashboard_url, notice: I18n.t('views.messages.cant_delete_agenda')  
    end
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
