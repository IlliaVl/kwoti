import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/garden_quote_dao.dart';
import '../dao/storm_quote_dao.dart';
import '../dto/garden_quote_dto.dart';
import '../dto/storm_quote_dto.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [StormQuoteDTO, GardenQuoteDTO])
abstract class AppDatabase extends FloorDatabase {
  StormQuoteDTODao get stormQuoteDTODao;

  GardenQuoteDTODao get gardenQuoteDTODao;
}

/// Helper class to manage database
abstract class DatabaseHelper {
  /// Name of the database
  static const _name = 'app_database.db';

  Future<AppDatabase> get _database async =>
      await $FloorAppDatabase.databaseBuilder(_name).build();

  Future<void> saveStormQuote(StormQuoteDTO dto) async =>
      (await _database).stormQuoteDTODao.insertStormQuoteDTO(dto);

  Future<void> saveGardenQuote(GardenQuoteDTO dto) async =>
      (await _database).gardenQuoteDTODao.insertGardenQuoteDTO(dto);

  Future<StormQuoteDTO?> selectRandomStormQuote() async =>
      (await _database).stormQuoteDTODao.findRandomStormQuoteDTO();

  Future<GardenQuoteDTO?> selectRandomGardenQuote() async =>
      (await _database).gardenQuoteDTODao.findRandomGardenQuoteDTO();
}
