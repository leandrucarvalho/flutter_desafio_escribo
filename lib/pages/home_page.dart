import 'package:flutter/material.dart';
import 'package:flutter_desafio_escribo/controller/ebook_controller.dart';
import 'package:flutter_desafio_escribo/di/di_setup.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  BookListScreenState createState() => BookListScreenState();
}

class BookListScreenState extends State<BookListScreen>
    with SingleTickerProviderStateMixin {
  late EbookListController _ebookListController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _ebookListController = getIt.get<EbookListController>();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    _ebookListController.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de eBooks'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Livros",
            ),
            Tab(
              text: "Favoritos",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          builderList(),
          buildListFavorites(),
        ],
      ),
    );
  }

  Widget builderList() {
    return ValueListenableBuilder(
      valueListenable: _ebookListController.books,
      builder: (context, value, child) {
        return GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          shrinkWrap: true,
          itemCount: _ebookListController.books.value.length,
          itemBuilder: (context, index) {
            final book = _ebookListController.books.value[index];

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
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: book.isFavorite
                            ? const Icon(
                                Icons.bookmark,
                                key: ValueKey<bool>(true),
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.bookmark_outline,
                                key: ValueKey<bool>(false),
                              ),
                      ),
                      onTap: () => _ebookListController.toggleFavorite(book.id),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildListFavorites() {
    return ValueListenableBuilder(
      valueListenable: _ebookListController.books,
      builder: (context, value, child) {
        final favoriteList = _ebookListController.books.value
            .where((e) => e.isFavorite)
            .toList();
        return GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ),
          shrinkWrap: true,
          itemCount: favoriteList.length,
          itemBuilder: (context, index) {
            final book = favoriteList[index];

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
                      child: const Icon(
                        Icons.bookmark,
                        key: ValueKey<bool>(true),
                        color: Colors.red,
                      ),
                      onTap: () => _ebookListController.toggleFavorite(book.id),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
