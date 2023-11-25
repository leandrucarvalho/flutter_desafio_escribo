import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'repository/ebook_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bookApi = BookApi(baseUrl: 'https://escribo.com');
    return MaterialApp(
      title: 'Book API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookListScreen(bookApi: bookApi),
    );
  }
}
