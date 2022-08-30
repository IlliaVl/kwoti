import '../../domain_layer/abstracts/network/net_client.dart';

/// Net client for Storm API `http://quotes.stormconsultancy.co.uk/api`
class StormNetClient extends NetClient {
  static const String _baseUrl = 'http://quotes.stormconsultancy.co.uk/';

  /// Creates new [StormNetClient]
  StormNetClient() : super(baseUrl: _baseUrl);
}
