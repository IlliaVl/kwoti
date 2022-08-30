import 'package:floor/floor.dart';

/// Data transfer object that represents a quote
/// retrieved from `https://pprathameshmore.github.io/QuoteGarden/`
@entity
class GardenQuoteDTO {
  @primaryKey
  final String id;

  /// Quote
  final String quoteText;

  /// Author
  final String quoteAuthor;

  /// Creates new [GardenQuoteDTO]
  GardenQuoteDTO({
    required this.id,
    required this.quoteText,
    required this.quoteAuthor,
  });

  /// Creates a [GardenQuoteDTO] from a json.
  factory GardenQuoteDTO.fromJson(Map<String, dynamic> json) => GardenQuoteDTO(
        quoteAuthor: json['quoteAuthor'],
        id: json['_id'],
        quoteText: json['quoteText'],
      );
  // {
  //  "statusCode": 200,
  //  "message": "Quotes",
  //  "pagination": {
  //    "currentPage": 1,
  //    "nextPage": 2,
  //    "totalPages": 72672
  //  },
  //  "totalQuotes": 72672,
  //  "data": [
  //    {
  //      "_id": "5eb17aadb69dc744b4e70d2e",
  //      "quoteText": "All diseases run into one, old age.",
  //      "quoteAuthor": "Ralph Waldo Emerson",
  //      "quoteGenre": "age",
  //      "__v": 0
  //    }
  //  ]
  // }
}
