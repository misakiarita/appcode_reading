module AgendasHelper
  def choose_new_or_edit
    case action_name
    when 'new'
      team_agendas_path
    when 'edit'
      agenda_path
    end
  end
end
