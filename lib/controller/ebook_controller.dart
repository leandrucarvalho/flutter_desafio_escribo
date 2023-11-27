import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../model/ebook_model.dart';
import '../repository/ebook_repository.dart';

class EbookListController {
  final EbookRepository _repository;

  EbookListController(this._repository);

  List<Ebook> books = [];
  List<Ebook> favoriteBooks = [];

  Future<void> fetchBooks() async {
    try {
      final fetchedBooks = await _repository.getEbooks();
      books.addAll(fetchedBooks);
    } catch (e) {
      Exception('Error fetching books: $e');
    }
  }

  void toggleFavorite(Ebook book) {
    if (favoriteBooks.contains(book)) {
      favoriteBooks.remove(book);
    } else {
      favoriteBooks.add(book);
    }
  }

  Future<void> downloadAndSaveBook(Ebook book) async {
    try {
      final response = await http.get(Uri.parse(book.downloadUrl));
      if (response.statusCode == 200) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        File file = File('${appDocDir.path}/${book.title}.epub');
        await file.writeAsBytes(response.bodyBytes);

        Exception('Livro baixado e salvo com sucesso em: ${file.path}');
      } else {
        Exception(
            'Erro durante o download do livro. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      Exception('Erro durante o download do livro: $e');
    }
  }
}
