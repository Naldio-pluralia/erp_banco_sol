
namespace :access do
  desc "Verifica e actualiza os acessos de cada colaborador"
  task change_or_update_access: :environment do
    # Incrementa 11 dias de férias no dias 1 de julho
    # ou no princípio do ano
    User.all.each(&:save)
  end
end
