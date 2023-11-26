import '../model/ebook_model.dart';
import '../repository/ebook_repository.dart';

class EbookListController {
  final BookApi bookApi;
  late List<Ebook> books = [];
  final List<Ebook> favoriteBooks = [];

  EbookListController(this.bookApi);

  Future<void> fetchBooks() async {
    try {
      final fetchedBooks = await bookApi.getEbooks();
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
}
