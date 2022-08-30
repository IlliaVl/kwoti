import '../../domain_layer/model/quote.dart';
import '../dto/garden_quote_dto.dart';

/// Extension that provides mappings for [GardenQuoteDTO]
extension GardenQuoteDTOMapping on GardenQuoteDTO {
  /// Maps into a [Quote]
  Quote toQuote() => Quote(
        id: id,
        quote: quoteText,
        author: quoteAuthor,
      );
}
