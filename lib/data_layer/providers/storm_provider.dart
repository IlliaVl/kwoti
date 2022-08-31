import '../../domain_layer/abstracts/network/net_client.dart';
import '../database/app_database.dart';
import '../dto/storm_quote_dto.dart';

/// QuoteStorm data provider
class StormProvider with DatabaseHelper {
  /// The NetClient to use for the network requests
  final NetClient netClient;

  /// Creates new [StormProvider]
  StormProvider(this.netClient);

  /// Returns random quote
  Future<StormQuoteDTO> getRandomQuote() async {
    if (!(await netClient.connected())) {
      final dto = await selectRandomStormQuote();
      if (dto == null) {
        throw Exception('StormQuote was not received');
      }
      return dto;
    }
    final response = await netClient('random.json');
    if (response.data is Map) {
      final dto = StormQuoteDTO.fromJson(response.data);
      saveStormQuote(dto);
      return dto;
    }
    throw Exception('StormQuote was not received');
  }
}
