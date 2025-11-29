# class Base contendo funções compartilhadas pelas class CPF CNPJ

module BrazilianDocs
  class Base
    # Método para limpar a string de entrada, removendo tudo que não for dígito.
    def cleam_document(doc) 
      doc.to_s.gsub(/[^0-9]/, '')
    end
  end
end