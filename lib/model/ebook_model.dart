// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ebook {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  Ebook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) {
    return Ebook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['cover_url'],
      downloadUrl: json['download_url'],
    );
  }

  @override
  bool operator ==(covariant Ebook other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.author == author &&
        other.coverUrl == coverUrl &&
        other.downloadUrl == downloadUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        coverUrl.hashCode ^
        downloadUrl.hashCode;
  }
}
