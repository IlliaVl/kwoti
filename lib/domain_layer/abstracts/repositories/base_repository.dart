import '../../model/quote.dart';

/// The abstract repository.
abstract class BaseRepository {
  /// Creates new [BaseRepository]
  BaseRepository();

  /// Returns random quote
  Future<Quote> getRandomQuote();
}
