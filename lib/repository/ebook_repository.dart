import 'dart:convert';

import 'package:flutter_desafio_escribo/model/ebook_model.dart';
import 'package:http/http.dart' as http;

class EbookRepository {

  static const String baseUrl = 'https://escribo.com';

  Future<List<Ebook>> getEbooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Ebook.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar livros');
    }
  }

  Future<Ebook> getBookById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/books.json/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Ebook.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Livro não encontrado');
    } else {
      throw Exception('Falha ao carregar livro');
    }
  }
}
