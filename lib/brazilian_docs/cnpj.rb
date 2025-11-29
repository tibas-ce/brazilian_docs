require_relative 'base'

module BrazilianDocs 
  class CNPJ < Base

    FIRST_WEIGHTS = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    SECOND_WEIGHTS = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

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

    private

    # Verifica se todos os dígitos do CNPJ são iguais (isso invalida o CNPJ)
    def all_same_digits?
      @document =~ /(\d)\1{13}/
    end
  end
end
