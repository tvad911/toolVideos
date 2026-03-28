import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Sessions table - stores recording sessions
class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  TextColumn get thumbnailPath => text().nullable()();
  TextColumn get videoPath => text().nullable()();
  RealColumn get fileSizeMb => real().nullable()();
  TextColumn get storageLocation => text().withDefault(const Constant('DISK_1'))();
}

// SessionTags table - stores barcodes scanned during sessions
class SessionTags extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(Sessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get barcodeContent => text()();
  DateTimeColumn get scannedAt => dateTime()();
  RealColumn get weightAtScan => real().nullable()();
}

// Settings table - stores application configuration
class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cameraConfigs => text().nullable()(); // JSON string
  TextColumn get storagePath => text().nullable()();
  TextColumn get watermarkText => text().nullable()();
  TextColumn get hardwareAcceleration => text().withDefault(const Constant('AUTO'))();
}

@DriftDatabase(tables: [Sessions, SessionTags, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Session queries
  Future<List<Session>> getAllSessions() => select(sessions).get();
  
  Future<Session?> getSessionById(int id) => 
    (select(sessions)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  
  Future<Session?> getSessionByUuid(String uuid) => 
    (select(sessions)..where((tbl) => tbl.uuid.equals(uuid))).getSingleOrNull();
  
  Future<List<Session>> searchSessionsByBarcode(String barcode) async {
    final query = select(sessions).join([
      innerJoin(
        sessionTags,
        sessionTags.sessionId.equalsExp(sessions.id),
      ),
    ])..where(sessionTags.barcodeContent.like('%$barcode%'));
    
    final results = await query.get();
    return results.map((row) => row.readTable(sessions)).toList();
  }
  
  Future<List<Session>> getSessionsByDateRange(DateTime start, DateTime end) =>
    (select(sessions)
      ..where((tbl) => tbl.createdAt.isBetweenValues(start, end))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
    .get();
  
  Future<int> insertSession(SessionsCompanion session) => 
    into(sessions).insert(session);
  
  Future<bool> updateSession(Session session) => 
    update(sessions).replace(session);
  
  Future<int> deleteSession(int id) => 
    (delete(sessions)..where((tbl) => tbl.id.equals(id))).go();

  // SessionTag queries
  Future<List<SessionTag>> getTagsForSession(int sessionId) =>
    (select(sessionTags)..where((tbl) => tbl.sessionId.equals(sessionId))).get();
  
  Future<int> insertSessionTag(SessionTagsCompanion tag) => 
    into(sessionTags).insert(tag);

  // Settings queries
  Future<Setting?> getSettings() => 
    select(settings).getSingleOrNull();
  
  Future<int> insertSettings(SettingsCompanion setting) => 
    into(settings).insert(setting);
  
  Future<bool> updateSettings(Setting setting) => 
    update(settings).replace(setting);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'packstation.db'));
    return NativeDatabase(file);
  });
}
