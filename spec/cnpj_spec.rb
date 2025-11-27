require "spec_helper"

RSpec.describe BrazilianDocs::CNPJ do
  describe ".valid?" do
    context "com CNPJs válidos" do
      it "aceita o CNPJ sem formatação" do
        expect(described_class.valid?("11222333000181")).to be true
        expect(described_class.valid?("11444777000161")).to be true
      end

      it "aceita o CNPJ com a formatação" do
        expect(described_class.valid?("11.222.333/0001-81")).to be true
        expect(described_class.valid?("11.444.777/0001-61")).to be true
      end

      it "com CNPJs inválidos" do
        expect(described_class.valid?("11222333000180")).to be false
        expect(described_class.valid?("11444777000160")).to be false
      end

      context "com CNPJs inválidos" do
        it "rejeita o CNPJ com dígitos de verificação errados" do
          expect(described_class.valid?("11222333000180")).to be false
          expect(described_class.valid?("11444777000160")).to be false
        end
        
        it "rejeita o CNPJ com todos os números repetidos" do
          expect(described_class.valid?("00000000000000")).to be false
          expect(described_class.valid?("11111111111111")).to be false
          expect(described_class.valid?("99999999999999")).to be false
        end

        it "rejeita o CNPJ com o comprimento errado" do
          expect(described_class.valid?("1122233300018")).to be false
          expect(described_class.valid?("112223330001811")).to be false
        end

        it "rejeita CNPJ nil" do
          expect(described_class.valid?(nil)).to be false
        end

        it "rejeita CNPJ vazio" do
          expect(described_class.valid?("")).to be false
        end

        it "rejeita CNPJ com letras" do
          expect(described_class.valid?("1122233300018A")).to be false
        end
      end
    end
  end

  describe ".format" do
    context "com CNPJs válidos" do
      it "formata CNPJs desformatados" do
        expect(described_class.format("11222333000181")).to eq("11.222.333/0001-81")
        expect(described_class.format("11444777000161")).to eq("11.444.777/0001-61")
      end

      it "formata CNPJs já formatados" do
        expect(described_class.format("11.222.333/0001-81")).to eq("11.222.333/0001-81")
      end
    end

    context "com CNPJs inválidos" do
      it "retorna nil para CNPJ inválido" do
        expect(described_class.format("11222333000180")).to be_nil
      end
    end
  end

  describe "#initialize" do
    it "cria instância com CNPJ não formatado" do
      cnpj = described_class.new("11222333000181")
      expect(cnpj.number).to eq("11222333000181")
    end

    it "limpa a formatação do CNPJ" do
      cnpj = described_class.new("11.222.333/0001-81")
      expect(cnpj.number).to eq("11222333000181")
    end
  end

  describe "#valid?" do
    it "válida instâcia CNPJ" do
      cnpj = described_class.new("11222333000181")
      expect(cnpj.valid?).to be true
    end

    it "inválida instância com CNPJ errado" do
      cnpj = described_class.new("11222333000180")
      expect(cnpj.valid?).to be false
    end
  end

  describe "#formatted" do
    it "retorna CNPJ formatado para instância válida" do
      cnpj = described_class.new("11222333000181")
      expect(cnpj.formatted).to eq("11.222.333/0001-81")
    end

    it "retorna nil para instância inválida" do
      cnpj = described_class.new("11222333000180")
      expect(cnpj.formatted).to be_nil
    end
  end
end