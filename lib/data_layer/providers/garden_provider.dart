import '../../domain_layer/abstracts/network/net_client.dart';
import '../database/app_database.dart';
import '../dto/garden_quote_dto.dart';

/// QuoteGarden data provider
class GardenProvider with DatabaseHelper {
  /// The NetClient to use for the network requests
  final NetClient netClient;

  /// Creates new [GardenProvider]
  GardenProvider(this.netClient);

  /// Returns random quote
  Future<GardenQuoteDTO> getRandomQuote() async {
    if (!(await netClient.connected())) {
      final dto = await selectRandomGardenQuote();
      if (dto == null) {
        throw Exception('GardenQuote was not received');
      }
      return dto;
    }
    final response = await netClient('random');
    if (response.data is Map &&
        response.data.containsKey('data') &&
        response.data['data'] is List &&
        response.data['data'].length > 0) {
      final dto = GardenQuoteDTO.fromJson(response.data['data'][0]);
      saveGardenQuote(dto);
      return dto;
    }
    throw Exception('GardenQuote was not received');
  }
}
