# ambisis_dashboard_challenge

### Arquitetura do Projeto

Para uma melhor organização do código, criei um board que contém a arquitetura que eu decidi utilizar para implementar a solução no projeto.

Você pode acessa-la através desse link de visualização: [clique aqui](https://miro.com/app/board/uXjVMU7ms5Y=/?share_link_id=239880662084)

### Tecnologias Utilizadas

- Flutter ^3.7.8
- Dart ^2.19.5
- flutter_bloc: ^8.1.2 (Gerenciamento de Estado)
- flutter_riverpod: ^2.3.4 (Injeção de Dependência)
- intl: ^0.17.0 (Internacionalização e Formatos de Data)
- random_x: ^0.3.1 (Gerador de Valores Aleatórios Para Auxiliar em um Serviço)
- sqflite: ^2.2.6 (Banco de Dados Local)
- fl_chart: ^0.61.0 (Gráfico)
- mocktail: ^0.3.0 (Mock Para Testes Unitários)

### Orientações Para Rodar o App

Para ter dados na tela, é necessário permitir que um serviço do banco de dados rode uma função para popular a base de dados. Você pode fazer isso uma única vez, apenas adicionando uma propriedade ao construtor de um Widget, para isso, você de ir no arquivo 'main.dart'

```dart
void main() {
  runApp(const ProviderScope(child: AppWidget(fillTable: true)));
}
```

Basicamente é isso, uma dica é que você pode remover essa variável do construtor depois que utilizar o App a primeira vez para que ele não fique populando a tabela várias vezes.
