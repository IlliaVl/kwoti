// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StormQuoteDTODao? _stormQuoteDTODaoInstance;

  GardenQuoteDTODao? _gardenQuoteDTODaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StormQuoteDTO` (`id` INTEGER NOT NULL, `quote` TEXT NOT NULL, `author` TEXT NOT NULL, `permalink` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GardenQuoteDTO` (`id` TEXT NOT NULL, `quoteText` TEXT NOT NULL, `quoteAuthor` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StormQuoteDTODao get stormQuoteDTODao {
    return _stormQuoteDTODaoInstance ??=
        _$StormQuoteDTODao(database, changeListener);
  }

  @override
  GardenQuoteDTODao get gardenQuoteDTODao {
    return _gardenQuoteDTODaoInstance ??=
        _$GardenQuoteDTODao(database, changeListener);
  }
}

class _$StormQuoteDTODao extends StormQuoteDTODao {
  _$StormQuoteDTODao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _stormQuoteDTOInsertionAdapter = InsertionAdapter(
            database,
            'StormQuoteDTO',
            (StormQuoteDTO item) => <String, Object?>{
                  'id': item.id,
                  'quote': item.quote,
                  'author': item.author,
                  'permalink': item.permalink
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StormQuoteDTO> _stormQuoteDTOInsertionAdapter;

  @override
  Future<StormQuoteDTO?> findRandomStormQuoteDTO() async {
    return _queryAdapter.query(
        'SELECT * FROM StormQuoteDTO WHERE id IN (SELECT id FROM StormQuoteDTO ORDER BY RANDOM() LIMIT 1)',
        mapper: (Map<String, Object?> row) => StormQuoteDTO(
            id: row['id'] as int,
            quote: row['quote'] as String,
            author: row['author'] as String,
            permalink: row['permalink'] as String?));
  }

  @override
  Future<void> insertStormQuoteDTO(StormQuoteDTO stormQuoteDTO) async {
    await _stormQuoteDTOInsertionAdapter.insert(
        stormQuoteDTO, OnConflictStrategy.ignore);
  }
}

class _$GardenQuoteDTODao extends GardenQuoteDTODao {
  _$GardenQuoteDTODao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _gardenQuoteDTOInsertionAdapter = InsertionAdapter(
            database,
            'GardenQuoteDTO',
            (GardenQuoteDTO item) => <String, Object?>{
                  'id': item.id,
                  'quoteText': item.quoteText,
                  'quoteAuthor': item.quoteAuthor
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GardenQuoteDTO> _gardenQuoteDTOInsertionAdapter;

  @override
  Future<GardenQuoteDTO?> findRandomGardenQuoteDTO() async {
    return _queryAdapter.query(
        'SELECT * FROM GardenQuoteDTO WHERE id IN (SELECT id FROM GardenQuoteDTO ORDER BY RANDOM() LIMIT 1)',
        mapper: (Map<String, Object?> row) => GardenQuoteDTO(
            id: row['id'] as String,
            quoteText: row['quoteText'] as String,
            quoteAuthor: row['quoteAuthor'] as String));
  }

  @override
  Future<void> insertGardenQuoteDTO(GardenQuoteDTO gardenQuoteDTO) async {
    await _gardenQuoteDTOInsertionAdapter.insert(
        gardenQuoteDTO, OnConflictStrategy.ignore);
  }
}
