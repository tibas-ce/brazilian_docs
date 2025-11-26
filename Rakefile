# frozen_string_literal: true

require "bundler/gem_tasks"
task default: %i[]

# Define a tarefa RSpec chamada :spec, permitindo rodar testes com "rake spec"
RSpec::Core::RakeTask.new(:spec)

# Define a tarefa padrão do Rake.
# Isso faz com que, ao rodar apenas "rake", a tarefa :spec seja executada automaticamente.
task default: :spec