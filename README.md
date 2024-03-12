# shop

A new Flutter project.

## Getting Started

 Uma  loja que  Provider como DB

- Modelo de produto criado
- Componente Grid de produtos, que é o componente inicial que irá buildar todos os produtos do modelo de produto
- Componente que lista os produtos dentro do grid de produtos
- Tela de detalhe dos produtos, uma tela simples que traz detalhes e usa o ModalRoute como argumento os detalhes dos produtos
- Aprendi um pouco sobre o que é estado.
- Adicionando filtro em telas
- Integrando Provider em carrinho de compras

- Navegação com Drawer
** Trabalhando com formulários **
- integrando Provider para remover, adicionar produtos na loja
- Usando SnackBar
- Usando o Form do Flutter
- Controlando o foco
- Campo de entrada de URL
- Trabalhando com validação de formulário
- Salvando produto

** Enviando requisições HTTP **
- Enviando requisições POST
- Tratamento de erro
- Asyn/Await
- Implementação PULL TO REFRESH
- Exclusão otimista
- Armazenamento de pedidos no Firebase




** Autenticação com Firebase **
- Tela auth usando cascaste operator
- Gerenciando token: Adicionando os parametros necessario para adquirir o token 
- Usando ProxyProvider para compartilhar o token. Neste caso em especifico ele serviu caso precise depender de apenas um Provider
- Aplicando token em todas as requisiçoes: atualizar, deletar e adicionar produto na lista. Adicionar e remover de favoritos. Usar reversed para que a lista de pedidos fique do mais recente ao mais antigo pedido
_items = items.reversed
        .toList();

- Persistindo os dados do login do usuário com o token dentro do limite, usando o shared preference, mas pode ser hive também
shared trabalha com chave valor, recuperando as informacoes persistidas no dispositivo

