# class Base contendo funções compartilhadas pelas class CPF CNPJ

module BrazilianDocs
  class Base
    # Método para limpar a string de entrada, removendo tudo que não for dígito.
    def cleam_document(doc) 
      doc.to_s.gsub(/[^0-9]/, '')
    end

    # Calcula o dígito verificador de CPF e CNPJ
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