module BrazilianDocs 
  class CNPJ

    def initialize(doc)
      # Remove tudo que não for número do CNPJ.
      @document = doc.to_s.gsub(/[^0-9]/, '')
      # Converte cada caractere para número.
      @digits = document.chars.map(&:to_i)
    end

    def self.valid?(value)
      # implementar depois
      false
    end
  end
end