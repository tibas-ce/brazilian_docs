require_relative 'base'

module BrazilianDocs 
  class CPF < Base
    # .freeze impede que o array seja modificado acidentalmente.
    FIRST_WEIGHTS = (2..10).to_a.reverse.freeze

    # Pesos usados no cálculo do segundo dígito verificador.
    SECOND_WEIGHTS = (2..11).to_a.reverse.freeze
    
    def initialize(document)
      # Limpa o CPF com a função compartilhada 'cleam_document'
      @document_cleam = cleam_document(document)
      # Converte cada caractere para número.
      @digits = @document_cleam.chars.map(&:to_i)
    end

    # Retorna o CPF sem formatação (apenas números), e sempre retorna uma string
    def number
      @document_cleam.to_s
    end

    def valid?
      # Retorna falso se não tiver 11 dígitos ou se todos forem iguais (ex: 11111111111)
      return false unless @document_cleam.length == 11 && !all_same_digits?

      # Calcula o primeiro dígito verificador
      calculated_first_verifier  = calculate_verifier(@digits[0..8], FIRST_WEIGHTS)
      # Verifica se está igual ao dígito informado pelo usuário
      return false unless calculated_first_verifier == @digits[9]

      # Calcula o segundo dígito verificador
      calculated_second_verifier = calculate_verifier(@digits[0..9], SECOND_WEIGHTS)
      # Retorna se o último dígito está correto
      calculated_second_verifier == @digits[10]
    end

    private

    # Verifica se todos os dígitos do CPF são iguais (isso invalida o CPF)
    def all_same_digits?
      @document =~ /(\d)\1{10}/
    end
  end
end
