require_relative 'base'

module BrazilianDocs 
  class CPF < Base
    # .freeze impede que o array seja modificado acidentalmente.
    FIRST_WEIGHTS = (2..10).to_a.reverse.freeze

    # Pesos usados no cálculo do segundo dígito verificador.
    SECOND_WEIGHTS = (2..11).to_a.reverse.freeze

    # Máscara usada para capturar os 11 dígitos do CPF em quatro grupos: 3-3-3-2.
    # exemplo: "12345678909" => "123.456.789-09"
    FORMAT_MASK = /(\d{3})(\d{3})(\d{3})(\d{2})/
    
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

    # Método de formatação da instâcia
    def formatted
      # Retorna nil se o CPF não for válido
      return nil unless valid?
      # Aplica a FORMAT_MASK no number é retorna o CPF formatado
      @document_cleam.gsub(FORMAT_MASK, "\\1.\\2.\\3-\\4")
    end

    # Métodos de classe
    
    # Método que validar um CPF sem criar uma instância permanente
    def self.valid?(cpf)
      # Cria uma instância temporária e delega a verificação para #valid?.
      new(cpf).valid?
    end

    # Método que formata o CPF informado sem criar uma instância permanente
    def self.format(cpf)
      # A lógica de formatação é delegada a #formatted, que retorna nil se o CPF for inválido
      new(cpf).formatted
    end

    private

    # Verifica se todos os dígitos do CPF são iguais (isso invalida o CPF)
    def all_same_digits?
      @document_cleam =~ /(\d)\1{10}/
    end
  end
end
