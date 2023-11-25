import 'package:flutter_desafio_escribo/model/ebook_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookApi {
  final String baseUrl;

  BookApi({required this.baseUrl});

  Future<List> geteBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/api/books'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['books'];
      return data.map((json) => Ebook.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar livros');
    }
  }

  Future<Ebook> getBookById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/books/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['book'];
      return Ebook.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Livro não encontrado');
    } else {
      throw Exception('Falha ao carregar livro');
    }
  }
}
