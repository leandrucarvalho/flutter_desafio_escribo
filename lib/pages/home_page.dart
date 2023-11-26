import 'package:flutter/material.dart';
import 'package:flutter_desafio_escribo/controller/ebook_controller.dart';
import '../repository/ebook_repository.dart';

class BookListScreen extends StatefulWidget {
  final BookApi bookApi;

  const BookListScreen({Key? key, required this.bookApi}) : super(key: key);

  @override
  BookListScreenState createState() => BookListScreenState();
}

class BookListScreenState extends State<BookListScreen> {
  late EbookListController _ebookListController;

  @override
  void initState() {
    super.initState();
    _ebookListController = EbookListController(widget.bookApi);
    _ebookListController.fetchBooks();
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
                      _ebookListController.fetchBooks();
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
                      _ebookListController.books =
                          _ebookListController.favoriteBooks;
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
              itemCount: _ebookListController.books.length,
              itemBuilder: (context, index) {
                final book = _ebookListController.books[index];
                final isFavorite =
                    _ebookListController.favoriteBooks.contains(book);
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
                          onTap: () =>
                              _ebookListController.toggleFavorite(book),
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
