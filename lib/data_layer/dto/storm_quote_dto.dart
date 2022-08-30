import 'package:floor/floor.dart';

/// Data transfer object that represents a quote
/// retrieved from `http://quotes.stormconsultancy.co.uk/api`
@entity
class StormQuoteDTO {
  @primaryKey
  final int id;

  /// Quote
  final String quote;

  /// Author
  final String author;

  /// URL string
  final String? permalink;

  /// Creates new [StormQuoteDTO]
  StormQuoteDTO({
    required this.id,
    required this.quote,
    required this.author,
    this.permalink,
  });

  /// Creates a [StormQuoteDTO] from a json.
  factory StormQuoteDTO.fromJson(Map<String, dynamic> json) => StormQuoteDTO(
        author: json['author'],
        id: json['id'],
        quote: json['quote'],
        permalink: json['permalink'],
      );
}
