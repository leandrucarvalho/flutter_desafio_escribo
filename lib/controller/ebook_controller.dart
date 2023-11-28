import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../model/ebook_model.dart';
import '../repository/ebook_repository.dart';

class EbookListController {
  final EbookRepository _repository;

  EbookListController(this._repository);

  final ValueNotifier<List<Ebook>> books = ValueNotifier([]);

  Future<void> fetchBooks() async {
    try {
      final fetchedBooks = await _repository.getEbooks();

      books.value = fetchedBooks;
    } catch (e) {
      Exception('Error fetching books: $e');
    }
  }

  void toggleFavorite(int id) {
    books.value.singleWhere((e) => e.id == id).toggleFavorite();
    final newList = List<Ebook>.from(books.value);
    books.value = newList;
  }

  Future<void> downloadAndSaveBook(Ebook book) async {
    try {
      final response = await http.get(Uri.parse(book.downloadUrl));
      if (response.statusCode == 200) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        File file = File('${appDocDir.path}/${book.title}.epub');
        await file.writeAsBytes(response.bodyBytes);

        throw Exception('Livro baixado e salvo com sucesso em: ${file.path}');
      } else {
        throw Exception(
            'Erro durante o download do livro. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro durante o download do livro: $e');
    }
  }
}
