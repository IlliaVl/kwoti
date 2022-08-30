import 'package:kwoti/data_layer/mapping/storm_quote_dto_mapping.dart';

import '../../domain_layer/abstracts/repositories/base_repository.dart';
import '../../domain_layer/model/quote.dart';
import '../providers/storm_provider.dart';

class StormRepository extends BaseRepository {
  final StormProvider _provider;

  /// Creates new [StormRepository]
  StormRepository({required StormProvider provider}) : _provider = provider;

  @override
  Future<Quote> getRandomQuote() async {
    final dto = await _provider.getRandomQuote();
    return dto.toQuote();
  }
}
