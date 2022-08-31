import 'package:floor/floor.dart';

import '../dto/storm_quote_dto.dart';

@dao
abstract class StormQuoteDTODao {
  @Query('SELECT * FROM StormQuoteDTO WHERE id IN '
      '(SELECT id FROM StormQuoteDTO ORDER BY RANDOM() LIMIT 1)')
  Future<StormQuoteDTO?> findRandomStormQuoteDTO();

  @insert
  Future<void> insertStormQuoteDTO(StormQuoteDTO stormQuoteDTO);
}
