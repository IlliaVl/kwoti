/// Model representing quote data
class Quote {
  /// Quote id
  final String id;

  /// Quote
  final String quote;

  /// Author
  final String author;

  /// URL string
  final String? urlLink;

  /// Returns combined quote with author
  String get quoteWithAuthor => '"$quote" \n    $author';

  /// Creates new [Quote]
  Quote({
    required this.id,
    required this.quote,
    required this.author,
    this.urlLink,
  });
}
