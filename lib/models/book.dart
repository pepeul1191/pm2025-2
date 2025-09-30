import 'package:biblioapp/models/author.dart';
import 'package:biblioapp/models/genre.dart';
import 'package:biblioapp/models/publisher.dart';

class Book {
  int id;
  String title;
  String isbn;
  int pages;
  int publicationYear;
  int editionYear;
  String synopsis;
  String coverImage;
  String pdf;
  Publisher publisher;
  List<Author> authors;
  List<Genre> genres;
  double? averageRating;

  Book({
    required this.id,
    required this.title,
    required this.isbn,
    required this.pages,
    required this.publicationYear,
    required this.editionYear,
    required this.synopsis,
    required this.coverImage,
    required this.pdf,
    required this.publisher,
    required this.authors,
    required this.genres,
    this.averageRating,
  });

  // Constructor fromJSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      isbn: json['isbn'] as String,
      pages: json['pages'] as int,
      publicationYear: json['publication_year'] as int,
      editionYear: json['edition_year'] as int,
      synopsis: json['synopsis'] as String,
      coverImage: json['cover_image'] as String,
      pdf: json['pdf'] as String,
      publisher: Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      authors:
          (json['authors'] as List)
              .map(
                (authorJson) =>
                    Author.fromJson(authorJson as Map<String, dynamic>),
              )
              .toList(),
      genres:
          (json['genres'] as List)
              .map(
                (genreJson) =>
                    Genre.fromJson(genreJson as Map<String, dynamic>),
              )
              .toList(),
      averageRating: json['reviews']?['average'] as double?,
    );
  }

  // Método toJSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isbn': isbn,
      'pages': pages,
      'publication_year': publicationYear,
      'edition_year': editionYear,
      'synopsis': synopsis,
      'cover_image': coverImage,
      'pdf': pdf,
      'publisher': publisher.toJson(),
      'authors': authors.map((author) => author.toJson()).toList(),
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'reviews': {'average': averageRating},
    };
  }

  // Método toString
  @override
  String toString() {
    return 'Book{id: $id, title: $title, isbn: $isbn, pages: $pages, publicationYear: $publicationYear, editionYear: $editionYear, publisher: ${publisher.name}, authors: ${authors.length}, genres: ${genres.length}}';
  }
}
