// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AuditEventsTable extends AuditEvents
    with TableInfo<$AuditEventsTable, AuditEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actorMeta = const VerificationMeta('actor');
  @override
  late final GeneratedColumn<String> actor = GeneratedColumn<String>(
    'actor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    message,
    actor,
    occurredAt,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('actor')) {
      context.handle(
        _actorMeta,
        actor.isAcceptableOrUnknown(data['actor']!, _actorMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      actor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
    );
  }

  @override
  $AuditEventsTable createAlias(String alias) {
    return $AuditEventsTable(attachedDatabase, alias);
  }
}

class AuditEventRow extends DataClass implements Insertable<AuditEventRow> {
  final int id;

  /// A short verb-like label, e.g. "created_shomiti", "recorded_payment".
  final String action;

  /// Optional free-text details (not PII).
  final String? message;

  /// Who performed the action (role / member id), if known.
  final String? actor;
  final DateTime occurredAt;

  /// Optional JSON blob for non-sensitive metadata (debug/diagnostics).
  final String? metadataJson;
  const AuditEventRow({
    required this.id,
    required this.action,
    this.message,
    this.actor,
    required this.occurredAt,
    this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    if (!nullToAbsent || actor != null) {
      map['actor'] = Variable<String>(actor);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    return map;
  }

  AuditEventsCompanion toCompanion(bool nullToAbsent) {
    return AuditEventsCompanion(
      id: Value(id),
      action: Value(action),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      actor: actor == null && nullToAbsent
          ? const Value.absent()
          : Value(actor),
      occurredAt: Value(occurredAt),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
    );
  }

  factory AuditEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditEventRow(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      message: serializer.fromJson<String?>(json['message']),
      actor: serializer.fromJson<String?>(json['actor']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'message': serializer.toJson<String?>(message),
      'actor': serializer.toJson<String?>(actor),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'metadataJson': serializer.toJson<String?>(metadataJson),
    };
  }

  AuditEventRow copyWith({
    int? id,
    String? action,
    Value<String?> message = const Value.absent(),
    Value<String?> actor = const Value.absent(),
    DateTime? occurredAt,
    Value<String?> metadataJson = const Value.absent(),
  }) => AuditEventRow(
    id: id ?? this.id,
    action: action ?? this.action,
    message: message.present ? message.value : this.message,
    actor: actor.present ? actor.value : this.actor,
    occurredAt: occurredAt ?? this.occurredAt,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
  );
  AuditEventRow copyWithCompanion(AuditEventsCompanion data) {
    return AuditEventRow(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      message: data.message.present ? data.message.value : this.message,
      actor: data.actor.present ? data.actor.value : this.actor,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventRow(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('message: $message, ')
          ..write('actor: $actor, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, action, message, actor, occurredAt, metadataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditEventRow &&
          other.id == this.id &&
          other.action == this.action &&
          other.message == this.message &&
          other.actor == this.actor &&
          other.occurredAt == this.occurredAt &&
          other.metadataJson == this.metadataJson);
}

class AuditEventsCompanion extends UpdateCompanion<AuditEventRow> {
  final Value<int> id;
  final Value<String> action;
  final Value<String?> message;
  final Value<String?> actor;
  final Value<DateTime> occurredAt;
  final Value<String?> metadataJson;
  const AuditEventsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.message = const Value.absent(),
    this.actor = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.metadataJson = const Value.absent(),
  });
  AuditEventsCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    this.message = const Value.absent(),
    this.actor = const Value.absent(),
    required DateTime occurredAt,
    this.metadataJson = const Value.absent(),
  }) : action = Value(action),
       occurredAt = Value(occurredAt);
  static Insertable<AuditEventRow> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? message,
    Expression<String>? actor,
    Expression<DateTime>? occurredAt,
    Expression<String>? metadataJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (message != null) 'message': message,
      if (actor != null) 'actor': actor,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (metadataJson != null) 'metadata_json': metadataJson,
    });
  }

  AuditEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<String?>? message,
    Value<String?>? actor,
    Value<DateTime>? occurredAt,
    Value<String?>? metadataJson,
  }) {
    return AuditEventsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      message: message ?? this.message,
      actor: actor ?? this.actor,
      occurredAt: occurredAt ?? this.occurredAt,
      metadataJson: metadataJson ?? this.metadataJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (actor.present) {
      map['actor'] = Variable<String>(actor.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('message: $message, ')
          ..write('actor: $actor, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }
}

class $LedgerEntriesTable extends LedgerEntries
    with TableInfo<$LedgerEntriesTable, LedgerEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amountMinor,
    direction,
    category,
    note,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $LedgerEntriesTable createAlias(String alias) {
    return $LedgerEntriesTable(attachedDatabase, alias);
  }
}

class LedgerEntryRow extends DataClass implements Insertable<LedgerEntryRow> {
  final int id;

  /// Amount in BDT minor units (poisha).
  final int amountMinor;

  /// 'in' or 'out' (kept as text for forward compatibility).
  final String direction;

  /// Optional category label, e.g. "contribution", "payout".
  final String? category;

  /// Optional note (avoid PII).
  final String? note;
  final DateTime occurredAt;
  const LedgerEntryRow({
    required this.id,
    required this.amountMinor,
    required this.direction,
    this.category,
    this.note,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['direction'] = Variable<String>(direction);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  LedgerEntriesCompanion toCompanion(bool nullToAbsent) {
    return LedgerEntriesCompanion(
      id: Value(id),
      amountMinor: Value(amountMinor),
      direction: Value(direction),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      occurredAt: Value(occurredAt),
    );
  }

  factory LedgerEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerEntryRow(
      id: serializer.fromJson<int>(json['id']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      direction: serializer.fromJson<String>(json['direction']),
      category: serializer.fromJson<String?>(json['category']),
      note: serializer.fromJson<String?>(json['note']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'direction': serializer.toJson<String>(direction),
      'category': serializer.toJson<String?>(category),
      'note': serializer.toJson<String?>(note),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  LedgerEntryRow copyWith({
    int? id,
    int? amountMinor,
    String? direction,
    Value<String?> category = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? occurredAt,
  }) => LedgerEntryRow(
    id: id ?? this.id,
    amountMinor: amountMinor ?? this.amountMinor,
    direction: direction ?? this.direction,
    category: category.present ? category.value : this.category,
    note: note.present ? note.value : this.note,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  LedgerEntryRow copyWithCompanion(LedgerEntriesCompanion data) {
    return LedgerEntryRow(
      id: data.id.present ? data.id.value : this.id,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      direction: data.direction.present ? data.direction.value : this.direction,
      category: data.category.present ? data.category.value : this.category,
      note: data.note.present ? data.note.value : this.note,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntryRow(')
          ..write('id: $id, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('direction: $direction, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, amountMinor, direction, category, note, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerEntryRow &&
          other.id == this.id &&
          other.amountMinor == this.amountMinor &&
          other.direction == this.direction &&
          other.category == this.category &&
          other.note == this.note &&
          other.occurredAt == this.occurredAt);
}

class LedgerEntriesCompanion extends UpdateCompanion<LedgerEntryRow> {
  final Value<int> id;
  final Value<int> amountMinor;
  final Value<String> direction;
  final Value<String?> category;
  final Value<String?> note;
  final Value<DateTime> occurredAt;
  const LedgerEntriesCompanion({
    this.id = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.direction = const Value.absent(),
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    this.occurredAt = const Value.absent(),
  });
  LedgerEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int amountMinor,
    required String direction,
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime occurredAt,
  }) : amountMinor = Value(amountMinor),
       direction = Value(direction),
       occurredAt = Value(occurredAt);
  static Insertable<LedgerEntryRow> custom({
    Expression<int>? id,
    Expression<int>? amountMinor,
    Expression<String>? direction,
    Expression<String>? category,
    Expression<String>? note,
    Expression<DateTime>? occurredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (direction != null) 'direction': direction,
      if (category != null) 'category': category,
      if (note != null) 'note': note,
      if (occurredAt != null) 'occurred_at': occurredAt,
    });
  }

  LedgerEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? amountMinor,
    Value<String>? direction,
    Value<String?>? category,
    Value<String?>? note,
    Value<DateTime>? occurredAt,
  }) {
    return LedgerEntriesCompanion(
      id: id ?? this.id,
      amountMinor: amountMinor ?? this.amountMinor,
      direction: direction ?? this.direction,
      category: category ?? this.category,
      note: note ?? this.note,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('direction: $direction, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }
}

class $ShomitisTable extends Shomitis
    with TableInfo<$ShomitisTable, ShomitiRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShomitisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  static const VerificationMeta _activeRuleSetVersionIdMeta =
      const VerificationMeta('activeRuleSetVersionId');
  @override
  late final GeneratedColumn<String> activeRuleSetVersionId =
      GeneratedColumn<String>(
        'active_rule_set_version_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    startDate,
    createdAt,
    activeRuleSetVersionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shomitis';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShomitiRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('active_rule_set_version_id')) {
      context.handle(
        _activeRuleSetVersionIdMeta,
        activeRuleSetVersionId.isAcceptableOrUnknown(
          data['active_rule_set_version_id']!,
          _activeRuleSetVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activeRuleSetVersionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShomitiRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShomitiRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      activeRuleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_rule_set_version_id'],
      )!,
    );
  }

  @override
  $ShomitisTable createAlias(String alias) {
    return $ShomitisTable(attachedDatabase, alias);
  }
}

class ShomitiRow extends DataClass implements Insertable<ShomitiRow> {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime createdAt;
  final String activeRuleSetVersionId;
  const ShomitiRow({
    required this.id,
    required this.name,
    required this.startDate,
    required this.createdAt,
    required this.activeRuleSetVersionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<DateTime>(startDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['active_rule_set_version_id'] = Variable<String>(
      activeRuleSetVersionId,
    );
    return map;
  }

  ShomitisCompanion toCompanion(bool nullToAbsent) {
    return ShomitisCompanion(
      id: Value(id),
      name: Value(name),
      startDate: Value(startDate),
      createdAt: Value(createdAt),
      activeRuleSetVersionId: Value(activeRuleSetVersionId),
    );
  }

  factory ShomitiRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShomitiRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      activeRuleSetVersionId: serializer.fromJson<String>(
        json['activeRuleSetVersionId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<DateTime>(startDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'activeRuleSetVersionId': serializer.toJson<String>(
        activeRuleSetVersionId,
      ),
    };
  }

  ShomitiRow copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? createdAt,
    String? activeRuleSetVersionId,
  }) => ShomitiRow(
    id: id ?? this.id,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    createdAt: createdAt ?? this.createdAt,
    activeRuleSetVersionId:
        activeRuleSetVersionId ?? this.activeRuleSetVersionId,
  );
  ShomitiRow copyWithCompanion(ShomitisCompanion data) {
    return ShomitiRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      activeRuleSetVersionId: data.activeRuleSetVersionId.present
          ? data.activeRuleSetVersionId.value
          : this.activeRuleSetVersionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShomitiRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('activeRuleSetVersionId: $activeRuleSetVersionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, startDate, createdAt, activeRuleSetVersionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShomitiRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.createdAt == this.createdAt &&
          other.activeRuleSetVersionId == this.activeRuleSetVersionId);
}

class ShomitisCompanion extends UpdateCompanion<ShomitiRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> startDate;
  final Value<DateTime> createdAt;
  final Value<String> activeRuleSetVersionId;
  final Value<int> rowid;
  const ShomitisCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.activeRuleSetVersionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShomitisCompanion.insert({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime createdAt,
    required String activeRuleSetVersionId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       activeRuleSetVersionId = Value(activeRuleSetVersionId);
  static Insertable<ShomitiRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? startDate,
    Expression<DateTime>? createdAt,
    Expression<String>? activeRuleSetVersionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (createdAt != null) 'created_at': createdAt,
      if (activeRuleSetVersionId != null)
        'active_rule_set_version_id': activeRuleSetVersionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShomitisCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? startDate,
    Value<DateTime>? createdAt,
    Value<String>? activeRuleSetVersionId,
    Value<int>? rowid,
  }) {
    return ShomitisCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      createdAt: createdAt ?? this.createdAt,
      activeRuleSetVersionId:
          activeRuleSetVersionId ?? this.activeRuleSetVersionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (activeRuleSetVersionId.present) {
      map['active_rule_set_version_id'] = Variable<String>(
        activeRuleSetVersionId.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShomitisCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('activeRuleSetVersionId: $activeRuleSetVersionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, MemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shomitiIdMeta = const VerificationMeta(
    'shomitiId',
  );
  @override
  late final GeneratedColumn<String> shomitiId = GeneratedColumn<String>(
    'shomiti_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shomitis (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressOrWorkplaceMeta =
      const VerificationMeta('addressOrWorkplace');
  @override
  late final GeneratedColumn<String> addressOrWorkplace =
      GeneratedColumn<String>(
        'address_or_workplace',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nidOrPassportMeta = const VerificationMeta(
    'nidOrPassport',
  );
  @override
  late final GeneratedColumn<String> nidOrPassport = GeneratedColumn<String>(
    'nid_or_passport',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emergencyContactNameMeta =
      const VerificationMeta('emergencyContactName');
  @override
  late final GeneratedColumn<String> emergencyContactName =
      GeneratedColumn<String>(
        'emergency_contact_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _emergencyContactPhoneMeta =
      const VerificationMeta('emergencyContactPhone');
  @override
  late final GeneratedColumn<String> emergencyContactPhone =
      GeneratedColumn<String>(
        'emergency_contact_phone',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shomitiId,
    position,
    displayName,
    phone,
    addressOrWorkplace,
    nidOrPassport,
    emergencyContactName,
    emergencyContactPhone,
    notes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shomiti_id')) {
      context.handle(
        _shomitiIdMeta,
        shomitiId.isAcceptableOrUnknown(data['shomiti_id']!, _shomitiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shomitiIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address_or_workplace')) {
      context.handle(
        _addressOrWorkplaceMeta,
        addressOrWorkplace.isAcceptableOrUnknown(
          data['address_or_workplace']!,
          _addressOrWorkplaceMeta,
        ),
      );
    }
    if (data.containsKey('nid_or_passport')) {
      context.handle(
        _nidOrPassportMeta,
        nidOrPassport.isAcceptableOrUnknown(
          data['nid_or_passport']!,
          _nidOrPassportMeta,
        ),
      );
    }
    if (data.containsKey('emergency_contact_name')) {
      context.handle(
        _emergencyContactNameMeta,
        emergencyContactName.isAcceptableOrUnknown(
          data['emergency_contact_name']!,
          _emergencyContactNameMeta,
        ),
      );
    }
    if (data.containsKey('emergency_contact_phone')) {
      context.handle(
        _emergencyContactPhoneMeta,
        emergencyContactPhone.isAcceptableOrUnknown(
          data['emergency_contact_phone']!,
          _emergencyContactPhoneMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      addressOrWorkplace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_or_workplace'],
      ),
      nidOrPassport: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nid_or_passport'],
      ),
      emergencyContactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact_name'],
      ),
      emergencyContactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact_phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class MemberRow extends DataClass implements Insertable<MemberRow> {
  final String id;
  final String shomitiId;

  /// 1-based ordering for predictable UI lists.
  final int position;
  final String displayName;

  /// `rules.md` Section 3 identity/contact fields.
  final String? phone;
  final String? addressOrWorkplace;
  final String? nidOrPassport;
  final String? emergencyContactName;
  final String? emergencyContactPhone;

  /// Optional notes. Avoid storing highly sensitive content.
  final String? notes;

  /// Soft-delete/deactivation (keep history + audit).
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const MemberRow({
    required this.id,
    required this.shomitiId,
    required this.position,
    required this.displayName,
    this.phone,
    this.addressOrWorkplace,
    this.nidOrPassport,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.notes,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['position'] = Variable<int>(position);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || addressOrWorkplace != null) {
      map['address_or_workplace'] = Variable<String>(addressOrWorkplace);
    }
    if (!nullToAbsent || nidOrPassport != null) {
      map['nid_or_passport'] = Variable<String>(nidOrPassport);
    }
    if (!nullToAbsent || emergencyContactName != null) {
      map['emergency_contact_name'] = Variable<String>(emergencyContactName);
    }
    if (!nullToAbsent || emergencyContactPhone != null) {
      map['emergency_contact_phone'] = Variable<String>(emergencyContactPhone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      shomitiId: Value(shomitiId),
      position: Value(position),
      displayName: Value(displayName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      addressOrWorkplace: addressOrWorkplace == null && nullToAbsent
          ? const Value.absent()
          : Value(addressOrWorkplace),
      nidOrPassport: nidOrPassport == null && nullToAbsent
          ? const Value.absent()
          : Value(nidOrPassport),
      emergencyContactName: emergencyContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactName),
      emergencyContactPhone: emergencyContactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactPhone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory MemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberRow(
      id: serializer.fromJson<String>(json['id']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      position: serializer.fromJson<int>(json['position']),
      displayName: serializer.fromJson<String>(json['displayName']),
      phone: serializer.fromJson<String?>(json['phone']),
      addressOrWorkplace: serializer.fromJson<String?>(
        json['addressOrWorkplace'],
      ),
      nidOrPassport: serializer.fromJson<String?>(json['nidOrPassport']),
      emergencyContactName: serializer.fromJson<String?>(
        json['emergencyContactName'],
      ),
      emergencyContactPhone: serializer.fromJson<String?>(
        json['emergencyContactPhone'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'position': serializer.toJson<int>(position),
      'displayName': serializer.toJson<String>(displayName),
      'phone': serializer.toJson<String?>(phone),
      'addressOrWorkplace': serializer.toJson<String?>(addressOrWorkplace),
      'nidOrPassport': serializer.toJson<String?>(nidOrPassport),
      'emergencyContactName': serializer.toJson<String?>(emergencyContactName),
      'emergencyContactPhone': serializer.toJson<String?>(
        emergencyContactPhone,
      ),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  MemberRow copyWith({
    String? id,
    String? shomitiId,
    int? position,
    String? displayName,
    Value<String?> phone = const Value.absent(),
    Value<String?> addressOrWorkplace = const Value.absent(),
    Value<String?> nidOrPassport = const Value.absent(),
    Value<String?> emergencyContactName = const Value.absent(),
    Value<String?> emergencyContactPhone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => MemberRow(
    id: id ?? this.id,
    shomitiId: shomitiId ?? this.shomitiId,
    position: position ?? this.position,
    displayName: displayName ?? this.displayName,
    phone: phone.present ? phone.value : this.phone,
    addressOrWorkplace: addressOrWorkplace.present
        ? addressOrWorkplace.value
        : this.addressOrWorkplace,
    nidOrPassport: nidOrPassport.present
        ? nidOrPassport.value
        : this.nidOrPassport,
    emergencyContactName: emergencyContactName.present
        ? emergencyContactName.value
        : this.emergencyContactName,
    emergencyContactPhone: emergencyContactPhone.present
        ? emergencyContactPhone.value
        : this.emergencyContactPhone,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  MemberRow copyWithCompanion(MembersCompanion data) {
    return MemberRow(
      id: data.id.present ? data.id.value : this.id,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      position: data.position.present ? data.position.value : this.position,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      phone: data.phone.present ? data.phone.value : this.phone,
      addressOrWorkplace: data.addressOrWorkplace.present
          ? data.addressOrWorkplace.value
          : this.addressOrWorkplace,
      nidOrPassport: data.nidOrPassport.present
          ? data.nidOrPassport.value
          : this.nidOrPassport,
      emergencyContactName: data.emergencyContactName.present
          ? data.emergencyContactName.value
          : this.emergencyContactName,
      emergencyContactPhone: data.emergencyContactPhone.present
          ? data.emergencyContactPhone.value
          : this.emergencyContactPhone,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberRow(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('position: $position, ')
          ..write('displayName: $displayName, ')
          ..write('phone: $phone, ')
          ..write('addressOrWorkplace: $addressOrWorkplace, ')
          ..write('nidOrPassport: $nidOrPassport, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shomitiId,
    position,
    displayName,
    phone,
    addressOrWorkplace,
    nidOrPassport,
    emergencyContactName,
    emergencyContactPhone,
    notes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberRow &&
          other.id == this.id &&
          other.shomitiId == this.shomitiId &&
          other.position == this.position &&
          other.displayName == this.displayName &&
          other.phone == this.phone &&
          other.addressOrWorkplace == this.addressOrWorkplace &&
          other.nidOrPassport == this.nidOrPassport &&
          other.emergencyContactName == this.emergencyContactName &&
          other.emergencyContactPhone == this.emergencyContactPhone &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MembersCompanion extends UpdateCompanion<MemberRow> {
  final Value<String> id;
  final Value<String> shomitiId;
  final Value<int> position;
  final Value<String> displayName;
  final Value<String?> phone;
  final Value<String?> addressOrWorkplace;
  final Value<String?> nidOrPassport;
  final Value<String?> emergencyContactName;
  final Value<String?> emergencyContactPhone;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.position = const Value.absent(),
    this.displayName = const Value.absent(),
    this.phone = const Value.absent(),
    this.addressOrWorkplace = const Value.absent(),
    this.nidOrPassport = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String shomitiId,
    required int position,
    required String displayName,
    this.phone = const Value.absent(),
    this.addressOrWorkplace = const Value.absent(),
    this.nidOrPassport = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shomitiId = Value(shomitiId),
       position = Value(position),
       displayName = Value(displayName),
       createdAt = Value(createdAt);
  static Insertable<MemberRow> custom({
    Expression<String>? id,
    Expression<String>? shomitiId,
    Expression<int>? position,
    Expression<String>? displayName,
    Expression<String>? phone,
    Expression<String>? addressOrWorkplace,
    Expression<String>? nidOrPassport,
    Expression<String>? emergencyContactName,
    Expression<String>? emergencyContactPhone,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (position != null) 'position': position,
      if (displayName != null) 'display_name': displayName,
      if (phone != null) 'phone': phone,
      if (addressOrWorkplace != null)
        'address_or_workplace': addressOrWorkplace,
      if (nidOrPassport != null) 'nid_or_passport': nidOrPassport,
      if (emergencyContactName != null)
        'emergency_contact_name': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergency_contact_phone': emergencyContactPhone,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? shomitiId,
    Value<int>? position,
    Value<String>? displayName,
    Value<String?>? phone,
    Value<String?>? addressOrWorkplace,
    Value<String?>? nidOrPassport,
    Value<String?>? emergencyContactName,
    Value<String?>? emergencyContactPhone,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      shomitiId: shomitiId ?? this.shomitiId,
      position: position ?? this.position,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      addressOrWorkplace: addressOrWorkplace ?? this.addressOrWorkplace,
      nidOrPassport: nidOrPassport ?? this.nidOrPassport,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (addressOrWorkplace.present) {
      map['address_or_workplace'] = Variable<String>(addressOrWorkplace.value);
    }
    if (nidOrPassport.present) {
      map['nid_or_passport'] = Variable<String>(nidOrPassport.value);
    }
    if (emergencyContactName.present) {
      map['emergency_contact_name'] = Variable<String>(
        emergencyContactName.value,
      );
    }
    if (emergencyContactPhone.present) {
      map['emergency_contact_phone'] = Variable<String>(
        emergencyContactPhone.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('position: $position, ')
          ..write('displayName: $displayName, ')
          ..write('phone: $phone, ')
          ..write('addressOrWorkplace: $addressOrWorkplace, ')
          ..write('nidOrPassport: $nidOrPassport, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoleAssignmentsTable extends RoleAssignments
    with TableInfo<$RoleAssignmentsTable, RoleAssignmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoleAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _shomitiIdMeta = const VerificationMeta(
    'shomitiId',
  );
  @override
  late final GeneratedColumn<String> shomitiId = GeneratedColumn<String>(
    'shomiti_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shomitis (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _assignedAtMeta = const VerificationMeta(
    'assignedAt',
  );
  @override
  late final GeneratedColumn<DateTime> assignedAt = GeneratedColumn<DateTime>(
    'assigned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [shomitiId, role, memberId, assignedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'role_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoleAssignmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shomiti_id')) {
      context.handle(
        _shomitiIdMeta,
        shomitiId.isAcceptableOrUnknown(data['shomiti_id']!, _shomitiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shomitiIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('assigned_at')) {
      context.handle(
        _assignedAtMeta,
        assignedAt.isAcceptableOrUnknown(data['assigned_at']!, _assignedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, role};
  @override
  RoleAssignmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoleAssignmentRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      assignedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assigned_at'],
      )!,
    );
  }

  @override
  $RoleAssignmentsTable createAlias(String alias) {
    return $RoleAssignmentsTable(attachedDatabase, alias);
  }
}

class RoleAssignmentRow extends DataClass
    implements Insertable<RoleAssignmentRow> {
  final String shomitiId;

  /// Stored as the enum name for forward compatibility.
  final String role;
  final String memberId;
  final DateTime assignedAt;
  const RoleAssignmentRow({
    required this.shomitiId,
    required this.role,
    required this.memberId,
    required this.assignedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['role'] = Variable<String>(role);
    map['member_id'] = Variable<String>(memberId);
    map['assigned_at'] = Variable<DateTime>(assignedAt);
    return map;
  }

  RoleAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return RoleAssignmentsCompanion(
      shomitiId: Value(shomitiId),
      role: Value(role),
      memberId: Value(memberId),
      assignedAt: Value(assignedAt),
    );
  }

  factory RoleAssignmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoleAssignmentRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      role: serializer.fromJson<String>(json['role']),
      memberId: serializer.fromJson<String>(json['memberId']),
      assignedAt: serializer.fromJson<DateTime>(json['assignedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'role': serializer.toJson<String>(role),
      'memberId': serializer.toJson<String>(memberId),
      'assignedAt': serializer.toJson<DateTime>(assignedAt),
    };
  }

  RoleAssignmentRow copyWith({
    String? shomitiId,
    String? role,
    String? memberId,
    DateTime? assignedAt,
  }) => RoleAssignmentRow(
    shomitiId: shomitiId ?? this.shomitiId,
    role: role ?? this.role,
    memberId: memberId ?? this.memberId,
    assignedAt: assignedAt ?? this.assignedAt,
  );
  RoleAssignmentRow copyWithCompanion(RoleAssignmentsCompanion data) {
    return RoleAssignmentRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      role: data.role.present ? data.role.value : this.role,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      assignedAt: data.assignedAt.present
          ? data.assignedAt.value
          : this.assignedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoleAssignmentRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('role: $role, ')
          ..write('memberId: $memberId, ')
          ..write('assignedAt: $assignedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(shomitiId, role, memberId, assignedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoleAssignmentRow &&
          other.shomitiId == this.shomitiId &&
          other.role == this.role &&
          other.memberId == this.memberId &&
          other.assignedAt == this.assignedAt);
}

class RoleAssignmentsCompanion extends UpdateCompanion<RoleAssignmentRow> {
  final Value<String> shomitiId;
  final Value<String> role;
  final Value<String> memberId;
  final Value<DateTime> assignedAt;
  final Value<int> rowid;
  const RoleAssignmentsCompanion({
    this.shomitiId = const Value.absent(),
    this.role = const Value.absent(),
    this.memberId = const Value.absent(),
    this.assignedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoleAssignmentsCompanion.insert({
    required String shomitiId,
    required String role,
    required String memberId,
    required DateTime assignedAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       role = Value(role),
       memberId = Value(memberId),
       assignedAt = Value(assignedAt);
  static Insertable<RoleAssignmentRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? role,
    Expression<String>? memberId,
    Expression<DateTime>? assignedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (role != null) 'role': role,
      if (memberId != null) 'member_id': memberId,
      if (assignedAt != null) 'assigned_at': assignedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoleAssignmentsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? role,
    Value<String>? memberId,
    Value<DateTime>? assignedAt,
    Value<int>? rowid,
  }) {
    return RoleAssignmentsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      role: role ?? this.role,
      memberId: memberId ?? this.memberId,
      assignedAt: assignedAt ?? this.assignedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (assignedAt.present) {
      map['assigned_at'] = Variable<DateTime>(assignedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoleAssignmentsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('role: $role, ')
          ..write('memberId: $memberId, ')
          ..write('assignedAt: $assignedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RuleSetVersionsTable extends RuleSetVersions
    with TableInfo<$RuleSetVersionsTable, RuleSetVersionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleSetVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, json];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_set_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RuleSetVersionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleSetVersionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleSetVersionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      json: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json'],
      )!,
    );
  }

  @override
  $RuleSetVersionsTable createAlias(String alias) {
    return $RuleSetVersionsTable(attachedDatabase, alias);
  }
}

class RuleSetVersionRow extends DataClass
    implements Insertable<RuleSetVersionRow> {
  final String id;
  final DateTime createdAt;

  /// JSON snapshot of rules/policies (placeholder until TS-101+).
  final String json;
  const RuleSetVersionRow({
    required this.id,
    required this.createdAt,
    required this.json,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['json'] = Variable<String>(json);
    return map;
  }

  RuleSetVersionsCompanion toCompanion(bool nullToAbsent) {
    return RuleSetVersionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      json: Value(json),
    );
  }

  factory RuleSetVersionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleSetVersionRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      json: serializer.fromJson<String>(json['json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'json': serializer.toJson<String>(json),
    };
  }

  RuleSetVersionRow copyWith({String? id, DateTime? createdAt, String? json}) =>
      RuleSetVersionRow(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        json: json ?? this.json,
      );
  RuleSetVersionRow copyWithCompanion(RuleSetVersionsCompanion data) {
    return RuleSetVersionRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      json: data.json.present ? data.json.value : this.json,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleSetVersionRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('json: $json')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, json);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleSetVersionRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.json == this.json);
}

class RuleSetVersionsCompanion extends UpdateCompanion<RuleSetVersionRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> json;
  final Value<int> rowid;
  const RuleSetVersionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.json = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RuleSetVersionsCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String json,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       json = Value(json);
  static Insertable<RuleSetVersionRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? json,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (json != null) 'json': json,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RuleSetVersionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? json,
    Value<int>? rowid,
  }) {
    return RuleSetVersionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      json: json ?? this.json,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleSetVersionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('json: $json, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MemberConsentsTable extends MemberConsents
    with TableInfo<$MemberConsentsTable, MemberConsentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemberConsentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _ruleSetVersionIdMeta = const VerificationMeta(
    'ruleSetVersionId',
  );
  @override
  late final GeneratedColumn<String> ruleSetVersionId = GeneratedColumn<String>(
    'rule_set_version_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rule_set_versions (id)',
    ),
  );
  static const VerificationMeta _shomitiIdMeta = const VerificationMeta(
    'shomitiId',
  );
  @override
  late final GeneratedColumn<String> shomitiId = GeneratedColumn<String>(
    'shomiti_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shomitis (id)',
    ),
  );
  static const VerificationMeta _proofTypeMeta = const VerificationMeta(
    'proofType',
  );
  @override
  late final GeneratedColumn<String> proofType = GeneratedColumn<String>(
    'proof_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proofReferenceMeta = const VerificationMeta(
    'proofReference',
  );
  @override
  late final GeneratedColumn<String> proofReference = GeneratedColumn<String>(
    'proof_reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _signedAtMeta = const VerificationMeta(
    'signedAt',
  );
  @override
  late final GeneratedColumn<DateTime> signedAt = GeneratedColumn<DateTime>(
    'signed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    memberId,
    ruleSetVersionId,
    shomitiId,
    proofType,
    proofReference,
    signedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'member_consents';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberConsentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('rule_set_version_id')) {
      context.handle(
        _ruleSetVersionIdMeta,
        ruleSetVersionId.isAcceptableOrUnknown(
          data['rule_set_version_id']!,
          _ruleSetVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ruleSetVersionIdMeta);
    }
    if (data.containsKey('shomiti_id')) {
      context.handle(
        _shomitiIdMeta,
        shomitiId.isAcceptableOrUnknown(data['shomiti_id']!, _shomitiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shomitiIdMeta);
    }
    if (data.containsKey('proof_type')) {
      context.handle(
        _proofTypeMeta,
        proofType.isAcceptableOrUnknown(data['proof_type']!, _proofTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_proofTypeMeta);
    }
    if (data.containsKey('proof_reference')) {
      context.handle(
        _proofReferenceMeta,
        proofReference.isAcceptableOrUnknown(
          data['proof_reference']!,
          _proofReferenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proofReferenceMeta);
    }
    if (data.containsKey('signed_at')) {
      context.handle(
        _signedAtMeta,
        signedAt.isAcceptableOrUnknown(data['signed_at']!, _signedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_signedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {memberId, ruleSetVersionId};
  @override
  MemberConsentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberConsentRow(
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      proofType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_type'],
      )!,
      proofReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_reference'],
      )!,
      signedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}signed_at'],
      )!,
    );
  }

  @override
  $MemberConsentsTable createAlias(String alias) {
    return $MemberConsentsTable(attachedDatabase, alias);
  }
}

class MemberConsentRow extends DataClass
    implements Insertable<MemberConsentRow> {
  final String memberId;
  final String ruleSetVersionId;
  final String shomitiId;

  /// Stored as the enum name for forward compatibility.
  final String proofType;

  /// Free-text proof reference (avoid storing sensitive content).
  final String proofReference;
  final DateTime signedAt;
  const MemberConsentRow({
    required this.memberId,
    required this.ruleSetVersionId,
    required this.shomitiId,
    required this.proofType,
    required this.proofReference,
    required this.signedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['member_id'] = Variable<String>(memberId);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['proof_type'] = Variable<String>(proofType);
    map['proof_reference'] = Variable<String>(proofReference);
    map['signed_at'] = Variable<DateTime>(signedAt);
    return map;
  }

  MemberConsentsCompanion toCompanion(bool nullToAbsent) {
    return MemberConsentsCompanion(
      memberId: Value(memberId),
      ruleSetVersionId: Value(ruleSetVersionId),
      shomitiId: Value(shomitiId),
      proofType: Value(proofType),
      proofReference: Value(proofReference),
      signedAt: Value(signedAt),
    );
  }

  factory MemberConsentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberConsentRow(
      memberId: serializer.fromJson<String>(json['memberId']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      proofType: serializer.fromJson<String>(json['proofType']),
      proofReference: serializer.fromJson<String>(json['proofReference']),
      signedAt: serializer.fromJson<DateTime>(json['signedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'memberId': serializer.toJson<String>(memberId),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'proofType': serializer.toJson<String>(proofType),
      'proofReference': serializer.toJson<String>(proofReference),
      'signedAt': serializer.toJson<DateTime>(signedAt),
    };
  }

  MemberConsentRow copyWith({
    String? memberId,
    String? ruleSetVersionId,
    String? shomitiId,
    String? proofType,
    String? proofReference,
    DateTime? signedAt,
  }) => MemberConsentRow(
    memberId: memberId ?? this.memberId,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    shomitiId: shomitiId ?? this.shomitiId,
    proofType: proofType ?? this.proofType,
    proofReference: proofReference ?? this.proofReference,
    signedAt: signedAt ?? this.signedAt,
  );
  MemberConsentRow copyWithCompanion(MemberConsentsCompanion data) {
    return MemberConsentRow(
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      proofType: data.proofType.present ? data.proofType.value : this.proofType,
      proofReference: data.proofReference.present
          ? data.proofReference.value
          : this.proofReference,
      signedAt: data.signedAt.present ? data.signedAt.value : this.signedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberConsentRow(')
          ..write('memberId: $memberId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('proofType: $proofType, ')
          ..write('proofReference: $proofReference, ')
          ..write('signedAt: $signedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    memberId,
    ruleSetVersionId,
    shomitiId,
    proofType,
    proofReference,
    signedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberConsentRow &&
          other.memberId == this.memberId &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.shomitiId == this.shomitiId &&
          other.proofType == this.proofType &&
          other.proofReference == this.proofReference &&
          other.signedAt == this.signedAt);
}

class MemberConsentsCompanion extends UpdateCompanion<MemberConsentRow> {
  final Value<String> memberId;
  final Value<String> ruleSetVersionId;
  final Value<String> shomitiId;
  final Value<String> proofType;
  final Value<String> proofReference;
  final Value<DateTime> signedAt;
  final Value<int> rowid;
  const MemberConsentsCompanion({
    this.memberId = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.proofType = const Value.absent(),
    this.proofReference = const Value.absent(),
    this.signedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemberConsentsCompanion.insert({
    required String memberId,
    required String ruleSetVersionId,
    required String shomitiId,
    required String proofType,
    required String proofReference,
    required DateTime signedAt,
    this.rowid = const Value.absent(),
  }) : memberId = Value(memberId),
       ruleSetVersionId = Value(ruleSetVersionId),
       shomitiId = Value(shomitiId),
       proofType = Value(proofType),
       proofReference = Value(proofReference),
       signedAt = Value(signedAt);
  static Insertable<MemberConsentRow> custom({
    Expression<String>? memberId,
    Expression<String>? ruleSetVersionId,
    Expression<String>? shomitiId,
    Expression<String>? proofType,
    Expression<String>? proofReference,
    Expression<DateTime>? signedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (memberId != null) 'member_id': memberId,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (proofType != null) 'proof_type': proofType,
      if (proofReference != null) 'proof_reference': proofReference,
      if (signedAt != null) 'signed_at': signedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemberConsentsCompanion copyWith({
    Value<String>? memberId,
    Value<String>? ruleSetVersionId,
    Value<String>? shomitiId,
    Value<String>? proofType,
    Value<String>? proofReference,
    Value<DateTime>? signedAt,
    Value<int>? rowid,
  }) {
    return MemberConsentsCompanion(
      memberId: memberId ?? this.memberId,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      shomitiId: shomitiId ?? this.shomitiId,
      proofType: proofType ?? this.proofType,
      proofReference: proofReference ?? this.proofReference,
      signedAt: signedAt ?? this.signedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (proofType.present) {
      map['proof_type'] = Variable<String>(proofType.value);
    }
    if (proofReference.present) {
      map['proof_reference'] = Variable<String>(proofReference.value);
    }
    if (signedAt.present) {
      map['signed_at'] = Variable<DateTime>(signedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemberConsentsCompanion(')
          ..write('memberId: $memberId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('proofType: $proofType, ')
          ..write('proofReference: $proofReference, ')
          ..write('signedAt: $signedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AuditEventsTable auditEvents = $AuditEventsTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final $ShomitisTable shomitis = $ShomitisTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $RoleAssignmentsTable roleAssignments = $RoleAssignmentsTable(
    this,
  );
  late final $RuleSetVersionsTable ruleSetVersions = $RuleSetVersionsTable(
    this,
  );
  late final $MemberConsentsTable memberConsents = $MemberConsentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    auditEvents,
    ledgerEntries,
    shomitis,
    members,
    roleAssignments,
    ruleSetVersions,
    memberConsents,
  ];
}

typedef $$AuditEventsTableCreateCompanionBuilder =
    AuditEventsCompanion Function({
      Value<int> id,
      required String action,
      Value<String?> message,
      Value<String?> actor,
      required DateTime occurredAt,
      Value<String?> metadataJson,
    });
typedef $$AuditEventsTableUpdateCompanionBuilder =
    AuditEventsCompanion Function({
      Value<int> id,
      Value<String> action,
      Value<String?> message,
      Value<String?> actor,
      Value<DateTime> occurredAt,
      Value<String?> metadataJson,
    });

class $$AuditEventsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditEventsTable> {
  $$AuditEventsTableFilterComposer({
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

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditEventsTable> {
  $$AuditEventsTableOrderingComposer({
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

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actor => $composableBuilder(
    column: $table.actor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditEventsTable> {
  $$AuditEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get actor =>
      $composableBuilder(column: $table.actor, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );
}

class $$AuditEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditEventsTable,
          AuditEventRow,
          $$AuditEventsTableFilterComposer,
          $$AuditEventsTableOrderingComposer,
          $$AuditEventsTableAnnotationComposer,
          $$AuditEventsTableCreateCompanionBuilder,
          $$AuditEventsTableUpdateCompanionBuilder,
          (
            AuditEventRow,
            BaseReferences<_$AppDatabase, $AuditEventsTable, AuditEventRow>,
          ),
          AuditEventRow,
          PrefetchHooks Function()
        > {
  $$AuditEventsTableTableManager(_$AppDatabase db, $AuditEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<String?> actor = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
              }) => AuditEventsCompanion(
                id: id,
                action: action,
                message: message,
                actor: actor,
                occurredAt: occurredAt,
                metadataJson: metadataJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                Value<String?> message = const Value.absent(),
                Value<String?> actor = const Value.absent(),
                required DateTime occurredAt,
                Value<String?> metadataJson = const Value.absent(),
              }) => AuditEventsCompanion.insert(
                id: id,
                action: action,
                message: message,
                actor: actor,
                occurredAt: occurredAt,
                metadataJson: metadataJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditEventsTable,
      AuditEventRow,
      $$AuditEventsTableFilterComposer,
      $$AuditEventsTableOrderingComposer,
      $$AuditEventsTableAnnotationComposer,
      $$AuditEventsTableCreateCompanionBuilder,
      $$AuditEventsTableUpdateCompanionBuilder,
      (
        AuditEventRow,
        BaseReferences<_$AppDatabase, $AuditEventsTable, AuditEventRow>,
      ),
      AuditEventRow,
      PrefetchHooks Function()
    >;
typedef $$LedgerEntriesTableCreateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<int> id,
      required int amountMinor,
      required String direction,
      Value<String?> category,
      Value<String?> note,
      required DateTime occurredAt,
    });
typedef $$LedgerEntriesTableUpdateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<int> id,
      Value<int> amountMinor,
      Value<String> direction,
      Value<String?> category,
      Value<String?> note,
      Value<DateTime> occurredAt,
    });

class $$LedgerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableFilterComposer({
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

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LedgerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );
}

class $$LedgerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LedgerEntriesTable,
          LedgerEntryRow,
          $$LedgerEntriesTableFilterComposer,
          $$LedgerEntriesTableOrderingComposer,
          $$LedgerEntriesTableAnnotationComposer,
          $$LedgerEntriesTableCreateCompanionBuilder,
          $$LedgerEntriesTableUpdateCompanionBuilder,
          (
            LedgerEntryRow,
            BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerEntryRow>,
          ),
          LedgerEntryRow,
          PrefetchHooks Function()
        > {
  $$LedgerEntriesTableTableManager(_$AppDatabase db, $LedgerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
              }) => LedgerEntriesCompanion(
                id: id,
                amountMinor: amountMinor,
                direction: direction,
                category: category,
                note: note,
                occurredAt: occurredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int amountMinor,
                required String direction,
                Value<String?> category = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime occurredAt,
              }) => LedgerEntriesCompanion.insert(
                id: id,
                amountMinor: amountMinor,
                direction: direction,
                category: category,
                note: note,
                occurredAt: occurredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LedgerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LedgerEntriesTable,
      LedgerEntryRow,
      $$LedgerEntriesTableFilterComposer,
      $$LedgerEntriesTableOrderingComposer,
      $$LedgerEntriesTableAnnotationComposer,
      $$LedgerEntriesTableCreateCompanionBuilder,
      $$LedgerEntriesTableUpdateCompanionBuilder,
      (
        LedgerEntryRow,
        BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerEntryRow>,
      ),
      LedgerEntryRow,
      PrefetchHooks Function()
    >;
typedef $$ShomitisTableCreateCompanionBuilder =
    ShomitisCompanion Function({
      required String id,
      required String name,
      required DateTime startDate,
      required DateTime createdAt,
      required String activeRuleSetVersionId,
      Value<int> rowid,
    });
typedef $$ShomitisTableUpdateCompanionBuilder =
    ShomitisCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> startDate,
      Value<DateTime> createdAt,
      Value<String> activeRuleSetVersionId,
      Value<int> rowid,
    });

final class $$ShomitisTableReferences
    extends BaseReferences<_$AppDatabase, $ShomitisTable, ShomitiRow> {
  $$ShomitisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MembersTable, List<MemberRow>> _membersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.members,
    aliasName: $_aliasNameGenerator(db.shomitis.id, db.members.shomitiId),
  );

  $$MembersTableProcessedTableManager get membersRefs {
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_membersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoleAssignmentsTable, List<RoleAssignmentRow>>
  _roleAssignmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roleAssignments,
    aliasName: $_aliasNameGenerator(
      db.shomitis.id,
      db.roleAssignments.shomitiId,
    ),
  );

  $$RoleAssignmentsTableProcessedTableManager get roleAssignmentsRefs {
    final manager = $$RoleAssignmentsTableTableManager(
      $_db,
      $_db.roleAssignments,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _roleAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MemberConsentsTable, List<MemberConsentRow>>
  _memberConsentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.memberConsents,
    aliasName: $_aliasNameGenerator(
      db.shomitis.id,
      db.memberConsents.shomitiId,
    ),
  );

  $$MemberConsentsTableProcessedTableManager get memberConsentsRefs {
    final manager = $$MemberConsentsTableTableManager(
      $_db,
      $_db.memberConsents,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_memberConsentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShomitisTableFilterComposer
    extends Composer<_$AppDatabase, $ShomitisTable> {
  $$ShomitisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeRuleSetVersionId => $composableBuilder(
    column: $table.activeRuleSetVersionId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> membersRefs(
    Expression<bool> Function($$MembersTableFilterComposer f) f,
  ) {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roleAssignmentsRefs(
    Expression<bool> Function($$RoleAssignmentsTableFilterComposer f) f,
  ) {
    final $$RoleAssignmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roleAssignments,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoleAssignmentsTableFilterComposer(
            $db: $db,
            $table: $db.roleAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> memberConsentsRefs(
    Expression<bool> Function($$MemberConsentsTableFilterComposer f) f,
  ) {
    final $$MemberConsentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberConsents,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberConsentsTableFilterComposer(
            $db: $db,
            $table: $db.memberConsents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShomitisTableOrderingComposer
    extends Composer<_$AppDatabase, $ShomitisTable> {
  $$ShomitisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeRuleSetVersionId => $composableBuilder(
    column: $table.activeRuleSetVersionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShomitisTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShomitisTable> {
  $$ShomitisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get activeRuleSetVersionId => $composableBuilder(
    column: $table.activeRuleSetVersionId,
    builder: (column) => column,
  );

  Expression<T> membersRefs<T extends Object>(
    Expression<T> Function($$MembersTableAnnotationComposer a) f,
  ) {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roleAssignmentsRefs<T extends Object>(
    Expression<T> Function($$RoleAssignmentsTableAnnotationComposer a) f,
  ) {
    final $$RoleAssignmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roleAssignments,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoleAssignmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.roleAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> memberConsentsRefs<T extends Object>(
    Expression<T> Function($$MemberConsentsTableAnnotationComposer a) f,
  ) {
    final $$MemberConsentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberConsents,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberConsentsTableAnnotationComposer(
            $db: $db,
            $table: $db.memberConsents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShomitisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShomitisTable,
          ShomitiRow,
          $$ShomitisTableFilterComposer,
          $$ShomitisTableOrderingComposer,
          $$ShomitisTableAnnotationComposer,
          $$ShomitisTableCreateCompanionBuilder,
          $$ShomitisTableUpdateCompanionBuilder,
          (ShomitiRow, $$ShomitisTableReferences),
          ShomitiRow,
          PrefetchHooks Function({
            bool membersRefs,
            bool roleAssignmentsRefs,
            bool memberConsentsRefs,
          })
        > {
  $$ShomitisTableTableManager(_$AppDatabase db, $ShomitisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShomitisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShomitisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShomitisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> activeRuleSetVersionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShomitisCompanion(
                id: id,
                name: name,
                startDate: startDate,
                createdAt: createdAt,
                activeRuleSetVersionId: activeRuleSetVersionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required DateTime startDate,
                required DateTime createdAt,
                required String activeRuleSetVersionId,
                Value<int> rowid = const Value.absent(),
              }) => ShomitisCompanion.insert(
                id: id,
                name: name,
                startDate: startDate,
                createdAt: createdAt,
                activeRuleSetVersionId: activeRuleSetVersionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShomitisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                membersRefs = false,
                roleAssignmentsRefs = false,
                memberConsentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (membersRefs) db.members,
                    if (roleAssignmentsRefs) db.roleAssignments,
                    if (memberConsentsRefs) db.memberConsents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (membersRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          MemberRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._membersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).membersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (roleAssignmentsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          RoleAssignmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._roleAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).roleAssignmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (memberConsentsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          MemberConsentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._memberConsentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).memberConsentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
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

typedef $$ShomitisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShomitisTable,
      ShomitiRow,
      $$ShomitisTableFilterComposer,
      $$ShomitisTableOrderingComposer,
      $$ShomitisTableAnnotationComposer,
      $$ShomitisTableCreateCompanionBuilder,
      $$ShomitisTableUpdateCompanionBuilder,
      (ShomitiRow, $$ShomitisTableReferences),
      ShomitiRow,
      PrefetchHooks Function({
        bool membersRefs,
        bool roleAssignmentsRefs,
        bool memberConsentsRefs,
      })
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      required String id,
      required String shomitiId,
      required int position,
      required String displayName,
      Value<String?> phone,
      Value<String?> addressOrWorkplace,
      Value<String?> nidOrPassport,
      Value<String?> emergencyContactName,
      Value<String?> emergencyContactPhone,
      Value<String?> notes,
      Value<bool> isActive,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<String> id,
      Value<String> shomitiId,
      Value<int> position,
      Value<String> displayName,
      Value<String?> phone,
      Value<String?> addressOrWorkplace,
      Value<String?> nidOrPassport,
      Value<String?> emergencyContactName,
      Value<String?> emergencyContactPhone,
      Value<String?> notes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$MembersTableReferences
    extends BaseReferences<_$AppDatabase, $MembersTable, MemberRow> {
  $$MembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) => db.shomitis
      .createAlias($_aliasNameGenerator(db.members.shomitiId, db.shomitis.id));

  $$ShomitisTableProcessedTableManager get shomitiId {
    final $_column = $_itemColumn<String>('shomiti_id')!;

    final manager = $$ShomitisTableTableManager(
      $_db,
      $_db.shomitis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shomitiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoleAssignmentsTable, List<RoleAssignmentRow>>
  _roleAssignmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roleAssignments,
    aliasName: $_aliasNameGenerator(db.members.id, db.roleAssignments.memberId),
  );

  $$RoleAssignmentsTableProcessedTableManager get roleAssignmentsRefs {
    final manager = $$RoleAssignmentsTableTableManager(
      $_db,
      $_db.roleAssignments,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _roleAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MemberConsentsTable, List<MemberConsentRow>>
  _memberConsentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.memberConsents,
    aliasName: $_aliasNameGenerator(db.members.id, db.memberConsents.memberId),
  );

  $$MemberConsentsTableProcessedTableManager get memberConsentsRefs {
    final manager = $$MemberConsentsTableTableManager(
      $_db,
      $_db.memberConsents,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_memberConsentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressOrWorkplace => $composableBuilder(
    column: $table.addressOrWorkplace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nidOrPassport => $composableBuilder(
    column: $table.nidOrPassport,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShomitisTableFilterComposer get shomitiId {
    final $$ShomitisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableFilterComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> roleAssignmentsRefs(
    Expression<bool> Function($$RoleAssignmentsTableFilterComposer f) f,
  ) {
    final $$RoleAssignmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roleAssignments,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoleAssignmentsTableFilterComposer(
            $db: $db,
            $table: $db.roleAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> memberConsentsRefs(
    Expression<bool> Function($$MemberConsentsTableFilterComposer f) f,
  ) {
    final $$MemberConsentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberConsents,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberConsentsTableFilterComposer(
            $db: $db,
            $table: $db.memberConsents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressOrWorkplace => $composableBuilder(
    column: $table.addressOrWorkplace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nidOrPassport => $composableBuilder(
    column: $table.nidOrPassport,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShomitisTableOrderingComposer get shomitiId {
    final $$ShomitisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableOrderingComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get addressOrWorkplace => $composableBuilder(
    column: $table.addressOrWorkplace,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nidOrPassport => $composableBuilder(
    column: $table.nidOrPassport,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ShomitisTableAnnotationComposer get shomitiId {
    final $$ShomitisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableAnnotationComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> roleAssignmentsRefs<T extends Object>(
    Expression<T> Function($$RoleAssignmentsTableAnnotationComposer a) f,
  ) {
    final $$RoleAssignmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roleAssignments,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoleAssignmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.roleAssignments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> memberConsentsRefs<T extends Object>(
    Expression<T> Function($$MemberConsentsTableAnnotationComposer a) f,
  ) {
    final $$MemberConsentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberConsents,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberConsentsTableAnnotationComposer(
            $db: $db,
            $table: $db.memberConsents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          MemberRow,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (MemberRow, $$MembersTableReferences),
          MemberRow,
          PrefetchHooks Function({
            bool shomitiId,
            bool roleAssignmentsRefs,
            bool memberConsentsRefs,
          })
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> addressOrWorkplace = const Value.absent(),
                Value<String?> nidOrPassport = const Value.absent(),
                Value<String?> emergencyContactName = const Value.absent(),
                Value<String?> emergencyContactPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                shomitiId: shomitiId,
                position: position,
                displayName: displayName,
                phone: phone,
                addressOrWorkplace: addressOrWorkplace,
                nidOrPassport: nidOrPassport,
                emergencyContactName: emergencyContactName,
                emergencyContactPhone: emergencyContactPhone,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shomitiId,
                required int position,
                required String displayName,
                Value<String?> phone = const Value.absent(),
                Value<String?> addressOrWorkplace = const Value.absent(),
                Value<String?> nidOrPassport = const Value.absent(),
                Value<String?> emergencyContactName = const Value.absent(),
                Value<String?> emergencyContactPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                shomitiId: shomitiId,
                position: position,
                displayName: displayName,
                phone: phone,
                addressOrWorkplace: addressOrWorkplace,
                nidOrPassport: nidOrPassport,
                emergencyContactName: emergencyContactName,
                emergencyContactPhone: emergencyContactPhone,
                notes: notes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shomitiId = false,
                roleAssignmentsRefs = false,
                memberConsentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roleAssignmentsRefs) db.roleAssignments,
                    if (memberConsentsRefs) db.memberConsents,
                  ],
                  addJoins:
                      <
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
                        if (shomitiId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shomitiId,
                                    referencedTable: $$MembersTableReferences
                                        ._shomitiIdTable(db),
                                    referencedColumn: $$MembersTableReferences
                                        ._shomitiIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roleAssignmentsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          RoleAssignmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._roleAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).roleAssignmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (memberConsentsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          MemberConsentRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._memberConsentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).memberConsentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
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

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      MemberRow,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (MemberRow, $$MembersTableReferences),
      MemberRow,
      PrefetchHooks Function({
        bool shomitiId,
        bool roleAssignmentsRefs,
        bool memberConsentsRefs,
      })
    >;
typedef $$RoleAssignmentsTableCreateCompanionBuilder =
    RoleAssignmentsCompanion Function({
      required String shomitiId,
      required String role,
      required String memberId,
      required DateTime assignedAt,
      Value<int> rowid,
    });
typedef $$RoleAssignmentsTableUpdateCompanionBuilder =
    RoleAssignmentsCompanion Function({
      Value<String> shomitiId,
      Value<String> role,
      Value<String> memberId,
      Value<DateTime> assignedAt,
      Value<int> rowid,
    });

final class $$RoleAssignmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RoleAssignmentsTable,
          RoleAssignmentRow
        > {
  $$RoleAssignmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.roleAssignments.shomitiId, db.shomitis.id),
      );

  $$ShomitisTableProcessedTableManager get shomitiId {
    final $_column = $_itemColumn<String>('shomiti_id')!;

    final manager = $$ShomitisTableTableManager(
      $_db,
      $_db.shomitis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shomitiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(db.roleAssignments.memberId, db.members.id),
      );

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoleAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $RoleAssignmentsTable> {
  $$RoleAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ShomitisTableFilterComposer get shomitiId {
    final $$ShomitisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableFilterComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoleAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoleAssignmentsTable> {
  $$RoleAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShomitisTableOrderingComposer get shomitiId {
    final $$ShomitisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableOrderingComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoleAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoleAssignmentsTable> {
  $$RoleAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => column,
  );

  $$ShomitisTableAnnotationComposer get shomitiId {
    final $$ShomitisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableAnnotationComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoleAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoleAssignmentsTable,
          RoleAssignmentRow,
          $$RoleAssignmentsTableFilterComposer,
          $$RoleAssignmentsTableOrderingComposer,
          $$RoleAssignmentsTableAnnotationComposer,
          $$RoleAssignmentsTableCreateCompanionBuilder,
          $$RoleAssignmentsTableUpdateCompanionBuilder,
          (RoleAssignmentRow, $$RoleAssignmentsTableReferences),
          RoleAssignmentRow,
          PrefetchHooks Function({bool shomitiId, bool memberId})
        > {
  $$RoleAssignmentsTableTableManager(
    _$AppDatabase db,
    $RoleAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoleAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoleAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoleAssignmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<DateTime> assignedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoleAssignmentsCompanion(
                shomitiId: shomitiId,
                role: role,
                memberId: memberId,
                assignedAt: assignedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String role,
                required String memberId,
                required DateTime assignedAt,
                Value<int> rowid = const Value.absent(),
              }) => RoleAssignmentsCompanion.insert(
                shomitiId: shomitiId,
                role: role,
                memberId: memberId,
                assignedAt: assignedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoleAssignmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shomitiId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                    if (shomitiId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shomitiId,
                                referencedTable:
                                    $$RoleAssignmentsTableReferences
                                        ._shomitiIdTable(db),
                                referencedColumn:
                                    $$RoleAssignmentsTableReferences
                                        ._shomitiIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable:
                                    $$RoleAssignmentsTableReferences
                                        ._memberIdTable(db),
                                referencedColumn:
                                    $$RoleAssignmentsTableReferences
                                        ._memberIdTable(db)
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

typedef $$RoleAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoleAssignmentsTable,
      RoleAssignmentRow,
      $$RoleAssignmentsTableFilterComposer,
      $$RoleAssignmentsTableOrderingComposer,
      $$RoleAssignmentsTableAnnotationComposer,
      $$RoleAssignmentsTableCreateCompanionBuilder,
      $$RoleAssignmentsTableUpdateCompanionBuilder,
      (RoleAssignmentRow, $$RoleAssignmentsTableReferences),
      RoleAssignmentRow,
      PrefetchHooks Function({bool shomitiId, bool memberId})
    >;
typedef $$RuleSetVersionsTableCreateCompanionBuilder =
    RuleSetVersionsCompanion Function({
      required String id,
      required DateTime createdAt,
      required String json,
      Value<int> rowid,
    });
typedef $$RuleSetVersionsTableUpdateCompanionBuilder =
    RuleSetVersionsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> json,
      Value<int> rowid,
    });

final class $$RuleSetVersionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RuleSetVersionsTable,
          RuleSetVersionRow
        > {
  $$RuleSetVersionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MemberConsentsTable, List<MemberConsentRow>>
  _memberConsentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.memberConsents,
    aliasName: $_aliasNameGenerator(
      db.ruleSetVersions.id,
      db.memberConsents.ruleSetVersionId,
    ),
  );

  $$MemberConsentsTableProcessedTableManager get memberConsentsRefs {
    final manager = $$MemberConsentsTableTableManager($_db, $_db.memberConsents)
        .filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_memberConsentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RuleSetVersionsTableFilterComposer
    extends Composer<_$AppDatabase, $RuleSetVersionsTable> {
  $$RuleSetVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> memberConsentsRefs(
    Expression<bool> Function($$MemberConsentsTableFilterComposer f) f,
  ) {
    final $$MemberConsentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberConsents,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberConsentsTableFilterComposer(
            $db: $db,
            $table: $db.memberConsents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RuleSetVersionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleSetVersionsTable> {
  $$RuleSetVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RuleSetVersionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleSetVersionsTable> {
  $$RuleSetVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);

  Expression<T> memberConsentsRefs<T extends Object>(
    Expression<T> Function($$MemberConsentsTableAnnotationComposer a) f,
  ) {
    final $$MemberConsentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.memberConsents,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MemberConsentsTableAnnotationComposer(
            $db: $db,
            $table: $db.memberConsents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RuleSetVersionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RuleSetVersionsTable,
          RuleSetVersionRow,
          $$RuleSetVersionsTableFilterComposer,
          $$RuleSetVersionsTableOrderingComposer,
          $$RuleSetVersionsTableAnnotationComposer,
          $$RuleSetVersionsTableCreateCompanionBuilder,
          $$RuleSetVersionsTableUpdateCompanionBuilder,
          (RuleSetVersionRow, $$RuleSetVersionsTableReferences),
          RuleSetVersionRow,
          PrefetchHooks Function({bool memberConsentsRefs})
        > {
  $$RuleSetVersionsTableTableManager(
    _$AppDatabase db,
    $RuleSetVersionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleSetVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleSetVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleSetVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RuleSetVersionsCompanion(
                id: id,
                createdAt: createdAt,
                json: json,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required String json,
                Value<int> rowid = const Value.absent(),
              }) => RuleSetVersionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                json: json,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RuleSetVersionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberConsentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (memberConsentsRefs) db.memberConsents,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (memberConsentsRefs)
                    await $_getPrefetchedData<
                      RuleSetVersionRow,
                      $RuleSetVersionsTable,
                      MemberConsentRow
                    >(
                      currentTable: table,
                      referencedTable: $$RuleSetVersionsTableReferences
                          ._memberConsentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RuleSetVersionsTableReferences(
                            db,
                            table,
                            p0,
                          ).memberConsentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.ruleSetVersionId == item.id,
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

typedef $$RuleSetVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RuleSetVersionsTable,
      RuleSetVersionRow,
      $$RuleSetVersionsTableFilterComposer,
      $$RuleSetVersionsTableOrderingComposer,
      $$RuleSetVersionsTableAnnotationComposer,
      $$RuleSetVersionsTableCreateCompanionBuilder,
      $$RuleSetVersionsTableUpdateCompanionBuilder,
      (RuleSetVersionRow, $$RuleSetVersionsTableReferences),
      RuleSetVersionRow,
      PrefetchHooks Function({bool memberConsentsRefs})
    >;
typedef $$MemberConsentsTableCreateCompanionBuilder =
    MemberConsentsCompanion Function({
      required String memberId,
      required String ruleSetVersionId,
      required String shomitiId,
      required String proofType,
      required String proofReference,
      required DateTime signedAt,
      Value<int> rowid,
    });
typedef $$MemberConsentsTableUpdateCompanionBuilder =
    MemberConsentsCompanion Function({
      Value<String> memberId,
      Value<String> ruleSetVersionId,
      Value<String> shomitiId,
      Value<String> proofType,
      Value<String> proofReference,
      Value<DateTime> signedAt,
      Value<int> rowid,
    });

final class $$MemberConsentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MemberConsentsTable, MemberConsentRow> {
  $$MemberConsentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(db.memberConsents.memberId, db.members.id),
      );

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.memberConsents.ruleSetVersionId,
          db.ruleSetVersions.id,
        ),
      );

  $$RuleSetVersionsTableProcessedTableManager get ruleSetVersionId {
    final $_column = $_itemColumn<String>('rule_set_version_id')!;

    final manager = $$RuleSetVersionsTableTableManager(
      $_db,
      $_db.ruleSetVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ruleSetVersionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.memberConsents.shomitiId, db.shomitis.id),
      );

  $$ShomitisTableProcessedTableManager get shomitiId {
    final $_column = $_itemColumn<String>('shomiti_id')!;

    final manager = $$ShomitisTableTableManager(
      $_db,
      $_db.shomitis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shomitiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MemberConsentsTableFilterComposer
    extends Composer<_$AppDatabase, $MemberConsentsTable> {
  $$MemberConsentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get proofType => $composableBuilder(
    column: $table.proofType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get signedAt => $composableBuilder(
    column: $table.signedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RuleSetVersionsTableFilterComposer get ruleSetVersionId {
    final $$RuleSetVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleSetVersionId,
      referencedTable: $db.ruleSetVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleSetVersionsTableFilterComposer(
            $db: $db,
            $table: $db.ruleSetVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShomitisTableFilterComposer get shomitiId {
    final $$ShomitisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableFilterComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemberConsentsTableOrderingComposer
    extends Composer<_$AppDatabase, $MemberConsentsTable> {
  $$MemberConsentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get proofType => $composableBuilder(
    column: $table.proofType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get signedAt => $composableBuilder(
    column: $table.signedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RuleSetVersionsTableOrderingComposer get ruleSetVersionId {
    final $$RuleSetVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleSetVersionId,
      referencedTable: $db.ruleSetVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleSetVersionsTableOrderingComposer(
            $db: $db,
            $table: $db.ruleSetVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShomitisTableOrderingComposer get shomitiId {
    final $$ShomitisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableOrderingComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemberConsentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemberConsentsTable> {
  $$MemberConsentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get proofType =>
      $composableBuilder(column: $table.proofType, builder: (column) => column);

  GeneratedColumn<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get signedAt =>
      $composableBuilder(column: $table.signedAt, builder: (column) => column);

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RuleSetVersionsTableAnnotationComposer get ruleSetVersionId {
    final $$RuleSetVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ruleSetVersionId,
      referencedTable: $db.ruleSetVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleSetVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.ruleSetVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShomitisTableAnnotationComposer get shomitiId {
    final $$ShomitisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shomitiId,
      referencedTable: $db.shomitis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShomitisTableAnnotationComposer(
            $db: $db,
            $table: $db.shomitis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MemberConsentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemberConsentsTable,
          MemberConsentRow,
          $$MemberConsentsTableFilterComposer,
          $$MemberConsentsTableOrderingComposer,
          $$MemberConsentsTableAnnotationComposer,
          $$MemberConsentsTableCreateCompanionBuilder,
          $$MemberConsentsTableUpdateCompanionBuilder,
          (MemberConsentRow, $$MemberConsentsTableReferences),
          MemberConsentRow,
          PrefetchHooks Function({
            bool memberId,
            bool ruleSetVersionId,
            bool shomitiId,
          })
        > {
  $$MemberConsentsTableTableManager(
    _$AppDatabase db,
    $MemberConsentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemberConsentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemberConsentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemberConsentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> memberId = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<String> proofType = const Value.absent(),
                Value<String> proofReference = const Value.absent(),
                Value<DateTime> signedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemberConsentsCompanion(
                memberId: memberId,
                ruleSetVersionId: ruleSetVersionId,
                shomitiId: shomitiId,
                proofType: proofType,
                proofReference: proofReference,
                signedAt: signedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String memberId,
                required String ruleSetVersionId,
                required String shomitiId,
                required String proofType,
                required String proofReference,
                required DateTime signedAt,
                Value<int> rowid = const Value.absent(),
              }) => MemberConsentsCompanion.insert(
                memberId: memberId,
                ruleSetVersionId: ruleSetVersionId,
                shomitiId: shomitiId,
                proofType: proofType,
                proofReference: proofReference,
                signedAt: signedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MemberConsentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                memberId = false,
                ruleSetVersionId = false,
                shomitiId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                        if (memberId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.memberId,
                                    referencedTable:
                                        $$MemberConsentsTableReferences
                                            ._memberIdTable(db),
                                    referencedColumn:
                                        $$MemberConsentsTableReferences
                                            ._memberIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (ruleSetVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ruleSetVersionId,
                                    referencedTable:
                                        $$MemberConsentsTableReferences
                                            ._ruleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$MemberConsentsTableReferences
                                            ._ruleSetVersionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (shomitiId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shomitiId,
                                    referencedTable:
                                        $$MemberConsentsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$MemberConsentsTableReferences
                                            ._shomitiIdTable(db)
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

typedef $$MemberConsentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemberConsentsTable,
      MemberConsentRow,
      $$MemberConsentsTableFilterComposer,
      $$MemberConsentsTableOrderingComposer,
      $$MemberConsentsTableAnnotationComposer,
      $$MemberConsentsTableCreateCompanionBuilder,
      $$MemberConsentsTableUpdateCompanionBuilder,
      (MemberConsentRow, $$MemberConsentsTableReferences),
      MemberConsentRow,
      PrefetchHooks Function({
        bool memberId,
        bool ruleSetVersionId,
        bool shomitiId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AuditEventsTableTableManager get auditEvents =>
      $$AuditEventsTableTableManager(_db, _db.auditEvents);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
  $$ShomitisTableTableManager get shomitis =>
      $$ShomitisTableTableManager(_db, _db.shomitis);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$RoleAssignmentsTableTableManager get roleAssignments =>
      $$RoleAssignmentsTableTableManager(_db, _db.roleAssignments);
  $$RuleSetVersionsTableTableManager get ruleSetVersions =>
      $$RuleSetVersionsTableTableManager(_db, _db.ruleSetVersions);
  $$MemberConsentsTableTableManager get memberConsents =>
      $$MemberConsentsTableTableManager(_db, _db.memberConsents);
}
