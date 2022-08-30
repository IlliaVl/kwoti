import 'package:kwoti/data_layer/mapping/garden_quote_dto_mapping.dart';

import '../../domain_layer/abstracts/repositories/base_repository.dart';
import '../../domain_layer/model/quote.dart';
import '../providers/garden_provider.dart';

class GardenRepository extends BaseRepository {
  final GardenProvider _provider;

  /// Creates new [GardenRepository]
  GardenRepository({required GardenProvider provider}) : _provider = provider;

  @override
  Future<Quote> getRandomQuote() async {
    final dto = await _provider.getRandomQuote();
    return dto.toQuote();
  }
}
