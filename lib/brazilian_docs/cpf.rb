module BrazilianDocs 
  class CPF
    # .freeze impede que o array seja modificado acidentalmente.
    FIRST_WEIGHTS = (2..10).to_a.reverse.freeze

    # Pesos usados no cálculo do segundo dígito verificador.
    SECOND_WEIGHTS = (2..11).to_a.reverse.freeze
    
    def initialize(doc)
      # Remove tudo que não for número do CPF.
      @document = doc.to_s.gsub(/[^0-9]/, '')
      # Converte cada caractere para número.
      @digits = @document.chars.map(&:to_i)
    end

    def valid?
      # Retorna falso se não tiver 11 dígitos ou se todos forem iguais (ex: 11111111111)
      return false unless @document.length == 11 && !all_same_digits?

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

    # Calcula o dígito verificador do CPF
    def calculate_verifier(base_digits, weights)
      # zip junta 2 arrays elemento por elemento, formando pares.
      # Ex: [1,2] zip [3,4] => [[1,3],[2,4]]
      sum = base_digits.zip(weights).map { |digit, weigth| digit * weigth }.sum

      remainer = sum % 11

      # Ternário com regra oficial do CPF:
      # Se resto < 2 => dígito é 0  
      # Senão => 11 - resto
      remainer < 2 ? 0 : 11 - remainer
    end
  end
end