import 'package:flutter/material.dart';

import '../model/ebook_model.dart';
import '../repository/ebook_repository.dart';

class BookListScreen extends StatefulWidget {
  final BookApi bookApi;

  const BookListScreen({Key? key, required this.bookApi}) : super(key: key);

  @override
  BookListScreenState createState() => BookListScreenState();
}

class BookListScreenState extends State<BookListScreen> {
  List<Ebook> books = [];
  List<Ebook> favoriteBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final fetchedBooks = await widget.bookApi.getEbooks();
      setState(() {
        books = fetchedBooks;
      });
    } catch (e) {
      Exception('Error: $e');
    }
  }

  void toggleFavorite(Ebook book) {
    setState(() {
      if (favoriteBooks.contains(book)) {
        favoriteBooks.remove(book);
      } else {
        favoriteBooks.add(book);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de eBooks'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      fetchBooks();
                    });
                  },
                  child: const Text("Livros"),
                ),
                const SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      books = favoriteBooks;
                    });
                  },
                  child: const Text("Favoritos"),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
              ),
              shrinkWrap: true,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final isFavorite = favoriteBooks.contains(book);
                return Card(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              book.coverUrl,
                              height: 100,
                            ),
                            Text(
                              book.title,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              book.author,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          child: Icon(
                            isFavorite ? Icons.bookmark : Icons.bookmark_sharp,
                            color: Colors.red,
                          ),
                          onTap: () => toggleFavorite(book),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
