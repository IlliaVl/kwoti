import '../../domain_layer/abstracts/network/net_client.dart';

/// Net client for QuoteGarden `https://pprathameshmore.github.io/QuoteGarden/`
class GardenNetClient extends NetClient {
  static const String _baseUrl =
      'https://quote-garden.herokuapp.com/api/v3/quotes/';

  /// Creates new [GardenNetClient]
  GardenNetClient() : super(baseUrl: _baseUrl);
}
