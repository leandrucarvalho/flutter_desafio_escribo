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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eBook List'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            leading: Image.network(book.coverUrl),
            onTap: () {},
          );
        },
      ),
    );
  }
}
