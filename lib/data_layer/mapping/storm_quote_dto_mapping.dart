import '../../domain_layer/model/quote.dart';
import '../dto/storm_quote_dto.dart';

/// Extension that provides mappings for [StormQuoteDTO]
extension StormQuoteDTOMapping on StormQuoteDTO {
  /// Maps into a [Quote]
  Quote toQuote() => Quote(
        id: '$id',
        quote: quote,
        author: author,
        urlLink: permalink,
      );
}
