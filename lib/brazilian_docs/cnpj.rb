module BrazilianDocs 
  class CNPJ

    FIRST_WEIGHTS = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    SECOND_WEIGHTS = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    def initialize(doc)
      # Remove tudo que não for número do CNPJ.
      @document = doc.to_s.gsub(/[^0-9]/, '')
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

    # OBS: A lógica de cálculo do dígito verificador é exatamente a mesma para CPF e CNPJ. Ambos seguem o mesmo padrão, a única diferença entre CPF e CNPJ é o conjunto de pesos usado em cada etapa. 
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

valid = BrazilianDocs::CNPJ.new("00.000.000./0001-91")

puts valid.valid?