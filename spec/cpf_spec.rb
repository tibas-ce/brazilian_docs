require "spec_helper"

RSpec.describe BrazilianDocs::CPF do
  describe ".valid?" do
    context "com CPFs válidos" do
      it "aceita CPF sem formatação" do
        expect(described_class.valid?("12345678909")).to be true
        expect(described_class.valid?("11144477735")).to be true
      end

      it "aceita CPF com formatação" do
        expect(described_class.valid?("123.456.789-09")).to be true
        expect(described_class.valid?("111.444.777-35")).to be true
      end
    end
    context "com CPFs inválidos" do
      it "rejeita CPF com dígitos de verificação errados" do
        expect(described_class.valid?("12345678900")).to be false
        expect(described_class.valid?("11144477730")).to be false
      end

      it "rejeita o CPF com todos os números repetidos" do
        expect(described_class.valid?("00000000000")).to be false
        expect(described_class.valid?("11111111111")).to be false
        expect(described_class.valid?("88888888888")).to be false
      end

      it "rejeita o CPF com o comprimento errado" do
        expect(described_class.valid?("123456789")).to be false
        expect(described_class.valid?("123456789012")).to be false
      end

      it "rejeita CPF nil" do
        expect(described_class.valid?(nil)).to be false
      end

      it "rejeita o CPF vazio" do
        expect(described_class.valid?("")).to be false
      end

      it "rejeita CPF com letras" do
        expect(described_class.valid?("1234567890A")).to be false
      end
    end
  end

  describe ".format" do
    context "com CPFs válidos" do
      it "formata CPF não formatado" do
        expect(described_class.format("12345678909")).to eq("123.456.789-09")
        expect(described_class.format("11144477735")).to eq("111.444.777-35")
      end

      it "formata CPF já formatado" do
        expect(described_class.format("123.456.789-09")).to eq("123.456.789-09")
      end
    end

    context "com CPFs inválidos" do
      it "retorna nil para CPF inválido" do
        expect(described_class.format("12345678900")).to be_nil
      end
    end
  end

  describe "#initialize" do
    it "cria instância com CPF não formatado" do
      cpf = described_class.new("12345678909")
      expect(cpf.number).to eq("12345678909")
    end

    it "limpa a formatação do CPF" do
      cpf = described_class.new("123.456.789-09")
      expect(cpf.number).to eq("12345678909")
    end
  end

  describe "#valid?" do
    it "valida o CPF da instância" do
      cpf = described_class.new("12345678909")
      expect(cpf.valid?).to be true
    end

    it "invalida a instância com CPF incorreto" do
      cpf = described_class.new("12345678900")
      expect(cpf.valid?).to be false
    end
  end

  describe "#formatted" do
    it "retorna CPF formatado para instância válida" do
      cpf = described_class.new("12345678909")
      expect(cpf.formatted).to eq("123.456.789-09")
    end

    it "retorna nil para instância inválida" do
      cpf = described_class.new("12345678900")
      expect(cpf.formatted).to be_nil
    end
  end
end
