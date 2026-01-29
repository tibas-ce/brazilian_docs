# Carrega o Bundler e configura o ambiente de gems conforme o Gemfile.
# Isso garante que todas as dependências necessárias estejam disponíveis quando os testes forem executados.
require "bundler/setup"
# Carrega a gem principal do projeto para que possa ser testada.
# Assim, todos os módulos, classes e métodos da biblioteca ficam acessíveis dentro dos testes.
require "brazilian_docs"


# Configurações globais do RSpec.
RSpec.configure do |config|
  # Configura formato de saída dos testes para documentation
  config.default_formatter = 'doc'

  # Armazena o estado dos testes (ex.: exemplos que falharam) no arquivo .rspec_status.
  # Isso permite rodar novamente apenas os testes que falharam usando:
  #   rspec --only-failures
  config.example_status_persistence_file_path = ".rspec_status"

  # Desabilita "monkey patching" no RSpec, impedindo que o framework altere classes ou adicione sintaxes globais como `should`.
  # Com isso, você usa apenas a sintaxe moderna baseada em `expect`.
  config.disable_monkey_patching!

  # Configura o framework de expectativas do RSpec.
  config.expect_with :rspec do |c|
    # Força o uso da sintaxe moderna:
    #   expect(valor).to eq(x)
    # Em vez da antiga:
    #   valor.should eq(x)
    c.syntax = :expect
  end
end