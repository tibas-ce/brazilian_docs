> ⚠️ **Projeto de Estudos**  
> Esta gem foi criada como exercício de aprendizado de desenvolvimento de gems Ruby, TDD com RSpec e validação de documentos brasileiros.

# BrazilianDocs
![Ruby Version](https://img.shields.io/badge/ruby-%3E%3D%203.2.0-red)
![License](https://img.shields.io/badge/license-MIT-green)
![Project Status](https://img.shields.io/badge/status-study%20project-blue)

**BrazilianDocs** fornece um conjunto simples e eficiente de funções para **validação e formatação de documentos brasileiros** (CPF e CNPJ).

Ideal para quem deseja validar documentos oficiais brasileiros ou aprender boas práticas de desenvolvimento Ruby.

---

## 📦 Instalação

Instale via RubyGems:
```bash
gem install brazilian_docs
```

Ou adicione ao seu Gemfile:
```ruby
gem 'brazilian_docs'
```

E então:
```ruby
require 'brazilian_docs'
```

---

## 🔧 API

Resumo das funções disponíveis:

| Classe | Método    | Descrição             | Exemplo |
|--------|-----------|------------------------|---------|
| CPF    | `.valid?` | Valida um CPF          | `"123.456.789-09"` → `true` |
| CPF    | `.format` | Formata um CPF válido  | `"12345678909"` → `"123.456.789-09"` |
| CNPJ   | `.valid?` | Valida um CNPJ         | `"11.222.333/0001-81"` → `true` |
| CNPJ   | `.format` | Formata um CNPJ válido | `"11222333000181"` → `"11.222.333/0001-81"` |

---

## 🚀 Uso

### CPF

#### Validação

Valida CPFs com ou sem formatação:

```ruby
BrazilianDocs::CPF.valid?("123.456.789-09")  # => true
BrazilianDocs::CPF.valid?("12345678909")     # => true
BrazilianDocs::CPF.valid?("123.456.789-00")  # => false
BrazilianDocs::CPF.valid?("111.111.111-11")  # => false (números repetidos)
```

#### Formatação

Formata apenas CPFs válidos no padrão brasileiro:

```ruby
BrazilianDocs::CPF.format("12345678909")     # => "123.456.789-09"
BrazilianDocs::CPF.format("123.456.789-09")  # => "123.456.789-09"
BrazilianDocs::CPF.format("12345678900")     # => nil (inválido)
```

### CNPJ

#### Validação

Valida CNPJs com ou sem formatação:

```ruby
BrazilianDocs::CNPJ.valid?("11.222.333/0001-81")  # => true
BrazilianDocs::CNPJ.valid?("11222333000181")      # => true
BrazilianDocs::CNPJ.valid?("11.222.333/0001-80")  # => false
BrazilianDocs::CNPJ.valid?("00.000.000/0000-00")  # => false (números repetidos)
```

#### Formatação

Formata apenas CNPJs válidos no padrão brasileiro:

```ruby
BrazilianDocs::CNPJ.format("11222333000181")      # => "11.222.333/0001-81"
BrazilianDocs::CNPJ.format("11.222.333/0001-81")  # => "11.222.333/0001-81"
BrazilianDocs::CNPJ.format("11222333000180")      # => nil (inválido)
```

---

## 🧩 Usando Instâncias

Trabalhe com objetos para operações mais completas:

```ruby
# CPF
cpf = BrazilianDocs::CPF.new("123.456.789-09")
cpf.valid?      # => true
cpf.number      # => "12345678909"
cpf.formatted   # => "123.456.789-09"

# CNPJ
cnpj = BrazilianDocs::CNPJ.new("11.222.333/0001-81")
cnpj.valid?     # => true
cnpj.number     # => "11222333000181"
cnpj.formatted  # => "11.222.333/0001-81"
```

---

## 🧠 Casos de Uso Práticos

### Validação em formulário

```ruby
def validate_user_cpf(input)
  cpf = BrazilianDocs::CPF.new(input)

  if cpf.valid?
    puts "CPF válido: #{cpf.formatted}"
    # Salvar cpf.number no banco (sem formatação)
  else
    puts "CPF inválido!"
  end
end
```

Validação de empresa

```ruby
def validate_company(cnpj_input)
  cnpj = BrazilianDocs::CNPJ.new(cnpj_input)

  return { valid: false, message: "CNPJ inválido" } unless cnpj.valid?

  {
    valid: true,
    number: cnpj.number,
    formatted: cnpj.formatted
  }
end
```

Limpeza automática de caracteres especiais

```ruby
BrazilianDocs::CPF.valid?("123.456.789-09") # => true
BrazilianDocs::CPF.valid?("123 456 789 09") # => true
BrazilianDocs::CPF.valid?("123-456-789-09") # => true
```

---

## 🧪 Testes

### Executar os testes

```bash
    bundle install
    bundle exec rspec
```

Cobertura de Testes

### CPF
- ✅ Validação completa (com e sem formatação)
- ✅ Dígitos verificadores
- ✅ Números repetidos
- ✅ Edge cases (nil, vazio, tamanho incorreto)
- ✅ Formatação correta ou nil
- ✅ Limpeza automática

### CNPJ
- ✅ Validação completa
- ✅ Dígitos verificadores
- ✅ Números repetidos
- ✅ Edge cases
- ✅ Formatação correta ou nil
- ✅ Limpeza automática

📊 Total: 39 casos de teste | 100% passando ✅

---

## 🔍 Qualidade do Código

### Princípios Aplicados
- **TDD** — Testes escritos antes da implementação (RSpec)
- **Clean Code** — Métodos claros e objetivos
- **Zero dependências** — Algoritmos implementados do zero
- **Edge Case Handling** — Validação robusta de entradas

### Stack Tecnológica
- Ruby ~> 3.2.0
- RSpec ~= 3.12
- Bundler

---

### Características
- ✅ Algoritmos oficiais da Receita Federal
- ✅ Limpeza automática de caracteres especiais
- ✅ Detecção de números repetidos
- ✅ Interface dupla (métodos de classe e instância)
- ✅ Performance otimizada (sem dependências externas)

## 🎯 Status do Projeto
- ✅ Implementação completa de CPF e CNPJ
- ✅ Validação com algoritmos oficiais
- ✅ Formatação automática
- ✅ Cobertura ampla de cenários críticos e edge cases
- ✅ Tratamento robusto de edge cases

---

## 📚 Aprendizados

Este projeto me ajudou a aprender:

- Estrutura e desenvolvimento de gems Ruby
- TDD com RSpec
- Algoritmos oficiais de validação
- Manipulação avançada de strings e regex
- Tratamento de edge cases
- Documentação técnica
- Boas práticas de código Ruby
- Versionamento semântico

---

## 🤝 Contribuindo

Contribuições são bem-vindas!

1. Fork o projeto  
2. Crie uma branch (`git checkout -b feature/NovaFeature`)  
3. Commit (`git commit -m 'Adiciona nova feature'`)  
4. Push (`git push origin feature/NovaFeature`)  
5. Abra um Pull Request  

---

## 👨‍💻 Autor

Tibério dos Santos Ferreira  
GitHub: https://github.com/tibas-ce/brazilian_docs

---

## 📄 Licença

MIT