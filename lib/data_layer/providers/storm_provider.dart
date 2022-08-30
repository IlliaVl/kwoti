import '../../domain_layer/abstracts/network/net_client.dart';
import '../dto/storm_quote_dto.dart';

/// QuoteStorm data provider
class StormProvider {
  /// The NetClient to use for the network requests
  final NetClient netClient;

  /// Creates new [StormProvider]
  StormProvider(this.netClient);

  /// Returns random quote
  Future<StormQuoteDTO> getRandomQuote() async {
    if (!(await netClient.connected())) {}
    final response = await netClient('random.json');
    if (response.data is Map) {
      final dto = StormQuoteDTO.fromJson(response.data);
      return dto;
    }
    throw 'StormQuote was not received';
  }
}
