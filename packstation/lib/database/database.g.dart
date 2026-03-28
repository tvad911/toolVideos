// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoPathMeta = const VerificationMeta(
    'videoPath',
  );
  @override
  late final GeneratedColumn<String> videoPath = GeneratedColumn<String>(
    'video_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeMbMeta = const VerificationMeta(
    'fileSizeMb',
  );
  @override
  late final GeneratedColumn<double> fileSizeMb = GeneratedColumn<double>(
    'file_size_mb',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storageLocationMeta = const VerificationMeta(
    'storageLocation',
  );
  @override
  late final GeneratedColumn<String> storageLocation = GeneratedColumn<String>(
    'storage_location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('DISK_1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    createdAt,
    endedAt,
    durationSeconds,
    thumbnailPath,
    videoPath,
    fileSizeMb,
    storageLocation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('video_path')) {
      context.handle(
        _videoPathMeta,
        videoPath.isAcceptableOrUnknown(data['video_path']!, _videoPathMeta),
      );
    }
    if (data.containsKey('file_size_mb')) {
      context.handle(
        _fileSizeMbMeta,
        fileSizeMb.isAcceptableOrUnknown(
          data['file_size_mb']!,
          _fileSizeMbMeta,
        ),
      );
    }
    if (data.containsKey('storage_location')) {
      context.handle(
        _storageLocationMeta,
        storageLocation.isAcceptableOrUnknown(
          data['storage_location']!,
          _storageLocationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      uuid:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}uuid'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      ),
      videoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_path'],
      ),
      fileSizeMb: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}file_size_mb'],
      ),
      storageLocation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}storage_location'],
          )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final int id;
  final String uuid;
  final DateTime createdAt;
  final DateTime? endedAt;
  final int? durationSeconds;
  final String? thumbnailPath;
  final String? videoPath;
  final double? fileSizeMb;
  final String storageLocation;
  const Session({
    required this.id,
    required this.uuid,
    required this.createdAt,
    this.endedAt,
    this.durationSeconds,
    this.thumbnailPath,
    this.videoPath,
    this.fileSizeMb,
    required this.storageLocation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    if (!nullToAbsent || videoPath != null) {
      map['video_path'] = Variable<String>(videoPath);
    }
    if (!nullToAbsent || fileSizeMb != null) {
      map['file_size_mb'] = Variable<double>(fileSizeMb);
    }
    map['storage_location'] = Variable<String>(storageLocation);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      uuid: Value(uuid),
      createdAt: Value(createdAt),
      endedAt:
          endedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(endedAt),
      durationSeconds:
          durationSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(durationSeconds),
      thumbnailPath:
          thumbnailPath == null && nullToAbsent
              ? const Value.absent()
              : Value(thumbnailPath),
      videoPath:
          videoPath == null && nullToAbsent
              ? const Value.absent()
              : Value(videoPath),
      fileSizeMb:
          fileSizeMb == null && nullToAbsent
              ? const Value.absent()
              : Value(fileSizeMb),
      storageLocation: Value(storageLocation),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      videoPath: serializer.fromJson<String?>(json['videoPath']),
      fileSizeMb: serializer.fromJson<double?>(json['fileSizeMb']),
      storageLocation: serializer.fromJson<String>(json['storageLocation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'videoPath': serializer.toJson<String?>(videoPath),
      'fileSizeMb': serializer.toJson<double?>(fileSizeMb),
      'storageLocation': serializer.toJson<String>(storageLocation),
    };
  }

  Session copyWith({
    int? id,
    String? uuid,
    DateTime? createdAt,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    Value<String?> thumbnailPath = const Value.absent(),
    Value<String?> videoPath = const Value.absent(),
    Value<double?> fileSizeMb = const Value.absent(),
    String? storageLocation,
  }) => Session(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    createdAt: createdAt ?? this.createdAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    durationSeconds:
        durationSeconds.present ? durationSeconds.value : this.durationSeconds,
    thumbnailPath:
        thumbnailPath.present ? thumbnailPath.value : this.thumbnailPath,
    videoPath: videoPath.present ? videoPath.value : this.videoPath,
    fileSizeMb: fileSizeMb.present ? fileSizeMb.value : this.fileSizeMb,
    storageLocation: storageLocation ?? this.storageLocation,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationSeconds:
          data.durationSeconds.present
              ? data.durationSeconds.value
              : this.durationSeconds,
      thumbnailPath:
          data.thumbnailPath.present
              ? data.thumbnailPath.value
              : this.thumbnailPath,
      videoPath: data.videoPath.present ? data.videoPath.value : this.videoPath,
      fileSizeMb:
          data.fileSizeMb.present ? data.fileSizeMb.value : this.fileSizeMb,
      storageLocation:
          data.storageLocation.present
              ? data.storageLocation.value
              : this.storageLocation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('videoPath: $videoPath, ')
          ..write('fileSizeMb: $fileSizeMb, ')
          ..write('storageLocation: $storageLocation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    createdAt,
    endedAt,
    durationSeconds,
    thumbnailPath,
    videoPath,
    fileSizeMb,
    storageLocation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.endedAt == this.endedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.thumbnailPath == this.thumbnailPath &&
          other.videoPath == this.videoPath &&
          other.fileSizeMb == this.fileSizeMb &&
          other.storageLocation == this.storageLocation);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<DateTime?> endedAt;
  final Value<int?> durationSeconds;
  final Value<String?> thumbnailPath;
  final Value<String?> videoPath;
  final Value<double?> fileSizeMb;
  final Value<String> storageLocation;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.videoPath = const Value.absent(),
    this.fileSizeMb = const Value.absent(),
    this.storageLocation = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    required DateTime createdAt,
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.videoPath = const Value.absent(),
    this.fileSizeMb = const Value.absent(),
    this.storageLocation = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationSeconds,
    Expression<String>? thumbnailPath,
    Expression<String>? videoPath,
    Expression<double>? fileSizeMb,
    Expression<String>? storageLocation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (videoPath != null) 'video_path': videoPath,
      if (fileSizeMb != null) 'file_size_mb': fileSizeMb,
      if (storageLocation != null) 'storage_location': storageLocation,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<DateTime>? createdAt,
    Value<DateTime?>? endedAt,
    Value<int?>? durationSeconds,
    Value<String?>? thumbnailPath,
    Value<String?>? videoPath,
    Value<double?>? fileSizeMb,
    Value<String>? storageLocation,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      endedAt: endedAt ?? this.endedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      videoPath: videoPath ?? this.videoPath,
      fileSizeMb: fileSizeMb ?? this.fileSizeMb,
      storageLocation: storageLocation ?? this.storageLocation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (videoPath.present) {
      map['video_path'] = Variable<String>(videoPath.value);
    }
    if (fileSizeMb.present) {
      map['file_size_mb'] = Variable<double>(fileSizeMb.value);
    }
    if (storageLocation.present) {
      map['storage_location'] = Variable<String>(storageLocation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('videoPath: $videoPath, ')
          ..write('fileSizeMb: $fileSizeMb, ')
          ..write('storageLocation: $storageLocation')
          ..write(')'))
        .toString();
  }
}

class $SessionTagsTable extends SessionTags
    with TableInfo<$SessionTagsTable, SessionTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _barcodeContentMeta = const VerificationMeta(
    'barcodeContent',
  );
  @override
  late final GeneratedColumn<String> barcodeContent = GeneratedColumn<String>(
    'barcode_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scannedAtMeta = const VerificationMeta(
    'scannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
    'scanned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightAtScanMeta = const VerificationMeta(
    'weightAtScan',
  );
  @override
  late final GeneratedColumn<double> weightAtScan = GeneratedColumn<double>(
    'weight_at_scan',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    barcodeContent,
    scannedAt,
    weightAtScan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('barcode_content')) {
      context.handle(
        _barcodeContentMeta,
        barcodeContent.isAcceptableOrUnknown(
          data['barcode_content']!,
          _barcodeContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_barcodeContentMeta);
    }
    if (data.containsKey('scanned_at')) {
      context.handle(
        _scannedAtMeta,
        scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    if (data.containsKey('weight_at_scan')) {
      context.handle(
        _weightAtScanMeta,
        weightAtScan.isAcceptableOrUnknown(
          data['weight_at_scan']!,
          _weightAtScanMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionTag(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      sessionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}session_id'],
          )!,
      barcodeContent:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}barcode_content'],
          )!,
      scannedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}scanned_at'],
          )!,
      weightAtScan: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_at_scan'],
      ),
    );
  }

  @override
  $SessionTagsTable createAlias(String alias) {
    return $SessionTagsTable(attachedDatabase, alias);
  }
}

class SessionTag extends DataClass implements Insertable<SessionTag> {
  final int id;
  final int sessionId;
  final String barcodeContent;
  final DateTime scannedAt;
  final double? weightAtScan;
  const SessionTag({
    required this.id,
    required this.sessionId,
    required this.barcodeContent,
    required this.scannedAt,
    this.weightAtScan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['barcode_content'] = Variable<String>(barcodeContent);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    if (!nullToAbsent || weightAtScan != null) {
      map['weight_at_scan'] = Variable<double>(weightAtScan);
    }
    return map;
  }

  SessionTagsCompanion toCompanion(bool nullToAbsent) {
    return SessionTagsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      barcodeContent: Value(barcodeContent),
      scannedAt: Value(scannedAt),
      weightAtScan:
          weightAtScan == null && nullToAbsent
              ? const Value.absent()
              : Value(weightAtScan),
    );
  }

  factory SessionTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionTag(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      barcodeContent: serializer.fromJson<String>(json['barcodeContent']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
      weightAtScan: serializer.fromJson<double?>(json['weightAtScan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'barcodeContent': serializer.toJson<String>(barcodeContent),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
      'weightAtScan': serializer.toJson<double?>(weightAtScan),
    };
  }

  SessionTag copyWith({
    int? id,
    int? sessionId,
    String? barcodeContent,
    DateTime? scannedAt,
    Value<double?> weightAtScan = const Value.absent(),
  }) => SessionTag(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    barcodeContent: barcodeContent ?? this.barcodeContent,
    scannedAt: scannedAt ?? this.scannedAt,
    weightAtScan: weightAtScan.present ? weightAtScan.value : this.weightAtScan,
  );
  SessionTag copyWithCompanion(SessionTagsCompanion data) {
    return SessionTag(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      barcodeContent:
          data.barcodeContent.present
              ? data.barcodeContent.value
              : this.barcodeContent,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
      weightAtScan:
          data.weightAtScan.present
              ? data.weightAtScan.value
              : this.weightAtScan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionTag(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('barcodeContent: $barcodeContent, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('weightAtScan: $weightAtScan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, barcodeContent, scannedAt, weightAtScan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionTag &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.barcodeContent == this.barcodeContent &&
          other.scannedAt == this.scannedAt &&
          other.weightAtScan == this.weightAtScan);
}

class SessionTagsCompanion extends UpdateCompanion<SessionTag> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<String> barcodeContent;
  final Value<DateTime> scannedAt;
  final Value<double?> weightAtScan;
  const SessionTagsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.barcodeContent = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.weightAtScan = const Value.absent(),
  });
  SessionTagsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required String barcodeContent,
    required DateTime scannedAt,
    this.weightAtScan = const Value.absent(),
  }) : sessionId = Value(sessionId),
       barcodeContent = Value(barcodeContent),
       scannedAt = Value(scannedAt);
  static Insertable<SessionTag> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<String>? barcodeContent,
    Expression<DateTime>? scannedAt,
    Expression<double>? weightAtScan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (barcodeContent != null) 'barcode_content': barcodeContent,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (weightAtScan != null) 'weight_at_scan': weightAtScan,
    });
  }

  SessionTagsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<String>? barcodeContent,
    Value<DateTime>? scannedAt,
    Value<double?>? weightAtScan,
  }) {
    return SessionTagsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      barcodeContent: barcodeContent ?? this.barcodeContent,
      scannedAt: scannedAt ?? this.scannedAt,
      weightAtScan: weightAtScan ?? this.weightAtScan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (barcodeContent.present) {
      map['barcode_content'] = Variable<String>(barcodeContent.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (weightAtScan.present) {
      map['weight_at_scan'] = Variable<double>(weightAtScan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionTagsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('barcodeContent: $barcodeContent, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('weightAtScan: $weightAtScan')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cameraConfigsMeta = const VerificationMeta(
    'cameraConfigs',
  );
  @override
  late final GeneratedColumn<String> cameraConfigs = GeneratedColumn<String>(
    'camera_configs',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storagePathMeta = const VerificationMeta(
    'storagePath',
  );
  @override
  late final GeneratedColumn<String> storagePath = GeneratedColumn<String>(
    'storage_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _watermarkTextMeta = const VerificationMeta(
    'watermarkText',
  );
  @override
  late final GeneratedColumn<String> watermarkText = GeneratedColumn<String>(
    'watermark_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hardwareAccelerationMeta =
      const VerificationMeta('hardwareAcceleration');
  @override
  late final GeneratedColumn<String> hardwareAcceleration =
      GeneratedColumn<String>(
        'hardware_acceleration',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('AUTO'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cameraConfigs,
    storagePath,
    watermarkText,
    hardwareAcceleration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('camera_configs')) {
      context.handle(
        _cameraConfigsMeta,
        cameraConfigs.isAcceptableOrUnknown(
          data['camera_configs']!,
          _cameraConfigsMeta,
        ),
      );
    }
    if (data.containsKey('storage_path')) {
      context.handle(
        _storagePathMeta,
        storagePath.isAcceptableOrUnknown(
          data['storage_path']!,
          _storagePathMeta,
        ),
      );
    }
    if (data.containsKey('watermark_text')) {
      context.handle(
        _watermarkTextMeta,
        watermarkText.isAcceptableOrUnknown(
          data['watermark_text']!,
          _watermarkTextMeta,
        ),
      );
    }
    if (data.containsKey('hardware_acceleration')) {
      context.handle(
        _hardwareAccelerationMeta,
        hardwareAcceleration.isAcceptableOrUnknown(
          data['hardware_acceleration']!,
          _hardwareAccelerationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      cameraConfigs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}camera_configs'],
      ),
      storagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_path'],
      ),
      watermarkText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}watermark_text'],
      ),
      hardwareAcceleration:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hardware_acceleration'],
          )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String? cameraConfigs;
  final String? storagePath;
  final String? watermarkText;
  final String hardwareAcceleration;
  const Setting({
    required this.id,
    this.cameraConfigs,
    this.storagePath,
    this.watermarkText,
    required this.hardwareAcceleration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cameraConfigs != null) {
      map['camera_configs'] = Variable<String>(cameraConfigs);
    }
    if (!nullToAbsent || storagePath != null) {
      map['storage_path'] = Variable<String>(storagePath);
    }
    if (!nullToAbsent || watermarkText != null) {
      map['watermark_text'] = Variable<String>(watermarkText);
    }
    map['hardware_acceleration'] = Variable<String>(hardwareAcceleration);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      cameraConfigs:
          cameraConfigs == null && nullToAbsent
              ? const Value.absent()
              : Value(cameraConfigs),
      storagePath:
          storagePath == null && nullToAbsent
              ? const Value.absent()
              : Value(storagePath),
      watermarkText:
          watermarkText == null && nullToAbsent
              ? const Value.absent()
              : Value(watermarkText),
      hardwareAcceleration: Value(hardwareAcceleration),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      cameraConfigs: serializer.fromJson<String?>(json['cameraConfigs']),
      storagePath: serializer.fromJson<String?>(json['storagePath']),
      watermarkText: serializer.fromJson<String?>(json['watermarkText']),
      hardwareAcceleration: serializer.fromJson<String>(
        json['hardwareAcceleration'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cameraConfigs': serializer.toJson<String?>(cameraConfigs),
      'storagePath': serializer.toJson<String?>(storagePath),
      'watermarkText': serializer.toJson<String?>(watermarkText),
      'hardwareAcceleration': serializer.toJson<String>(hardwareAcceleration),
    };
  }

  Setting copyWith({
    int? id,
    Value<String?> cameraConfigs = const Value.absent(),
    Value<String?> storagePath = const Value.absent(),
    Value<String?> watermarkText = const Value.absent(),
    String? hardwareAcceleration,
  }) => Setting(
    id: id ?? this.id,
    cameraConfigs:
        cameraConfigs.present ? cameraConfigs.value : this.cameraConfigs,
    storagePath: storagePath.present ? storagePath.value : this.storagePath,
    watermarkText:
        watermarkText.present ? watermarkText.value : this.watermarkText,
    hardwareAcceleration: hardwareAcceleration ?? this.hardwareAcceleration,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      cameraConfigs:
          data.cameraConfigs.present
              ? data.cameraConfigs.value
              : this.cameraConfigs,
      storagePath:
          data.storagePath.present ? data.storagePath.value : this.storagePath,
      watermarkText:
          data.watermarkText.present
              ? data.watermarkText.value
              : this.watermarkText,
      hardwareAcceleration:
          data.hardwareAcceleration.present
              ? data.hardwareAcceleration.value
              : this.hardwareAcceleration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('cameraConfigs: $cameraConfigs, ')
          ..write('storagePath: $storagePath, ')
          ..write('watermarkText: $watermarkText, ')
          ..write('hardwareAcceleration: $hardwareAcceleration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cameraConfigs,
    storagePath,
    watermarkText,
    hardwareAcceleration,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.cameraConfigs == this.cameraConfigs &&
          other.storagePath == this.storagePath &&
          other.watermarkText == this.watermarkText &&
          other.hardwareAcceleration == this.hardwareAcceleration);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<String?> cameraConfigs;
  final Value<String?> storagePath;
  final Value<String?> watermarkText;
  final Value<String> hardwareAcceleration;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.cameraConfigs = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.watermarkText = const Value.absent(),
    this.hardwareAcceleration = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.cameraConfigs = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.watermarkText = const Value.absent(),
    this.hardwareAcceleration = const Value.absent(),
  });
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<String>? cameraConfigs,
    Expression<String>? storagePath,
    Expression<String>? watermarkText,
    Expression<String>? hardwareAcceleration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cameraConfigs != null) 'camera_configs': cameraConfigs,
      if (storagePath != null) 'storage_path': storagePath,
      if (watermarkText != null) 'watermark_text': watermarkText,
      if (hardwareAcceleration != null)
        'hardware_acceleration': hardwareAcceleration,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? cameraConfigs,
    Value<String?>? storagePath,
    Value<String?>? watermarkText,
    Value<String>? hardwareAcceleration,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      cameraConfigs: cameraConfigs ?? this.cameraConfigs,
      storagePath: storagePath ?? this.storagePath,
      watermarkText: watermarkText ?? this.watermarkText,
      hardwareAcceleration: hardwareAcceleration ?? this.hardwareAcceleration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cameraConfigs.present) {
      map['camera_configs'] = Variable<String>(cameraConfigs.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (watermarkText.present) {
      map['watermark_text'] = Variable<String>(watermarkText.value);
    }
    if (hardwareAcceleration.present) {
      map['hardware_acceleration'] = Variable<String>(
        hardwareAcceleration.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('cameraConfigs: $cameraConfigs, ')
          ..write('storagePath: $storagePath, ')
          ..write('watermarkText: $watermarkText, ')
          ..write('hardwareAcceleration: $hardwareAcceleration')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionTagsTable sessionTags = $SessionTagsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessions,
    sessionTags,
    settings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_tags', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      required String uuid,
      required DateTime createdAt,
      Value<DateTime?> endedAt,
      Value<int?> durationSeconds,
      Value<String?> thumbnailPath,
      Value<String?> videoPath,
      Value<double?> fileSizeMb,
      Value<String> storageLocation,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<DateTime> createdAt,
      Value<DateTime?> endedAt,
      Value<int?> durationSeconds,
      Value<String?> thumbnailPath,
      Value<String?> videoPath,
      Value<double?> fileSizeMb,
      Value<String> storageLocation,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionTagsTable, List<SessionTag>>
  _sessionTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionTags,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.sessionTags.sessionId),
  );

  $$SessionTagsTableProcessedTableManager get sessionTagsRefs {
    final manager = $$SessionTagsTableTableManager(
      $_db,
      $_db.sessionTags,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoPath => $composableBuilder(
    column: $table.videoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fileSizeMb => $composableBuilder(
    column: $table.fileSizeMb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storageLocation => $composableBuilder(
    column: $table.storageLocation,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionTagsRefs(
    Expression<bool> Function($$SessionTagsTableFilterComposer f) f,
  ) {
    final $$SessionTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionTags,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTagsTableFilterComposer(
            $db: $db,
            $table: $db.sessionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoPath => $composableBuilder(
    column: $table.videoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fileSizeMb => $composableBuilder(
    column: $table.fileSizeMb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageLocation => $composableBuilder(
    column: $table.storageLocation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get videoPath =>
      $composableBuilder(column: $table.videoPath, builder: (column) => column);

  GeneratedColumn<double> get fileSizeMb => $composableBuilder(
    column: $table.fileSizeMb,
    builder: (column) => column,
  );

  GeneratedColumn<String> get storageLocation => $composableBuilder(
    column: $table.storageLocation,
    builder: (column) => column,
  );

  Expression<T> sessionTagsRefs<T extends Object>(
    Expression<T> Function($$SessionTagsTableAnnotationComposer a) f,
  ) {
    final $$SessionTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionTags,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({bool sessionTagsRefs})
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> videoPath = const Value.absent(),
                Value<double?> fileSizeMb = const Value.absent(),
                Value<String> storageLocation = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                uuid: uuid,
                createdAt: createdAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                thumbnailPath: thumbnailPath,
                videoPath: videoPath,
                fileSizeMb: fileSizeMb,
                storageLocation: storageLocation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                required DateTime createdAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> videoPath = const Value.absent(),
                Value<double?> fileSizeMb = const Value.absent(),
                Value<String> storageLocation = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                uuid: uuid,
                createdAt: createdAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                thumbnailPath: thumbnailPath,
                videoPath: videoPath,
                fileSizeMb: fileSizeMb,
                storageLocation: storageLocation,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SessionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({sessionTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sessionTagsRefs) db.sessionTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionTagsRefs)
                    await $_getPrefetchedData<
                      Session,
                      $SessionsTable,
                      SessionTag
                    >(
                      currentTable: table,
                      referencedTable: $$SessionsTableReferences
                          ._sessionTagsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionTagsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.sessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({bool sessionTagsRefs})
    >;
typedef $$SessionTagsTableCreateCompanionBuilder =
    SessionTagsCompanion Function({
      Value<int> id,
      required int sessionId,
      required String barcodeContent,
      required DateTime scannedAt,
      Value<double?> weightAtScan,
    });
typedef $$SessionTagsTableUpdateCompanionBuilder =
    SessionTagsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<String> barcodeContent,
      Value<DateTime> scannedAt,
      Value<double?> weightAtScan,
    });

final class $$SessionTagsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionTagsTable, SessionTag> {
  $$SessionTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.sessionTags.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionTagsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionTagsTable> {
  $$SessionTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcodeContent => $composableBuilder(
    column: $table.barcodeContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightAtScan => $composableBuilder(
    column: $table.weightAtScan,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionTagsTable> {
  $$SessionTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcodeContent => $composableBuilder(
    column: $table.barcodeContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightAtScan => $composableBuilder(
    column: $table.weightAtScan,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionTagsTable> {
  $$SessionTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get barcodeContent => $composableBuilder(
    column: $table.barcodeContent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scannedAt =>
      $composableBuilder(column: $table.scannedAt, builder: (column) => column);

  GeneratedColumn<double> get weightAtScan => $composableBuilder(
    column: $table.weightAtScan,
    builder: (column) => column,
  );

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionTagsTable,
          SessionTag,
          $$SessionTagsTableFilterComposer,
          $$SessionTagsTableOrderingComposer,
          $$SessionTagsTableAnnotationComposer,
          $$SessionTagsTableCreateCompanionBuilder,
          $$SessionTagsTableUpdateCompanionBuilder,
          (SessionTag, $$SessionTagsTableReferences),
          SessionTag,
          PrefetchHooks Function({bool sessionId})
        > {
  $$SessionTagsTableTableManager(_$AppDatabase db, $SessionTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SessionTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SessionTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$SessionTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<String> barcodeContent = const Value.absent(),
                Value<DateTime> scannedAt = const Value.absent(),
                Value<double?> weightAtScan = const Value.absent(),
              }) => SessionTagsCompanion(
                id: id,
                sessionId: sessionId,
                barcodeContent: barcodeContent,
                scannedAt: scannedAt,
                weightAtScan: weightAtScan,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required String barcodeContent,
                required DateTime scannedAt,
                Value<double?> weightAtScan = const Value.absent(),
              }) => SessionTagsCompanion.insert(
                id: id,
                sessionId: sessionId,
                barcodeContent: barcodeContent,
                scannedAt: scannedAt,
                weightAtScan: weightAtScan,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SessionTagsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (sessionId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.sessionId,
                            referencedTable: $$SessionTagsTableReferences
                                ._sessionIdTable(db),
                            referencedColumn:
                                $$SessionTagsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionTagsTable,
      SessionTag,
      $$SessionTagsTableFilterComposer,
      $$SessionTagsTableOrderingComposer,
      $$SessionTagsTableAnnotationComposer,
      $$SessionTagsTableCreateCompanionBuilder,
      $$SessionTagsTableUpdateCompanionBuilder,
      (SessionTag, $$SessionTagsTableReferences),
      SessionTag,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String?> cameraConfigs,
      Value<String?> storagePath,
      Value<String?> watermarkText,
      Value<String> hardwareAcceleration,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String?> cameraConfigs,
      Value<String?> storagePath,
      Value<String?> watermarkText,
      Value<String> hardwareAcceleration,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cameraConfigs => $composableBuilder(
    column: $table.cameraConfigs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get watermarkText => $composableBuilder(
    column: $table.watermarkText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hardwareAcceleration => $composableBuilder(
    column: $table.hardwareAcceleration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cameraConfigs => $composableBuilder(
    column: $table.cameraConfigs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get watermarkText => $composableBuilder(
    column: $table.watermarkText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hardwareAcceleration => $composableBuilder(
    column: $table.hardwareAcceleration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cameraConfigs => $composableBuilder(
    column: $table.cameraConfigs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get storagePath => $composableBuilder(
    column: $table.storagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get watermarkText => $composableBuilder(
    column: $table.watermarkText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hardwareAcceleration => $composableBuilder(
    column: $table.hardwareAcceleration,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> cameraConfigs = const Value.absent(),
                Value<String?> storagePath = const Value.absent(),
                Value<String?> watermarkText = const Value.absent(),
                Value<String> hardwareAcceleration = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                cameraConfigs: cameraConfigs,
                storagePath: storagePath,
                watermarkText: watermarkText,
                hardwareAcceleration: hardwareAcceleration,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> cameraConfigs = const Value.absent(),
                Value<String?> storagePath = const Value.absent(),
                Value<String?> watermarkText = const Value.absent(),
                Value<String> hardwareAcceleration = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                cameraConfigs: cameraConfigs,
                storagePath: storagePath,
                watermarkText: watermarkText,
                hardwareAcceleration: hardwareAcceleration,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SessionTagsTableTableManager get sessionTags =>
      $$SessionTagsTableTableManager(_db, _db.sessionTags);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
