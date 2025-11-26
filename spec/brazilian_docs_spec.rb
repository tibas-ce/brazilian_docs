require "spec_helper"

RSpec.describe BrazilianDocs do
  it "a gem possui um número de versão definido" do
    expect(BrazilianDocs::VERSION).not_to be_nil
  end

  it "classe CPF foi definada" do
    expect(defined?(BrazilianDocs::CPF)).to eq("constant")
  end

  it "classe CNPJ foi definida" do
    expect(defined?(BrazilianDocs::CNPJ)).to eq("constant")
  end

  describe "testes referentes à estrutura interna do módulo BrazilianDocs" do
    # Ter um erro customizado é boa prática, pois permite:
    # - capturar apenas erros da gem (rescue BrazilianDocs::Error)
    # - distinguir erros internos de outros erros Ruby
    #
    # Este teste garante que:
    # 1. o constante BrazilianDocs::Error existe
    # 2. ele herda de StandardError (boa prática em gems Ruby)
    it "tem classe de erro" do
      expect(defined?(BrazilianDocs::Error)). to eq("constant")
      expect(BrazilianDocs::Error).to be < StandardError
    end
  end
end
