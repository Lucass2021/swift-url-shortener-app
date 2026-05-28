# Projeto: App iOS Nativo — Cliente do URL Shortener

## Contexto do desenvolvedor

Desenvolvedor frontend/mobile com experiência sólida em React Native, Expo e TypeScript.
Está expandindo para desenvolvimento nativo com o objetivo de evoluir para nível sênior.

Este projeto é a continuação direta de um backend já construído e funcionando:
**[nest-api-url-shortener-context](https://github.com/Lucass2021/nest-api-url-shortener-context)**

O objetivo é aprender SwiftUI consumindo uma API real que o próprio desenvolvedor construiu —
contexto familiar, sem a necessidade de entender um domínio novo ao mesmo tempo que aprende Swift.

---

## Objetivo do projeto

Construir um app iOS nativo em SwiftUI que consome a API do encurtador de URL já existente.
Foco total em **aprender Swift e SwiftUI** com boas práticas, não em criar features novas.

---

## API disponível (já pronta)

Base URL: `http://localhost:3000` (local) ou URL de deploy no Railway/Render

### Endpoints que o app vai consumir

**Auth**
- `POST /auth/register` — cadastro com email e senha
- `POST /auth/login` — login, retorna `accessToken` + `refreshToken`
- `POST /auth/refresh` — renova o accessToken usando o refreshToken

**Links**
- `POST /links/shorten` — cria link curto (body: `{ url, expiresAt? }`)
- `GET /links/me/links` — lista links do usuário autenticado
- `DELETE /links/:code` — deleta link próprio

**Stats**
- `GET /:code/stats` — estatísticas do link (total de cliques, criado em, última visita)

**Headers de auth**
```
Authorization: Bearer <accessToken>
```

**Respostas de erro padrão**
- `401` — token expirado → deve tentar refresh automático
- `410` — link expirado
- `429` — rate limit atingido, header `Retry-After` presente

---

## Telas esperadas

### Fluxo de autenticação
- **Tela de boas-vindas** — botões para Login e Cadastro
- **Tela de login** — campos email e senha, botão entrar
- **Tela de cadastro** — campos email e senha, botão criar conta

### Fluxo principal (autenticado)
- **Lista de links** — todos os links do usuário, com código, URL original, cliques e expiração
- **Criar link** — campo de URL, picker de expiração (7 dias / 30 dias / nunca), botão encurtar
- **Detalhe do link** — stats completas, botão copiar link curto, botão deletar
- **Perfil / logout** — tela simples com email do usuário e botão sair

---

## Requisitos técnicos

### Armazenamento seguro
- `accessToken` e `refreshToken` armazenados no **Keychain** (nunca em UserDefaults)
- Logout limpa os tokens do Keychain

### Refresh automático de token
- Interceptor de requisição que detecta `401`
- Tenta `POST /auth/refresh` automaticamente
- Se refresh falhar, redireciona para login
- Fila de requisições pendentes durante o refresh (não dispara múltiplos refreshes em paralelo)

### Networking
- Camada de rede centralizada com `URLSession` (sem bibliotecas externas)
- Decodificação com `Codable`
- Tratamento de erros tipado (enum de erros da API)

### Arquitetura
- **MVVM** — separação clara entre View, ViewModel e Model
- ViewModels com `@Observable` (Swift 5.9+) ou `ObservableObject`
- Services para networking (AuthService, LinksService)
- Keychain encapsulado em um helper próprio (`KeychainHelper`)

### UI / UX
- SwiftUI puro, sem UIKit
- Loading states em todas as ações assíncronas
- Mensagens de erro amigáveis (sem expor detalhes técnicos)
- Swipe to delete na lista de links
- Pull to refresh na lista de links
- Botão de copiar link curto para a área de transferência com feedback visual (checkmark animado)

---

## O que o desenvolvedor quer aprender

1. **SwiftUI** — estrutura de views, modifiers, navegação com NavigationStack
2. **Keychain** — armazenamento seguro de tokens no iOS
3. **URLSession** — networking nativo sem bibliotecas externas
4. **MVVM em Swift** — como organizar o código com `@Observable` / `ObservableObject`
5. **Refresh token automático** — interceptor de auth nativo (equivalente ao que axios interceptors faz)
6. **Async/await em Swift** — concorrência moderna sem callbacks
7. **Swift Concurrency** — `Task`, `MainActor`, cancelamento

---

## Etapas / conquistas

| # | Entrega | Tempo estimado |
|---|---------|---------------|
| 1 | Setup do projeto Xcode, estrutura de pastas MVVM, KeychainHelper | algumas horas |
| 2 | Camada de networking: URLSession + Codable + enum de erros | meio dia |
| 3 | Telas de login e cadastro funcionando com a API real | fim de semana |
| 4 | Refresh automático de token com fila de requisições | + 1 dia |
| 5 | Lista de links com pull to refresh e swipe to delete | + 1 dia |
| 6 | Tela de criar link com picker de expiração | + meio dia |
| 7 | Tela de detalhe com stats e botão copiar | + meio dia |
| 8 | Polimento: loading states, erros, animações, ícone do app | + 1 dia |

---

## Estrutura de pastas sugerida

```
URLShortenerApp/
├── App/
│   └── URLShortenerApp.swift       # @main, injeção de dependências
├── Core/
│   ├── Network/
│   │   ├── APIClient.swift         # URLSession centralizado
│   │   ├── APIError.swift          # enum de erros tipados
│   │   └── Endpoint.swift          # enum de endpoints
│   ├── Auth/
│   │   └── KeychainHelper.swift    # wrapper do Keychain
│   └── Extensions/
│       └── View+Extensions.swift
├── Features/
│   ├── Auth/
│   │   ├── LoginView.swift
│   │   ├── LoginViewModel.swift
│   │   ├── RegisterView.swift
│   │   └── RegisterViewModel.swift
│   ├── Links/
│   │   ├── LinksListView.swift
│   │   ├── LinksListViewModel.swift
│   │   ├── CreateLinkView.swift
│   │   ├── CreateLinkViewModel.swift
│   │   ├── LinkDetailView.swift
│   │   └── LinkDetailViewModel.swift
│   └── Profile/
│       └── ProfileView.swift
└── Models/
    ├── Link.swift
    ├── User.swift
    └── AuthTokens.swift
```

---

## Como usar esse contexto com outra IA

Cole este documento e adicione uma das instruções abaixo:

**Para iniciar o projeto:**
> "Com base nesse contexto, me ajude a configurar o projeto Xcode com a estrutura de pastas MVVM e o KeychainHelper para armazenar tokens."

**Para uma etapa específica:**
> "Com base nesse contexto, estou na etapa 4 (refresh automático de token). Me ajude a implementar o interceptor com fila de requisições pendentes em Swift."

**Para uma tela específica:**
> "Com base nesse contexto, implemente a LinksListView com SwiftUI, pull to refresh e swipe to delete consumindo o LinksListViewModel."

**Para revisão de código:**
> "Com base nesse contexto, revise esse ViewModel e aponte o que um dev iOS sênior mudaria."

**Para dúvidas de Swift:**
> "Com base nesse contexto, explique como `@Observable` funciona e como usá-lo nos ViewModels desse projeto."