// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmiDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BmiDAO _bmiDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Bmi` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `height` TEXT, `weight` TEXT, `bmi` TEXT, `date` TEXT, `comment` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BmiDAO get bmiDAO {
    return _bmiDAOInstance ??= _$BmiDAO(database, changeListener);
  }
}

class _$BmiDAO extends BmiDAO {
  _$BmiDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _bmiInsertionAdapter = InsertionAdapter(
            database,
            'Bmi',
            (Bmi item) => <String, dynamic>{
                  'id': item.id,
                  'height': item.height,
                  'weight': item.weight,
                  'bmi': item.bmi,
                  'date': item.date,
                  'comment': item.comment
                }),
        _bmiUpdateAdapter = UpdateAdapter(
            database,
            'Bmi',
            ['id'],
            (Bmi item) => <String, dynamic>{
                  'id': item.id,
                  'height': item.height,
                  'weight': item.weight,
                  'bmi': item.bmi,
                  'date': item.date,
                  'comment': item.comment
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Bmi> _bmiInsertionAdapter;

  final UpdateAdapter<Bmi> _bmiUpdateAdapter;

  @override
  Future<List<Bmi>> getAllItemInBmiByUid() async {
    return _queryAdapter.queryList('SELECT * FROM Bmi',
        mapper: (Map<String, dynamic> row) => Bmi(
            id: row['id'] as int,
            height: row['height'] as String,
            weight: row['weight'] as String,
            bmi: row['bmi'] as String,
            date: row['date'] as String,
            comment: row['comment'] as String));
  }

  @override
  Future<void> clearBmiById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Bmi WHERE id =?', arguments: <dynamic>[id]);
  }

  @override
  Future<int> insertBmi(Bmi bmi) {
    return _bmiInsertionAdapter.insertAndReturnId(
        bmi, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateBmi(Bmi bmi) {
    return _bmiUpdateAdapter.updateAndReturnChangedRows(
        bmi, OnConflictStrategy.abort);
  }
}
