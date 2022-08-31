import 'package:floor/floor.dart';

import '../dto/garden_quote_dto.dart';

@dao
abstract class GardenQuoteDTODao {
  @Query('SELECT * FROM GardenQuoteDTO WHERE id IN '
      '(SELECT id FROM GardenQuoteDTO ORDER BY RANDOM() LIMIT 1)')
  Future<GardenQuoteDTO?> findRandomGardenQuoteDTO();

  @insert
  Future<void> insertGardenQuoteDTO(GardenQuoteDTO gardenQuoteDTO);
}
