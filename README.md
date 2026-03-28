# FinTrack

FinTrack é um aplicativo moderno de Controle Financeiro Pessoal desenvolvido em Flutter. O aplicativo facilita o gerenciamento de despesas e receitas, proporcionando uma interface limpa e elegante orientada a resultados, com foco em estabilidade e uma arquitetura escalável e passível de testes (Clean Architecture + bloc).

---

## 🎯 Objetivos
- **Gerenciamento de Entradas/Saídas**: Inserção de receitas e despesas com valores, datas e títulos descritivos.
- **Rápido e Simples**: Visualização rápida do saldo total, do montante de despesas e de receitas diretamente na Dashboard.
- **Detalhes da Transação**: Visualização detalhada e capacidade de excluir registros facilmente.
- **Offline First**: Como a persistência de dados é local (via SQLite), os usuários não dependem de conexão com a interface de internet para visualizar ou manipular suas finanças.

---

## 🏗 Arquitetura & Padrões

O aplicativo foi projetado com base nos princípios da **Clean Architecture**, dividindo o projeto em 3 camadas principais:

1. **Domain (Domínio):** O core da aplicação. Não depende de pacotes externos ou frameworks. Contém _Entities_ (entidades), _Usecases_ (casos de uso) e as definições dos _Repositories_ (interfaces).
2. **Data (Dados):** Implementação concreta dos repositórios definidos no domínio, conexões diretas ao banco usando SQLite (`sqflite`), e conversões _Model_ <-> _Entity_ para serialização de JSON/Map.
3. **Presentation (Apresentação):** Telas de UI puras em Flutter separadas da lógica de negócios usando o padrão **BLoC (Business Logic Component)** e eventos (`equatable`).

---

## 📦 Bibliotecas e Tecnologias

- **Gerenciamento de Estado**: [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) e [`bloc`](https://pub.dev/packages/bloc)
- **Injeção de Dependências (DI)**: [`get_it`](https://pub.dev/packages/get_it)
- **Persistência / Banco de Dados**: [`sqflite`](https://pub.dev/packages/sqflite) e `sqflite_common_ffi` (para testes)
- **Comparações Simples**: [`equatable`](https://pub.dev/packages/equatable)
- **Fontes e Estilo**: [`google_fonts`](https://pub.dev/packages/google_fonts) e `cupertino_icons`
- **Formatação**: [`intl`](https://pub.dev/packages/intl) e [`currency_text_input_formatter`](https://pub.dev/packages/currency_text_input_formatter)

---

## 🧪 Testes Unitários

A base do aplicativo contém alta cobertura de **Testes Unitários** que garantem o funcionamento individual de cada unidade e o desacoplamento de camadas, utilizando [`flutter_test`](https://pub.dev/packages/flutter_test), [`bloc_test`](https://pub.dev/packages/bloc_test) e [`mockito`](https://pub.dev/packages/mockito) para os Mocks.

Foram criados testes para:
- Entidades do domínio (validando propriedades)
- Use Cases (Mocks com Injectable de repositórios)
- Models de conversões (fromMap / toMap garantidos)
- **BLoCs** (assegurando as corretas transições de estado via `blocTest`)
- Repositório SQLite local (com _In-Memory Database_ injetado para ambiente de teste)

Para executar todos os testes, rode no terminal:
```bash
flutter test
```

---

## 💻 Como Rodar o Projeto

1. Certifique-se de que o **Flutter SDK** está instalado (versão suportada: `^3.11.3` ou compativel).
2. Baixe ou clone esse repositório na sua máquina local.
3. Puxe as dependências do projeto através do terminal:
   ```bash
   flutter pub get
   ```
4. Se efetuou alguma mudança e precisa gerar os arquivos do Mockito para testes, rode o comando do `build_runner`:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Conecte um emulador/dispositivo físico e rode a aplicação:
   ```bash
   flutter run
   ```

---

*Desenvolvido com dedicação para gerenciar suas finanções de forma inteligente.*

Link do repositorio: https://github.com/LeonardoBays/FinTrack
Link do youtube: 