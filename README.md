## Ebook Reader App
Este é um aplicativo simples de leitura de eBooks construído em Flutter. O aplicativo permite que os usuários visualizem uma lista de eBooks, marquem livros como favoritos e façam o download de eBooks para leitura offline.

## Funcionalidades
- Lista de Livros: Visualize uma lista de eBooks disponíveis.
- Favoritos: Marque seus livros favoritos.
- Download: Faça o download de eBooks para leitura offline.

## Requisitos do Sistema

Certifique-se de ter o Flutter instalado em seu ambiente de desenvolvimento. Para mais informações, consulte a documentação oficial do Flutter.

## Configuração do Projeto

1. Clone este repositório:
- git clone https://github.com/leandrucarvalho/flutter_desafio_escribo

2. Navegue até o diretório do projeto:

- cd flutter_desafio_escribo

3. Execute o aplicativo:
   
- flutter run

## Dependências
O aplicativo usa as seguintes dependências:

- [http ](https://pub.dev/packages/http): Para realizar requisições HTTP.
- [path_provider](https://pub.dev/packages/path_provider): Para acessar o diretório de documentos do aplicativo.
- [Vocsy Epub Viewer](https://pub.dev/packages/vocsy_epub_viewer) para exibir o conteúdo do livro.

## Estrutura do Projeto
- lib/controller/ebook_controller.dart: Controlador que gerencia o estado da lista de eBooks e dos livros favoritos.
- lib/model/ebook_model.dart: Modelo de dados para representar um eBook.
- lib/repository/ebook_repository.dart: Repositório responsável por recuperar os eBooks da API.
- lib/screens/book_list_screen.dart: Tela principal que exibe a lista de eBooks.