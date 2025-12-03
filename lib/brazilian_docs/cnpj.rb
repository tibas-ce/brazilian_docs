require_relative 'base'

module BrazilianDocs 
  class CNPJ < Base

    FIRST_WEIGHTS = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    SECOND_WEIGHTS = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    # Máscara usada para capturar os 14 dígitos do CNPJ em cinco grupos: 2-3-3-4-2.
    # exemplo: "11444777000161" => "11.444.777/0001-61"
    FORMAT_MASK = /(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/

    def initialize(doc)
      # Remove tudo que não for número do CNPJ.
      @document = cleam_document(doc)
      # Converte cada caractere para número.
      @digits = @document.chars.map(&:to_i)
    end

    def valid?
      # Retorna falso se não tiver 14 dígitos ou se todos forem iguais (ex: 11111111111)
      return false unless @document.length == 14 && !all_same_digits?

      # Calcula o primeiro dígito verificador usando os 12 primeiros dígitos.
      calculated_first_verifier = calculate_verifier(@digits[0..11], FIRST_WEIGHTS)
      # Calcula o segundo dígito verificador usando os 13 primeiros dígitos.
      calculated_second_verifier = calculate_verifier(@digits[0..12], SECOND_WEIGHTS)
      
      # Verifica se o primeiro dígito calculado é igual ao informado
      # E verifica se o segundo dígito também é igual; se ambos forem, retorna true
      calculated_first_verifier == @digits[12] &&
      calculated_second_verifier == @digits[13]
    end

    # Método de formatação da instâcia
    def formatted
      # Retorna nil se o CNPJ não for válido
      return nil unless valid?
      # Aplica a FORMAT_MASK no number é retorna o CNPJ formatado
      @document.gsub(FORMAT_MASK, "\\1.\\2.\\3/\\4-\\5")
    end

    # Retorna o CNPJ sem formatação (apenas números), e sempre retorna uma string
    def number
      @document.to_s
    end

    # Métodos de classe
    
    # Método que validar um CNPJ sem criar uma instância permanente
    def self.valid?(cnpj)
      # Cria uma instância temporária e delega a verificação para #valid?.
      new(cnpj).valid?
    end

    private

    # Verifica se todos os dígitos do CNPJ são iguais (isso invalida o CNPJ)
    def all_same_digits?
      @document =~ /(\d)\1{13}/
    end
  end
end
