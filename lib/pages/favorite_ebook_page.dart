import 'package:flutter/material.dart';

import '../model/ebook_model.dart';

class FavoriteBooksScreen extends StatelessWidget {
  final List<Ebook> favoriteBooks;

  const FavoriteBooksScreen(this.favoriteBooks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            leading: Image.network(book.coverUrl),
            onTap: () {
              // Implementar ação ao tocar no livro nos Favoritos
            },
          );
        },
      ),
    );
  }
}
