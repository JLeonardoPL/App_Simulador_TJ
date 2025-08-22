# App_Simulador_TJ

Aplicativo de simulação de provas para concursos dos Tribunais de Justiça. O projeto é composto por um backend em Node.js com Supabase e um aplicativo móvel Flutter.

## Backend
O código fonte encontra-se na pasta `backend`.

### Configuração
1. Acesse a pasta `backend` e copie o arquivo `.env.example` para `.env` preenchendo `SUPABASE_URL`, `SUPABASE_KEY` e, opcionalmente, `PORT`.
2. Instale as dependências com `npm install`.
3. Inicie o servidor com `npm start`.

### Endpoints
- `GET /api/questions?tier=free|plus|premium` — obtém questões de acordo com o plano.
- `POST /api/submit` — envia as respostas e registra o resultado no ranking.
- `GET /api/ranking?limit=10` — retorna os melhores resultados.

## Mobile
O aplicativo Flutter está na pasta `mobile` e segue a estrutura:
```
lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   ├── quiz_screen.dart
│   └── result_screen.dart
├── services/
│   └── api_service.dart
└── models/
    └── question_model.dart
```

### Execução
1. Instale o [Flutter](https://flutter.dev) e suas dependências.
2. No diretório `mobile`, execute `flutter pub get` para baixar os pacotes.
3. Conecte um dispositivo ou inicie um emulador e rode `flutter run`.

## Observações
- Este repositório não inclui as dependências Node.js instaladas devido a restrições do ambiente, portanto execute `npm install` antes de iniciar o backend.
- Da mesma forma, o Flutter SDK não está incluído; é necessário instalá-lo para compilar o aplicativo móvel.
