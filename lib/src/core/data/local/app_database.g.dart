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

class $MemberSharesTable extends MemberShares
    with TableInfo<$MemberSharesTable, MemberShare> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemberSharesTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<int> shares = GeneratedColumn<int>(
    'shares',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
    shomitiId,
    memberId,
    shares,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'member_shares';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberShare> instance, {
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
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
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
  Set<GeneratedColumn> get $primaryKey => {shomitiId, memberId};
  @override
  MemberShare map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberShare(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shares'],
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
  $MemberSharesTable createAlias(String alias) {
    return $MemberSharesTable(attachedDatabase, alias);
  }
}

class MemberShare extends DataClass implements Insertable<MemberShare> {
  final String shomitiId;
  final String memberId;

  /// Number of shares held by the member.
  final int shares;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const MemberShare({
    required this.shomitiId,
    required this.memberId,
    required this.shares,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['member_id'] = Variable<String>(memberId);
    map['shares'] = Variable<int>(shares);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MemberSharesCompanion toCompanion(bool nullToAbsent) {
    return MemberSharesCompanion(
      shomitiId: Value(shomitiId),
      memberId: Value(memberId),
      shares: Value(shares),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory MemberShare.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberShare(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      shares: serializer.fromJson<int>(json['shares']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'memberId': serializer.toJson<String>(memberId),
      'shares': serializer.toJson<int>(shares),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  MemberShare copyWith({
    String? shomitiId,
    String? memberId,
    int? shares,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => MemberShare(
    shomitiId: shomitiId ?? this.shomitiId,
    memberId: memberId ?? this.memberId,
    shares: shares ?? this.shares,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  MemberShare copyWithCompanion(MemberSharesCompanion data) {
    return MemberShare(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      shares: data.shares.present ? data.shares.value : this.shares,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberShare(')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('shares: $shares, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(shomitiId, memberId, shares, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberShare &&
          other.shomitiId == this.shomitiId &&
          other.memberId == this.memberId &&
          other.shares == this.shares &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MemberSharesCompanion extends UpdateCompanion<MemberShare> {
  final Value<String> shomitiId;
  final Value<String> memberId;
  final Value<int> shares;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const MemberSharesCompanion({
    this.shomitiId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.shares = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemberSharesCompanion.insert({
    required String shomitiId,
    required String memberId,
    required int shares,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       memberId = Value(memberId),
       shares = Value(shares),
       createdAt = Value(createdAt);
  static Insertable<MemberShare> custom({
    Expression<String>? shomitiId,
    Expression<String>? memberId,
    Expression<int>? shares,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (memberId != null) 'member_id': memberId,
      if (shares != null) 'shares': shares,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemberSharesCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? memberId,
    Value<int>? shares,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return MemberSharesCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      memberId: memberId ?? this.memberId,
      shares: shares ?? this.shares,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (shares.present) {
      map['shares'] = Variable<int>(shares.value);
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
    return (StringBuffer('MemberSharesCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('shares: $shares, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GuarantorsTable extends Guarantors
    with TableInfo<$GuarantorsTable, GuarantorRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuarantorsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  @override
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proofRefMeta = const VerificationMeta(
    'proofRef',
  );
  @override
  late final GeneratedColumn<String> proofRef = GeneratedColumn<String>(
    'proof_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
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
    shomitiId,
    memberId,
    name,
    phone,
    relationship,
    proofRef,
    recordedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guarantors';
  @override
  VerificationContext validateIntegrity(
    Insertable<GuarantorRow> instance, {
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
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    }
    if (data.containsKey('proof_ref')) {
      context.handle(
        _proofRefMeta,
        proofRef.isAcceptableOrUnknown(data['proof_ref']!, _proofRefMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
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
  Set<GeneratedColumn> get $primaryKey => {shomitiId, memberId};
  @override
  GuarantorRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GuarantorRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      ),
      proofRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_ref'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $GuarantorsTable createAlias(String alias) {
    return $GuarantorsTable(attachedDatabase, alias);
  }
}

class GuarantorRow extends DataClass implements Insertable<GuarantorRow> {
  final String shomitiId;
  final String memberId;
  final String name;
  final String phone;
  final String? relationship;
  final String? proofRef;
  final DateTime recordedAt;
  final DateTime? updatedAt;
  const GuarantorRow({
    required this.shomitiId,
    required this.memberId,
    required this.name,
    required this.phone,
    this.relationship,
    this.proofRef,
    required this.recordedAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['member_id'] = Variable<String>(memberId);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || relationship != null) {
      map['relationship'] = Variable<String>(relationship);
    }
    if (!nullToAbsent || proofRef != null) {
      map['proof_ref'] = Variable<String>(proofRef);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  GuarantorsCompanion toCompanion(bool nullToAbsent) {
    return GuarantorsCompanion(
      shomitiId: Value(shomitiId),
      memberId: Value(memberId),
      name: Value(name),
      phone: Value(phone),
      relationship: relationship == null && nullToAbsent
          ? const Value.absent()
          : Value(relationship),
      proofRef: proofRef == null && nullToAbsent
          ? const Value.absent()
          : Value(proofRef),
      recordedAt: Value(recordedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory GuarantorRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuarantorRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      relationship: serializer.fromJson<String?>(json['relationship']),
      proofRef: serializer.fromJson<String?>(json['proofRef']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'memberId': serializer.toJson<String>(memberId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'relationship': serializer.toJson<String?>(relationship),
      'proofRef': serializer.toJson<String?>(proofRef),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  GuarantorRow copyWith({
    String? shomitiId,
    String? memberId,
    String? name,
    String? phone,
    Value<String?> relationship = const Value.absent(),
    Value<String?> proofRef = const Value.absent(),
    DateTime? recordedAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => GuarantorRow(
    shomitiId: shomitiId ?? this.shomitiId,
    memberId: memberId ?? this.memberId,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    relationship: relationship.present ? relationship.value : this.relationship,
    proofRef: proofRef.present ? proofRef.value : this.proofRef,
    recordedAt: recordedAt ?? this.recordedAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  GuarantorRow copyWithCompanion(GuarantorsCompanion data) {
    return GuarantorRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
      proofRef: data.proofRef.present ? data.proofRef.value : this.proofRef,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuarantorRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('relationship: $relationship, ')
          ..write('proofRef: $proofRef, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    memberId,
    name,
    phone,
    relationship,
    proofRef,
    recordedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuarantorRow &&
          other.shomitiId == this.shomitiId &&
          other.memberId == this.memberId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.relationship == this.relationship &&
          other.proofRef == this.proofRef &&
          other.recordedAt == this.recordedAt &&
          other.updatedAt == this.updatedAt);
}

class GuarantorsCompanion extends UpdateCompanion<GuarantorRow> {
  final Value<String> shomitiId;
  final Value<String> memberId;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> relationship;
  final Value<String?> proofRef;
  final Value<DateTime> recordedAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const GuarantorsCompanion({
    this.shomitiId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.relationship = const Value.absent(),
    this.proofRef = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GuarantorsCompanion.insert({
    required String shomitiId,
    required String memberId,
    required String name,
    required String phone,
    this.relationship = const Value.absent(),
    this.proofRef = const Value.absent(),
    required DateTime recordedAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       memberId = Value(memberId),
       name = Value(name),
       phone = Value(phone),
       recordedAt = Value(recordedAt);
  static Insertable<GuarantorRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? memberId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? relationship,
    Expression<String>? proofRef,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (memberId != null) 'member_id': memberId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (relationship != null) 'relationship': relationship,
      if (proofRef != null) 'proof_ref': proofRef,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GuarantorsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? memberId,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? relationship,
    Value<String?>? proofRef,
    Value<DateTime>? recordedAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return GuarantorsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      relationship: relationship ?? this.relationship,
      proofRef: proofRef ?? this.proofRef,
      recordedAt: recordedAt ?? this.recordedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (proofRef.present) {
      map['proof_ref'] = Variable<String>(proofRef.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
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
    return (StringBuffer('GuarantorsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('relationship: $relationship, ')
          ..write('proofRef: $proofRef, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SecurityDepositsTable extends SecurityDeposits
    with TableInfo<$SecurityDepositsTable, SecurityDepositRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SecurityDepositsTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _amountBdtMeta = const VerificationMeta(
    'amountBdt',
  );
  @override
  late final GeneratedColumn<int> amountBdt = GeneratedColumn<int>(
    'amount_bdt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heldByMeta = const VerificationMeta('heldBy');
  @override
  late final GeneratedColumn<String> heldBy = GeneratedColumn<String>(
    'held_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proofRefMeta = const VerificationMeta(
    'proofRef',
  );
  @override
  late final GeneratedColumn<String> proofRef = GeneratedColumn<String>(
    'proof_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnedAtMeta = const VerificationMeta(
    'returnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> returnedAt = GeneratedColumn<DateTime>(
    'returned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
    shomitiId,
    memberId,
    amountBdt,
    heldBy,
    proofRef,
    recordedAt,
    returnedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'security_deposits';
  @override
  VerificationContext validateIntegrity(
    Insertable<SecurityDepositRow> instance, {
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
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('amount_bdt')) {
      context.handle(
        _amountBdtMeta,
        amountBdt.isAcceptableOrUnknown(data['amount_bdt']!, _amountBdtMeta),
      );
    } else if (isInserting) {
      context.missing(_amountBdtMeta);
    }
    if (data.containsKey('held_by')) {
      context.handle(
        _heldByMeta,
        heldBy.isAcceptableOrUnknown(data['held_by']!, _heldByMeta),
      );
    } else if (isInserting) {
      context.missing(_heldByMeta);
    }
    if (data.containsKey('proof_ref')) {
      context.handle(
        _proofRefMeta,
        proofRef.isAcceptableOrUnknown(data['proof_ref']!, _proofRefMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('returned_at')) {
      context.handle(
        _returnedAtMeta,
        returnedAt.isAcceptableOrUnknown(data['returned_at']!, _returnedAtMeta),
      );
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
  Set<GeneratedColumn> get $primaryKey => {shomitiId, memberId};
  @override
  SecurityDepositRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SecurityDepositRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      amountBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_bdt'],
      )!,
      heldBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}held_by'],
      )!,
      proofRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_ref'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      returnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}returned_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $SecurityDepositsTable createAlias(String alias) {
    return $SecurityDepositsTable(attachedDatabase, alias);
  }
}

class SecurityDepositRow extends DataClass
    implements Insertable<SecurityDepositRow> {
  final String shomitiId;
  final String memberId;
  final int amountBdt;
  final String heldBy;
  final String? proofRef;
  final DateTime recordedAt;
  final DateTime? returnedAt;
  final DateTime? updatedAt;
  const SecurityDepositRow({
    required this.shomitiId,
    required this.memberId,
    required this.amountBdt,
    required this.heldBy,
    this.proofRef,
    required this.recordedAt,
    this.returnedAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['member_id'] = Variable<String>(memberId);
    map['amount_bdt'] = Variable<int>(amountBdt);
    map['held_by'] = Variable<String>(heldBy);
    if (!nullToAbsent || proofRef != null) {
      map['proof_ref'] = Variable<String>(proofRef);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    if (!nullToAbsent || returnedAt != null) {
      map['returned_at'] = Variable<DateTime>(returnedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SecurityDepositsCompanion toCompanion(bool nullToAbsent) {
    return SecurityDepositsCompanion(
      shomitiId: Value(shomitiId),
      memberId: Value(memberId),
      amountBdt: Value(amountBdt),
      heldBy: Value(heldBy),
      proofRef: proofRef == null && nullToAbsent
          ? const Value.absent()
          : Value(proofRef),
      recordedAt: Value(recordedAt),
      returnedAt: returnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SecurityDepositRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SecurityDepositRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      amountBdt: serializer.fromJson<int>(json['amountBdt']),
      heldBy: serializer.fromJson<String>(json['heldBy']),
      proofRef: serializer.fromJson<String?>(json['proofRef']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      returnedAt: serializer.fromJson<DateTime?>(json['returnedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'memberId': serializer.toJson<String>(memberId),
      'amountBdt': serializer.toJson<int>(amountBdt),
      'heldBy': serializer.toJson<String>(heldBy),
      'proofRef': serializer.toJson<String?>(proofRef),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'returnedAt': serializer.toJson<DateTime?>(returnedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  SecurityDepositRow copyWith({
    String? shomitiId,
    String? memberId,
    int? amountBdt,
    String? heldBy,
    Value<String?> proofRef = const Value.absent(),
    DateTime? recordedAt,
    Value<DateTime?> returnedAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => SecurityDepositRow(
    shomitiId: shomitiId ?? this.shomitiId,
    memberId: memberId ?? this.memberId,
    amountBdt: amountBdt ?? this.amountBdt,
    heldBy: heldBy ?? this.heldBy,
    proofRef: proofRef.present ? proofRef.value : this.proofRef,
    recordedAt: recordedAt ?? this.recordedAt,
    returnedAt: returnedAt.present ? returnedAt.value : this.returnedAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  SecurityDepositRow copyWithCompanion(SecurityDepositsCompanion data) {
    return SecurityDepositRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      amountBdt: data.amountBdt.present ? data.amountBdt.value : this.amountBdt,
      heldBy: data.heldBy.present ? data.heldBy.value : this.heldBy,
      proofRef: data.proofRef.present ? data.proofRef.value : this.proofRef,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      returnedAt: data.returnedAt.present
          ? data.returnedAt.value
          : this.returnedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SecurityDepositRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('heldBy: $heldBy, ')
          ..write('proofRef: $proofRef, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    memberId,
    amountBdt,
    heldBy,
    proofRef,
    recordedAt,
    returnedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SecurityDepositRow &&
          other.shomitiId == this.shomitiId &&
          other.memberId == this.memberId &&
          other.amountBdt == this.amountBdt &&
          other.heldBy == this.heldBy &&
          other.proofRef == this.proofRef &&
          other.recordedAt == this.recordedAt &&
          other.returnedAt == this.returnedAt &&
          other.updatedAt == this.updatedAt);
}

class SecurityDepositsCompanion extends UpdateCompanion<SecurityDepositRow> {
  final Value<String> shomitiId;
  final Value<String> memberId;
  final Value<int> amountBdt;
  final Value<String> heldBy;
  final Value<String?> proofRef;
  final Value<DateTime> recordedAt;
  final Value<DateTime?> returnedAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SecurityDepositsCompanion({
    this.shomitiId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.amountBdt = const Value.absent(),
    this.heldBy = const Value.absent(),
    this.proofRef = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SecurityDepositsCompanion.insert({
    required String shomitiId,
    required String memberId,
    required int amountBdt,
    required String heldBy,
    this.proofRef = const Value.absent(),
    required DateTime recordedAt,
    this.returnedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       memberId = Value(memberId),
       amountBdt = Value(amountBdt),
       heldBy = Value(heldBy),
       recordedAt = Value(recordedAt);
  static Insertable<SecurityDepositRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? memberId,
    Expression<int>? amountBdt,
    Expression<String>? heldBy,
    Expression<String>? proofRef,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? returnedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (memberId != null) 'member_id': memberId,
      if (amountBdt != null) 'amount_bdt': amountBdt,
      if (heldBy != null) 'held_by': heldBy,
      if (proofRef != null) 'proof_ref': proofRef,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (returnedAt != null) 'returned_at': returnedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SecurityDepositsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? memberId,
    Value<int>? amountBdt,
    Value<String>? heldBy,
    Value<String?>? proofRef,
    Value<DateTime>? recordedAt,
    Value<DateTime?>? returnedAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return SecurityDepositsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      memberId: memberId ?? this.memberId,
      amountBdt: amountBdt ?? this.amountBdt,
      heldBy: heldBy ?? this.heldBy,
      proofRef: proofRef ?? this.proofRef,
      recordedAt: recordedAt ?? this.recordedAt,
      returnedAt: returnedAt ?? this.returnedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (amountBdt.present) {
      map['amount_bdt'] = Variable<int>(amountBdt.value);
    }
    if (heldBy.present) {
      map['held_by'] = Variable<String>(heldBy.value);
    }
    if (proofRef.present) {
      map['proof_ref'] = Variable<String>(proofRef.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (returnedAt.present) {
      map['returned_at'] = Variable<DateTime>(returnedAt.value);
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
    return (StringBuffer('SecurityDepositsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('heldBy: $heldBy, ')
          ..write('proofRef: $proofRef, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('returnedAt: $returnedAt, ')
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

class $RuleAmendmentsTable extends RuleAmendments
    with TableInfo<$RuleAmendmentsTable, RuleAmendmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleAmendmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _baseRuleSetVersionIdMeta =
      const VerificationMeta('baseRuleSetVersionId');
  @override
  late final GeneratedColumn<String> baseRuleSetVersionId =
      GeneratedColumn<String>(
        'base_rule_set_version_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _proposedRuleSetVersionIdMeta =
      const VerificationMeta('proposedRuleSetVersionId');
  @override
  late final GeneratedColumn<String> proposedRuleSetVersionId =
      GeneratedColumn<String>(
        'proposed_rule_set_version_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES rule_set_versions (id)',
        ),
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _sharedReferenceMeta = const VerificationMeta(
    'sharedReference',
  );
  @override
  late final GeneratedColumn<String> sharedReference = GeneratedColumn<String>(
    'shared_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _appliedAtMeta = const VerificationMeta(
    'appliedAt',
  );
  @override
  late final GeneratedColumn<DateTime> appliedAt = GeneratedColumn<DateTime>(
    'applied_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shomitiId,
    baseRuleSetVersionId,
    proposedRuleSetVersionId,
    status,
    note,
    sharedReference,
    createdAt,
    appliedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_amendments';
  @override
  VerificationContext validateIntegrity(
    Insertable<RuleAmendmentRow> instance, {
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
    if (data.containsKey('base_rule_set_version_id')) {
      context.handle(
        _baseRuleSetVersionIdMeta,
        baseRuleSetVersionId.isAcceptableOrUnknown(
          data['base_rule_set_version_id']!,
          _baseRuleSetVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseRuleSetVersionIdMeta);
    }
    if (data.containsKey('proposed_rule_set_version_id')) {
      context.handle(
        _proposedRuleSetVersionIdMeta,
        proposedRuleSetVersionId.isAcceptableOrUnknown(
          data['proposed_rule_set_version_id']!,
          _proposedRuleSetVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proposedRuleSetVersionIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('shared_reference')) {
      context.handle(
        _sharedReferenceMeta,
        sharedReference.isAcceptableOrUnknown(
          data['shared_reference']!,
          _sharedReferenceMeta,
        ),
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
    if (data.containsKey('applied_at')) {
      context.handle(
        _appliedAtMeta,
        appliedAt.isAcceptableOrUnknown(data['applied_at']!, _appliedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleAmendmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleAmendmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      baseRuleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_rule_set_version_id'],
      )!,
      proposedRuleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposed_rule_set_version_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      sharedReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shared_reference'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      appliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}applied_at'],
      ),
    );
  }

  @override
  $RuleAmendmentsTable createAlias(String alias) {
    return $RuleAmendmentsTable(attachedDatabase, alias);
  }
}

class RuleAmendmentRow extends DataClass
    implements Insertable<RuleAmendmentRow> {
  final String id;
  final String shomitiId;

  /// The currently active rule set version when the amendment was proposed.
  final String baseRuleSetVersionId;

  /// The proposed rule set version id (new immutable snapshot).
  final String proposedRuleSetVersionId;

  /// `draft` | `pendingConsent` | `applied`
  final String status;

  /// Written summary of the amendment (required at apply-time).
  final String? note;

  /// Reference where it was shared (required at apply-time).
  final String? sharedReference;
  final DateTime createdAt;
  final DateTime? appliedAt;
  const RuleAmendmentRow({
    required this.id,
    required this.shomitiId,
    required this.baseRuleSetVersionId,
    required this.proposedRuleSetVersionId,
    required this.status,
    this.note,
    this.sharedReference,
    required this.createdAt,
    this.appliedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['base_rule_set_version_id'] = Variable<String>(baseRuleSetVersionId);
    map['proposed_rule_set_version_id'] = Variable<String>(
      proposedRuleSetVersionId,
    );
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || sharedReference != null) {
      map['shared_reference'] = Variable<String>(sharedReference);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || appliedAt != null) {
      map['applied_at'] = Variable<DateTime>(appliedAt);
    }
    return map;
  }

  RuleAmendmentsCompanion toCompanion(bool nullToAbsent) {
    return RuleAmendmentsCompanion(
      id: Value(id),
      shomitiId: Value(shomitiId),
      baseRuleSetVersionId: Value(baseRuleSetVersionId),
      proposedRuleSetVersionId: Value(proposedRuleSetVersionId),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      sharedReference: sharedReference == null && nullToAbsent
          ? const Value.absent()
          : Value(sharedReference),
      createdAt: Value(createdAt),
      appliedAt: appliedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(appliedAt),
    );
  }

  factory RuleAmendmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleAmendmentRow(
      id: serializer.fromJson<String>(json['id']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      baseRuleSetVersionId: serializer.fromJson<String>(
        json['baseRuleSetVersionId'],
      ),
      proposedRuleSetVersionId: serializer.fromJson<String>(
        json['proposedRuleSetVersionId'],
      ),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      sharedReference: serializer.fromJson<String?>(json['sharedReference']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      appliedAt: serializer.fromJson<DateTime?>(json['appliedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'baseRuleSetVersionId': serializer.toJson<String>(baseRuleSetVersionId),
      'proposedRuleSetVersionId': serializer.toJson<String>(
        proposedRuleSetVersionId,
      ),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'sharedReference': serializer.toJson<String?>(sharedReference),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'appliedAt': serializer.toJson<DateTime?>(appliedAt),
    };
  }

  RuleAmendmentRow copyWith({
    String? id,
    String? shomitiId,
    String? baseRuleSetVersionId,
    String? proposedRuleSetVersionId,
    String? status,
    Value<String?> note = const Value.absent(),
    Value<String?> sharedReference = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> appliedAt = const Value.absent(),
  }) => RuleAmendmentRow(
    id: id ?? this.id,
    shomitiId: shomitiId ?? this.shomitiId,
    baseRuleSetVersionId: baseRuleSetVersionId ?? this.baseRuleSetVersionId,
    proposedRuleSetVersionId:
        proposedRuleSetVersionId ?? this.proposedRuleSetVersionId,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    sharedReference: sharedReference.present
        ? sharedReference.value
        : this.sharedReference,
    createdAt: createdAt ?? this.createdAt,
    appliedAt: appliedAt.present ? appliedAt.value : this.appliedAt,
  );
  RuleAmendmentRow copyWithCompanion(RuleAmendmentsCompanion data) {
    return RuleAmendmentRow(
      id: data.id.present ? data.id.value : this.id,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      baseRuleSetVersionId: data.baseRuleSetVersionId.present
          ? data.baseRuleSetVersionId.value
          : this.baseRuleSetVersionId,
      proposedRuleSetVersionId: data.proposedRuleSetVersionId.present
          ? data.proposedRuleSetVersionId.value
          : this.proposedRuleSetVersionId,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      sharedReference: data.sharedReference.present
          ? data.sharedReference.value
          : this.sharedReference,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      appliedAt: data.appliedAt.present ? data.appliedAt.value : this.appliedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleAmendmentRow(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('baseRuleSetVersionId: $baseRuleSetVersionId, ')
          ..write('proposedRuleSetVersionId: $proposedRuleSetVersionId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('sharedReference: $sharedReference, ')
          ..write('createdAt: $createdAt, ')
          ..write('appliedAt: $appliedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shomitiId,
    baseRuleSetVersionId,
    proposedRuleSetVersionId,
    status,
    note,
    sharedReference,
    createdAt,
    appliedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleAmendmentRow &&
          other.id == this.id &&
          other.shomitiId == this.shomitiId &&
          other.baseRuleSetVersionId == this.baseRuleSetVersionId &&
          other.proposedRuleSetVersionId == this.proposedRuleSetVersionId &&
          other.status == this.status &&
          other.note == this.note &&
          other.sharedReference == this.sharedReference &&
          other.createdAt == this.createdAt &&
          other.appliedAt == this.appliedAt);
}

class RuleAmendmentsCompanion extends UpdateCompanion<RuleAmendmentRow> {
  final Value<String> id;
  final Value<String> shomitiId;
  final Value<String> baseRuleSetVersionId;
  final Value<String> proposedRuleSetVersionId;
  final Value<String> status;
  final Value<String?> note;
  final Value<String?> sharedReference;
  final Value<DateTime> createdAt;
  final Value<DateTime?> appliedAt;
  final Value<int> rowid;
  const RuleAmendmentsCompanion({
    this.id = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.baseRuleSetVersionId = const Value.absent(),
    this.proposedRuleSetVersionId = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.sharedReference = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.appliedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RuleAmendmentsCompanion.insert({
    required String id,
    required String shomitiId,
    required String baseRuleSetVersionId,
    required String proposedRuleSetVersionId,
    required String status,
    this.note = const Value.absent(),
    this.sharedReference = const Value.absent(),
    required DateTime createdAt,
    this.appliedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shomitiId = Value(shomitiId),
       baseRuleSetVersionId = Value(baseRuleSetVersionId),
       proposedRuleSetVersionId = Value(proposedRuleSetVersionId),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<RuleAmendmentRow> custom({
    Expression<String>? id,
    Expression<String>? shomitiId,
    Expression<String>? baseRuleSetVersionId,
    Expression<String>? proposedRuleSetVersionId,
    Expression<String>? status,
    Expression<String>? note,
    Expression<String>? sharedReference,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? appliedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (baseRuleSetVersionId != null)
        'base_rule_set_version_id': baseRuleSetVersionId,
      if (proposedRuleSetVersionId != null)
        'proposed_rule_set_version_id': proposedRuleSetVersionId,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (sharedReference != null) 'shared_reference': sharedReference,
      if (createdAt != null) 'created_at': createdAt,
      if (appliedAt != null) 'applied_at': appliedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RuleAmendmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? shomitiId,
    Value<String>? baseRuleSetVersionId,
    Value<String>? proposedRuleSetVersionId,
    Value<String>? status,
    Value<String?>? note,
    Value<String?>? sharedReference,
    Value<DateTime>? createdAt,
    Value<DateTime?>? appliedAt,
    Value<int>? rowid,
  }) {
    return RuleAmendmentsCompanion(
      id: id ?? this.id,
      shomitiId: shomitiId ?? this.shomitiId,
      baseRuleSetVersionId: baseRuleSetVersionId ?? this.baseRuleSetVersionId,
      proposedRuleSetVersionId:
          proposedRuleSetVersionId ?? this.proposedRuleSetVersionId,
      status: status ?? this.status,
      note: note ?? this.note,
      sharedReference: sharedReference ?? this.sharedReference,
      createdAt: createdAt ?? this.createdAt,
      appliedAt: appliedAt ?? this.appliedAt,
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
    if (baseRuleSetVersionId.present) {
      map['base_rule_set_version_id'] = Variable<String>(
        baseRuleSetVersionId.value,
      );
    }
    if (proposedRuleSetVersionId.present) {
      map['proposed_rule_set_version_id'] = Variable<String>(
        proposedRuleSetVersionId.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (sharedReference.present) {
      map['shared_reference'] = Variable<String>(sharedReference.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (appliedAt.present) {
      map['applied_at'] = Variable<DateTime>(appliedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleAmendmentsCompanion(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('baseRuleSetVersionId: $baseRuleSetVersionId, ')
          ..write('proposedRuleSetVersionId: $proposedRuleSetVersionId, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('sharedReference: $sharedReference, ')
          ..write('createdAt: $createdAt, ')
          ..write('appliedAt: $appliedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembershipChangeRequestsTable extends MembershipChangeRequests
    with TableInfo<$MembershipChangeRequestsTable, MembershipChangeRequestRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipChangeRequestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _outgoingMemberIdMeta = const VerificationMeta(
    'outgoingMemberId',
  );
  @override
  late final GeneratedColumn<String> outgoingMemberId = GeneratedColumn<String>(
    'outgoing_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requiresReplacementMeta =
      const VerificationMeta('requiresReplacement');
  @override
  late final GeneratedColumn<bool> requiresReplacement = GeneratedColumn<bool>(
    'requires_replacement',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_replacement" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _replacementCandidateNameMeta =
      const VerificationMeta('replacementCandidateName');
  @override
  late final GeneratedColumn<String> replacementCandidateName =
      GeneratedColumn<String>(
        'replacement_candidate_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _replacementCandidatePhoneMeta =
      const VerificationMeta('replacementCandidatePhone');
  @override
  late final GeneratedColumn<String> replacementCandidatePhone =
      GeneratedColumn<String>(
        'replacement_candidate_phone',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _removalReasonCodeMeta = const VerificationMeta(
    'removalReasonCode',
  );
  @override
  late final GeneratedColumn<String> removalReasonCode =
      GeneratedColumn<String>(
        'removal_reason_code',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _removalReasonDetailsMeta =
      const VerificationMeta('removalReasonDetails');
  @override
  late final GeneratedColumn<String> removalReasonDetails =
      GeneratedColumn<String>(
        'removal_reason_details',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
    'requested_at',
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
  static const VerificationMeta _finalizedAtMeta = const VerificationMeta(
    'finalizedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finalizedAt = GeneratedColumn<DateTime>(
    'finalized_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shomitiId,
    outgoingMemberId,
    type,
    requiresReplacement,
    replacementCandidateName,
    replacementCandidatePhone,
    removalReasonCode,
    removalReasonDetails,
    requestedAt,
    updatedAt,
    finalizedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'membership_change_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<MembershipChangeRequestRow> instance, {
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
    if (data.containsKey('outgoing_member_id')) {
      context.handle(
        _outgoingMemberIdMeta,
        outgoingMemberId.isAcceptableOrUnknown(
          data['outgoing_member_id']!,
          _outgoingMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outgoingMemberIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('requires_replacement')) {
      context.handle(
        _requiresReplacementMeta,
        requiresReplacement.isAcceptableOrUnknown(
          data['requires_replacement']!,
          _requiresReplacementMeta,
        ),
      );
    }
    if (data.containsKey('replacement_candidate_name')) {
      context.handle(
        _replacementCandidateNameMeta,
        replacementCandidateName.isAcceptableOrUnknown(
          data['replacement_candidate_name']!,
          _replacementCandidateNameMeta,
        ),
      );
    }
    if (data.containsKey('replacement_candidate_phone')) {
      context.handle(
        _replacementCandidatePhoneMeta,
        replacementCandidatePhone.isAcceptableOrUnknown(
          data['replacement_candidate_phone']!,
          _replacementCandidatePhoneMeta,
        ),
      );
    }
    if (data.containsKey('removal_reason_code')) {
      context.handle(
        _removalReasonCodeMeta,
        removalReasonCode.isAcceptableOrUnknown(
          data['removal_reason_code']!,
          _removalReasonCodeMeta,
        ),
      );
    }
    if (data.containsKey('removal_reason_details')) {
      context.handle(
        _removalReasonDetailsMeta,
        removalReasonDetails.isAcceptableOrUnknown(
          data['removal_reason_details']!,
          _removalReasonDetailsMeta,
        ),
      );
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('finalized_at')) {
      context.handle(
        _finalizedAtMeta,
        finalizedAt.isAcceptableOrUnknown(
          data['finalized_at']!,
          _finalizedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MembershipChangeRequestRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MembershipChangeRequestRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      outgoingMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outgoing_member_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      requiresReplacement: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_replacement'],
      )!,
      replacementCandidateName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}replacement_candidate_name'],
      ),
      replacementCandidatePhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}replacement_candidate_phone'],
      ),
      removalReasonCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}removal_reason_code'],
      ),
      removalReasonDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}removal_reason_details'],
      ),
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}requested_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      finalizedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finalized_at'],
      ),
    );
  }

  @override
  $MembershipChangeRequestsTable createAlias(String alias) {
    return $MembershipChangeRequestsTable(attachedDatabase, alias);
  }
}

class MembershipChangeRequestRow extends DataClass
    implements Insertable<MembershipChangeRequestRow> {
  final String id;
  final String shomitiId;
  final String outgoingMemberId;

  /// exit | replacement | removal
  final String type;

  /// `rules.md` Section 14 recommends requiring replacement by default.
  final bool requiresReplacement;
  final String? replacementCandidateName;
  final String? replacementCandidatePhone;

  /// removal reason codes (non-accusatory). Optional details allowed.
  final String? removalReasonCode;
  final String? removalReasonDetails;
  final DateTime requestedAt;
  final DateTime? updatedAt;
  final DateTime? finalizedAt;
  const MembershipChangeRequestRow({
    required this.id,
    required this.shomitiId,
    required this.outgoingMemberId,
    required this.type,
    required this.requiresReplacement,
    this.replacementCandidateName,
    this.replacementCandidatePhone,
    this.removalReasonCode,
    this.removalReasonDetails,
    required this.requestedAt,
    this.updatedAt,
    this.finalizedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['outgoing_member_id'] = Variable<String>(outgoingMemberId);
    map['type'] = Variable<String>(type);
    map['requires_replacement'] = Variable<bool>(requiresReplacement);
    if (!nullToAbsent || replacementCandidateName != null) {
      map['replacement_candidate_name'] = Variable<String>(
        replacementCandidateName,
      );
    }
    if (!nullToAbsent || replacementCandidatePhone != null) {
      map['replacement_candidate_phone'] = Variable<String>(
        replacementCandidatePhone,
      );
    }
    if (!nullToAbsent || removalReasonCode != null) {
      map['removal_reason_code'] = Variable<String>(removalReasonCode);
    }
    if (!nullToAbsent || removalReasonDetails != null) {
      map['removal_reason_details'] = Variable<String>(removalReasonDetails);
    }
    map['requested_at'] = Variable<DateTime>(requestedAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || finalizedAt != null) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt);
    }
    return map;
  }

  MembershipChangeRequestsCompanion toCompanion(bool nullToAbsent) {
    return MembershipChangeRequestsCompanion(
      id: Value(id),
      shomitiId: Value(shomitiId),
      outgoingMemberId: Value(outgoingMemberId),
      type: Value(type),
      requiresReplacement: Value(requiresReplacement),
      replacementCandidateName: replacementCandidateName == null && nullToAbsent
          ? const Value.absent()
          : Value(replacementCandidateName),
      replacementCandidatePhone:
          replacementCandidatePhone == null && nullToAbsent
          ? const Value.absent()
          : Value(replacementCandidatePhone),
      removalReasonCode: removalReasonCode == null && nullToAbsent
          ? const Value.absent()
          : Value(removalReasonCode),
      removalReasonDetails: removalReasonDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(removalReasonDetails),
      requestedAt: Value(requestedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      finalizedAt: finalizedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finalizedAt),
    );
  }

  factory MembershipChangeRequestRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MembershipChangeRequestRow(
      id: serializer.fromJson<String>(json['id']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      outgoingMemberId: serializer.fromJson<String>(json['outgoingMemberId']),
      type: serializer.fromJson<String>(json['type']),
      requiresReplacement: serializer.fromJson<bool>(
        json['requiresReplacement'],
      ),
      replacementCandidateName: serializer.fromJson<String?>(
        json['replacementCandidateName'],
      ),
      replacementCandidatePhone: serializer.fromJson<String?>(
        json['replacementCandidatePhone'],
      ),
      removalReasonCode: serializer.fromJson<String?>(
        json['removalReasonCode'],
      ),
      removalReasonDetails: serializer.fromJson<String?>(
        json['removalReasonDetails'],
      ),
      requestedAt: serializer.fromJson<DateTime>(json['requestedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      finalizedAt: serializer.fromJson<DateTime?>(json['finalizedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'outgoingMemberId': serializer.toJson<String>(outgoingMemberId),
      'type': serializer.toJson<String>(type),
      'requiresReplacement': serializer.toJson<bool>(requiresReplacement),
      'replacementCandidateName': serializer.toJson<String?>(
        replacementCandidateName,
      ),
      'replacementCandidatePhone': serializer.toJson<String?>(
        replacementCandidatePhone,
      ),
      'removalReasonCode': serializer.toJson<String?>(removalReasonCode),
      'removalReasonDetails': serializer.toJson<String?>(removalReasonDetails),
      'requestedAt': serializer.toJson<DateTime>(requestedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'finalizedAt': serializer.toJson<DateTime?>(finalizedAt),
    };
  }

  MembershipChangeRequestRow copyWith({
    String? id,
    String? shomitiId,
    String? outgoingMemberId,
    String? type,
    bool? requiresReplacement,
    Value<String?> replacementCandidateName = const Value.absent(),
    Value<String?> replacementCandidatePhone = const Value.absent(),
    Value<String?> removalReasonCode = const Value.absent(),
    Value<String?> removalReasonDetails = const Value.absent(),
    DateTime? requestedAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> finalizedAt = const Value.absent(),
  }) => MembershipChangeRequestRow(
    id: id ?? this.id,
    shomitiId: shomitiId ?? this.shomitiId,
    outgoingMemberId: outgoingMemberId ?? this.outgoingMemberId,
    type: type ?? this.type,
    requiresReplacement: requiresReplacement ?? this.requiresReplacement,
    replacementCandidateName: replacementCandidateName.present
        ? replacementCandidateName.value
        : this.replacementCandidateName,
    replacementCandidatePhone: replacementCandidatePhone.present
        ? replacementCandidatePhone.value
        : this.replacementCandidatePhone,
    removalReasonCode: removalReasonCode.present
        ? removalReasonCode.value
        : this.removalReasonCode,
    removalReasonDetails: removalReasonDetails.present
        ? removalReasonDetails.value
        : this.removalReasonDetails,
    requestedAt: requestedAt ?? this.requestedAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    finalizedAt: finalizedAt.present ? finalizedAt.value : this.finalizedAt,
  );
  MembershipChangeRequestRow copyWithCompanion(
    MembershipChangeRequestsCompanion data,
  ) {
    return MembershipChangeRequestRow(
      id: data.id.present ? data.id.value : this.id,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      outgoingMemberId: data.outgoingMemberId.present
          ? data.outgoingMemberId.value
          : this.outgoingMemberId,
      type: data.type.present ? data.type.value : this.type,
      requiresReplacement: data.requiresReplacement.present
          ? data.requiresReplacement.value
          : this.requiresReplacement,
      replacementCandidateName: data.replacementCandidateName.present
          ? data.replacementCandidateName.value
          : this.replacementCandidateName,
      replacementCandidatePhone: data.replacementCandidatePhone.present
          ? data.replacementCandidatePhone.value
          : this.replacementCandidatePhone,
      removalReasonCode: data.removalReasonCode.present
          ? data.removalReasonCode.value
          : this.removalReasonCode,
      removalReasonDetails: data.removalReasonDetails.present
          ? data.removalReasonDetails.value
          : this.removalReasonDetails,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      finalizedAt: data.finalizedAt.present
          ? data.finalizedAt.value
          : this.finalizedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MembershipChangeRequestRow(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('outgoingMemberId: $outgoingMemberId, ')
          ..write('type: $type, ')
          ..write('requiresReplacement: $requiresReplacement, ')
          ..write('replacementCandidateName: $replacementCandidateName, ')
          ..write('replacementCandidatePhone: $replacementCandidatePhone, ')
          ..write('removalReasonCode: $removalReasonCode, ')
          ..write('removalReasonDetails: $removalReasonDetails, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('finalizedAt: $finalizedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shomitiId,
    outgoingMemberId,
    type,
    requiresReplacement,
    replacementCandidateName,
    replacementCandidatePhone,
    removalReasonCode,
    removalReasonDetails,
    requestedAt,
    updatedAt,
    finalizedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MembershipChangeRequestRow &&
          other.id == this.id &&
          other.shomitiId == this.shomitiId &&
          other.outgoingMemberId == this.outgoingMemberId &&
          other.type == this.type &&
          other.requiresReplacement == this.requiresReplacement &&
          other.replacementCandidateName == this.replacementCandidateName &&
          other.replacementCandidatePhone == this.replacementCandidatePhone &&
          other.removalReasonCode == this.removalReasonCode &&
          other.removalReasonDetails == this.removalReasonDetails &&
          other.requestedAt == this.requestedAt &&
          other.updatedAt == this.updatedAt &&
          other.finalizedAt == this.finalizedAt);
}

class MembershipChangeRequestsCompanion
    extends UpdateCompanion<MembershipChangeRequestRow> {
  final Value<String> id;
  final Value<String> shomitiId;
  final Value<String> outgoingMemberId;
  final Value<String> type;
  final Value<bool> requiresReplacement;
  final Value<String?> replacementCandidateName;
  final Value<String?> replacementCandidatePhone;
  final Value<String?> removalReasonCode;
  final Value<String?> removalReasonDetails;
  final Value<DateTime> requestedAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> finalizedAt;
  final Value<int> rowid;
  const MembershipChangeRequestsCompanion({
    this.id = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.outgoingMemberId = const Value.absent(),
    this.type = const Value.absent(),
    this.requiresReplacement = const Value.absent(),
    this.replacementCandidateName = const Value.absent(),
    this.replacementCandidatePhone = const Value.absent(),
    this.removalReasonCode = const Value.absent(),
    this.removalReasonDetails = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipChangeRequestsCompanion.insert({
    required String id,
    required String shomitiId,
    required String outgoingMemberId,
    required String type,
    this.requiresReplacement = const Value.absent(),
    this.replacementCandidateName = const Value.absent(),
    this.replacementCandidatePhone = const Value.absent(),
    this.removalReasonCode = const Value.absent(),
    this.removalReasonDetails = const Value.absent(),
    required DateTime requestedAt,
    this.updatedAt = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shomitiId = Value(shomitiId),
       outgoingMemberId = Value(outgoingMemberId),
       type = Value(type),
       requestedAt = Value(requestedAt);
  static Insertable<MembershipChangeRequestRow> custom({
    Expression<String>? id,
    Expression<String>? shomitiId,
    Expression<String>? outgoingMemberId,
    Expression<String>? type,
    Expression<bool>? requiresReplacement,
    Expression<String>? replacementCandidateName,
    Expression<String>? replacementCandidatePhone,
    Expression<String>? removalReasonCode,
    Expression<String>? removalReasonDetails,
    Expression<DateTime>? requestedAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? finalizedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (outgoingMemberId != null) 'outgoing_member_id': outgoingMemberId,
      if (type != null) 'type': type,
      if (requiresReplacement != null)
        'requires_replacement': requiresReplacement,
      if (replacementCandidateName != null)
        'replacement_candidate_name': replacementCandidateName,
      if (replacementCandidatePhone != null)
        'replacement_candidate_phone': replacementCandidatePhone,
      if (removalReasonCode != null) 'removal_reason_code': removalReasonCode,
      if (removalReasonDetails != null)
        'removal_reason_details': removalReasonDetails,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (finalizedAt != null) 'finalized_at': finalizedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipChangeRequestsCompanion copyWith({
    Value<String>? id,
    Value<String>? shomitiId,
    Value<String>? outgoingMemberId,
    Value<String>? type,
    Value<bool>? requiresReplacement,
    Value<String?>? replacementCandidateName,
    Value<String?>? replacementCandidatePhone,
    Value<String?>? removalReasonCode,
    Value<String?>? removalReasonDetails,
    Value<DateTime>? requestedAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? finalizedAt,
    Value<int>? rowid,
  }) {
    return MembershipChangeRequestsCompanion(
      id: id ?? this.id,
      shomitiId: shomitiId ?? this.shomitiId,
      outgoingMemberId: outgoingMemberId ?? this.outgoingMemberId,
      type: type ?? this.type,
      requiresReplacement: requiresReplacement ?? this.requiresReplacement,
      replacementCandidateName:
          replacementCandidateName ?? this.replacementCandidateName,
      replacementCandidatePhone:
          replacementCandidatePhone ?? this.replacementCandidatePhone,
      removalReasonCode: removalReasonCode ?? this.removalReasonCode,
      removalReasonDetails: removalReasonDetails ?? this.removalReasonDetails,
      requestedAt: requestedAt ?? this.requestedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      finalizedAt: finalizedAt ?? this.finalizedAt,
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
    if (outgoingMemberId.present) {
      map['outgoing_member_id'] = Variable<String>(outgoingMemberId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (requiresReplacement.present) {
      map['requires_replacement'] = Variable<bool>(requiresReplacement.value);
    }
    if (replacementCandidateName.present) {
      map['replacement_candidate_name'] = Variable<String>(
        replacementCandidateName.value,
      );
    }
    if (replacementCandidatePhone.present) {
      map['replacement_candidate_phone'] = Variable<String>(
        replacementCandidatePhone.value,
      );
    }
    if (removalReasonCode.present) {
      map['removal_reason_code'] = Variable<String>(removalReasonCode.value);
    }
    if (removalReasonDetails.present) {
      map['removal_reason_details'] = Variable<String>(
        removalReasonDetails.value,
      );
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (finalizedAt.present) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipChangeRequestsCompanion(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('outgoingMemberId: $outgoingMemberId, ')
          ..write('type: $type, ')
          ..write('requiresReplacement: $requiresReplacement, ')
          ..write('replacementCandidateName: $replacementCandidateName, ')
          ..write('replacementCandidatePhone: $replacementCandidatePhone, ')
          ..write('removalReasonCode: $removalReasonCode, ')
          ..write('removalReasonDetails: $removalReasonDetails, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembershipChangeApprovalsTable extends MembershipChangeApprovals
    with
        TableInfo<
          $MembershipChangeApprovalsTable,
          MembershipChangeApprovalRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipChangeApprovalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _requestIdMeta = const VerificationMeta(
    'requestId',
  );
  @override
  late final GeneratedColumn<String> requestId = GeneratedColumn<String>(
    'request_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES membership_change_requests (id)',
    ),
  );
  static const VerificationMeta _approverMemberIdMeta = const VerificationMeta(
    'approverMemberId',
  );
  @override
  late final GeneratedColumn<String> approverMemberId = GeneratedColumn<String>(
    'approver_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
    'approved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    requestId,
    approverMemberId,
    approvedAt,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'membership_change_approvals';
  @override
  VerificationContext validateIntegrity(
    Insertable<MembershipChangeApprovalRow> instance, {
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
    if (data.containsKey('request_id')) {
      context.handle(
        _requestIdMeta,
        requestId.isAcceptableOrUnknown(data['request_id']!, _requestIdMeta),
      );
    } else if (isInserting) {
      context.missing(_requestIdMeta);
    }
    if (data.containsKey('approver_member_id')) {
      context.handle(
        _approverMemberIdMeta,
        approverMemberId.isAcceptableOrUnknown(
          data['approver_member_id']!,
          _approverMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_approverMemberIdMeta);
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_approvedAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    shomitiId,
    requestId,
    approverMemberId,
  };
  @override
  MembershipChangeApprovalRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MembershipChangeApprovalRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      requestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}request_id'],
      )!,
      approverMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}approver_member_id'],
      )!,
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $MembershipChangeApprovalsTable createAlias(String alias) {
    return $MembershipChangeApprovalsTable(attachedDatabase, alias);
  }
}

class MembershipChangeApprovalRow extends DataClass
    implements Insertable<MembershipChangeApprovalRow> {
  final String shomitiId;
  final String requestId;
  final String approverMemberId;
  final DateTime approvedAt;
  final String? note;
  const MembershipChangeApprovalRow({
    required this.shomitiId,
    required this.requestId,
    required this.approverMemberId,
    required this.approvedAt,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['request_id'] = Variable<String>(requestId);
    map['approver_member_id'] = Variable<String>(approverMemberId);
    map['approved_at'] = Variable<DateTime>(approvedAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  MembershipChangeApprovalsCompanion toCompanion(bool nullToAbsent) {
    return MembershipChangeApprovalsCompanion(
      shomitiId: Value(shomitiId),
      requestId: Value(requestId),
      approverMemberId: Value(approverMemberId),
      approvedAt: Value(approvedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory MembershipChangeApprovalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MembershipChangeApprovalRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      requestId: serializer.fromJson<String>(json['requestId']),
      approverMemberId: serializer.fromJson<String>(json['approverMemberId']),
      approvedAt: serializer.fromJson<DateTime>(json['approvedAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'requestId': serializer.toJson<String>(requestId),
      'approverMemberId': serializer.toJson<String>(approverMemberId),
      'approvedAt': serializer.toJson<DateTime>(approvedAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  MembershipChangeApprovalRow copyWith({
    String? shomitiId,
    String? requestId,
    String? approverMemberId,
    DateTime? approvedAt,
    Value<String?> note = const Value.absent(),
  }) => MembershipChangeApprovalRow(
    shomitiId: shomitiId ?? this.shomitiId,
    requestId: requestId ?? this.requestId,
    approverMemberId: approverMemberId ?? this.approverMemberId,
    approvedAt: approvedAt ?? this.approvedAt,
    note: note.present ? note.value : this.note,
  );
  MembershipChangeApprovalRow copyWithCompanion(
    MembershipChangeApprovalsCompanion data,
  ) {
    return MembershipChangeApprovalRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      requestId: data.requestId.present ? data.requestId.value : this.requestId,
      approverMemberId: data.approverMemberId.present
          ? data.approverMemberId.value
          : this.approverMemberId,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MembershipChangeApprovalRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('requestId: $requestId, ')
          ..write('approverMemberId: $approverMemberId, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(shomitiId, requestId, approverMemberId, approvedAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MembershipChangeApprovalRow &&
          other.shomitiId == this.shomitiId &&
          other.requestId == this.requestId &&
          other.approverMemberId == this.approverMemberId &&
          other.approvedAt == this.approvedAt &&
          other.note == this.note);
}

class MembershipChangeApprovalsCompanion
    extends UpdateCompanion<MembershipChangeApprovalRow> {
  final Value<String> shomitiId;
  final Value<String> requestId;
  final Value<String> approverMemberId;
  final Value<DateTime> approvedAt;
  final Value<String?> note;
  final Value<int> rowid;
  const MembershipChangeApprovalsCompanion({
    this.shomitiId = const Value.absent(),
    this.requestId = const Value.absent(),
    this.approverMemberId = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipChangeApprovalsCompanion.insert({
    required String shomitiId,
    required String requestId,
    required String approverMemberId,
    required DateTime approvedAt,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       requestId = Value(requestId),
       approverMemberId = Value(approverMemberId),
       approvedAt = Value(approvedAt);
  static Insertable<MembershipChangeApprovalRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? requestId,
    Expression<String>? approverMemberId,
    Expression<DateTime>? approvedAt,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (requestId != null) 'request_id': requestId,
      if (approverMemberId != null) 'approver_member_id': approverMemberId,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipChangeApprovalsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? requestId,
    Value<String>? approverMemberId,
    Value<DateTime>? approvedAt,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return MembershipChangeApprovalsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      requestId: requestId ?? this.requestId,
      approverMemberId: approverMemberId ?? this.approverMemberId,
      approvedAt: approvedAt ?? this.approvedAt,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (requestId.present) {
      map['request_id'] = Variable<String>(requestId.value);
    }
    if (approverMemberId.present) {
      map['approver_member_id'] = Variable<String>(approverMemberId.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipChangeApprovalsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('requestId: $requestId, ')
          ..write('approverMemberId: $approverMemberId, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DueMonthsTable extends DueMonths
    with TableInfo<$DueMonthsTable, DueMonthRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DueMonthsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    ruleSetVersionId,
    generatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'due_months';
  @override
  VerificationContext validateIntegrity(
    Insertable<DueMonthRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
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
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey};
  @override
  DueMonthRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DueMonthRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $DueMonthsTable createAlias(String alias) {
    return $DueMonthsTable(attachedDatabase, alias);
  }
}

class DueMonthRow extends DataClass implements Insertable<DueMonthRow> {
  final String shomitiId;

  /// YYYY-MM (e.g. 2026-02)
  final String monthKey;
  final String ruleSetVersionId;
  final DateTime generatedAt;
  const DueMonthRow({
    required this.shomitiId,
    required this.monthKey,
    required this.ruleSetVersionId,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  DueMonthsCompanion toCompanion(bool nullToAbsent) {
    return DueMonthsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      ruleSetVersionId: Value(ruleSetVersionId),
      generatedAt: Value(generatedAt),
    );
  }

  factory DueMonthRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DueMonthRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  DueMonthRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? ruleSetVersionId,
    DateTime? generatedAt,
  }) => DueMonthRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  DueMonthRow copyWithCompanion(DueMonthsCompanion data) {
    return DueMonthRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DueMonthRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(shomitiId, monthKey, ruleSetVersionId, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DueMonthRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.generatedAt == this.generatedAt);
}

class DueMonthsCompanion extends UpdateCompanion<DueMonthRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> ruleSetVersionId;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const DueMonthsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DueMonthsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String ruleSetVersionId,
    required DateTime generatedAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       ruleSetVersionId = Value(ruleSetVersionId),
       generatedAt = Value(generatedAt);
  static Insertable<DueMonthRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? ruleSetVersionId,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DueMonthsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? ruleSetVersionId,
    Value<DateTime>? generatedAt,
    Value<int>? rowid,
  }) {
    return DueMonthsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DueMonthsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyDuesTable extends MonthlyDues
    with TableInfo<$MonthlyDuesTable, MonthlyDueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyDuesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
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
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<int> shares = GeneratedColumn<int>(
    'shares',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shareValueBdtMeta = const VerificationMeta(
    'shareValueBdt',
  );
  @override
  late final GeneratedColumn<int> shareValueBdt = GeneratedColumn<int>(
    'share_value_bdt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAmountBdtMeta = const VerificationMeta(
    'dueAmountBdt',
  );
  @override
  late final GeneratedColumn<int> dueAmountBdt = GeneratedColumn<int>(
    'due_amount_bdt',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    memberId,
    shares,
    shareValueBdt,
    dueAmountBdt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_dues';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyDueRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
    }
    if (data.containsKey('share_value_bdt')) {
      context.handle(
        _shareValueBdtMeta,
        shareValueBdt.isAcceptableOrUnknown(
          data['share_value_bdt']!,
          _shareValueBdtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shareValueBdtMeta);
    }
    if (data.containsKey('due_amount_bdt')) {
      context.handle(
        _dueAmountBdtMeta,
        dueAmountBdt.isAcceptableOrUnknown(
          data['due_amount_bdt']!,
          _dueAmountBdtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dueAmountBdtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey, memberId};
  @override
  MonthlyDueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyDueRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shares'],
      )!,
      shareValueBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}share_value_bdt'],
      )!,
      dueAmountBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_amount_bdt'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MonthlyDuesTable createAlias(String alias) {
    return $MonthlyDuesTable(attachedDatabase, alias);
  }
}

class MonthlyDueRow extends DataClass implements Insertable<MonthlyDueRow> {
  final String shomitiId;

  /// YYYY-MM (e.g. 2026-02)
  final String monthKey;
  final String memberId;
  final int shares;
  final int shareValueBdt;
  final int dueAmountBdt;
  final DateTime createdAt;
  const MonthlyDueRow({
    required this.shomitiId,
    required this.monthKey,
    required this.memberId,
    required this.shares,
    required this.shareValueBdt,
    required this.dueAmountBdt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['member_id'] = Variable<String>(memberId);
    map['shares'] = Variable<int>(shares);
    map['share_value_bdt'] = Variable<int>(shareValueBdt);
    map['due_amount_bdt'] = Variable<int>(dueAmountBdt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MonthlyDuesCompanion toCompanion(bool nullToAbsent) {
    return MonthlyDuesCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      memberId: Value(memberId),
      shares: Value(shares),
      shareValueBdt: Value(shareValueBdt),
      dueAmountBdt: Value(dueAmountBdt),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyDueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyDueRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      memberId: serializer.fromJson<String>(json['memberId']),
      shares: serializer.fromJson<int>(json['shares']),
      shareValueBdt: serializer.fromJson<int>(json['shareValueBdt']),
      dueAmountBdt: serializer.fromJson<int>(json['dueAmountBdt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'memberId': serializer.toJson<String>(memberId),
      'shares': serializer.toJson<int>(shares),
      'shareValueBdt': serializer.toJson<int>(shareValueBdt),
      'dueAmountBdt': serializer.toJson<int>(dueAmountBdt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MonthlyDueRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? memberId,
    int? shares,
    int? shareValueBdt,
    int? dueAmountBdt,
    DateTime? createdAt,
  }) => MonthlyDueRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    memberId: memberId ?? this.memberId,
    shares: shares ?? this.shares,
    shareValueBdt: shareValueBdt ?? this.shareValueBdt,
    dueAmountBdt: dueAmountBdt ?? this.dueAmountBdt,
    createdAt: createdAt ?? this.createdAt,
  );
  MonthlyDueRow copyWithCompanion(MonthlyDuesCompanion data) {
    return MonthlyDueRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      shares: data.shares.present ? data.shares.value : this.shares,
      shareValueBdt: data.shareValueBdt.present
          ? data.shareValueBdt.value
          : this.shareValueBdt,
      dueAmountBdt: data.dueAmountBdt.present
          ? data.dueAmountBdt.value
          : this.dueAmountBdt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyDueRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('memberId: $memberId, ')
          ..write('shares: $shares, ')
          ..write('shareValueBdt: $shareValueBdt, ')
          ..write('dueAmountBdt: $dueAmountBdt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    monthKey,
    memberId,
    shares,
    shareValueBdt,
    dueAmountBdt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyDueRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.memberId == this.memberId &&
          other.shares == this.shares &&
          other.shareValueBdt == this.shareValueBdt &&
          other.dueAmountBdt == this.dueAmountBdt &&
          other.createdAt == this.createdAt);
}

class MonthlyDuesCompanion extends UpdateCompanion<MonthlyDueRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> memberId;
  final Value<int> shares;
  final Value<int> shareValueBdt;
  final Value<int> dueAmountBdt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MonthlyDuesCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.memberId = const Value.absent(),
    this.shares = const Value.absent(),
    this.shareValueBdt = const Value.absent(),
    this.dueAmountBdt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyDuesCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String memberId,
    required int shares,
    required int shareValueBdt,
    required int dueAmountBdt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       memberId = Value(memberId),
       shares = Value(shares),
       shareValueBdt = Value(shareValueBdt),
       dueAmountBdt = Value(dueAmountBdt),
       createdAt = Value(createdAt);
  static Insertable<MonthlyDueRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? memberId,
    Expression<int>? shares,
    Expression<int>? shareValueBdt,
    Expression<int>? dueAmountBdt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (memberId != null) 'member_id': memberId,
      if (shares != null) 'shares': shares,
      if (shareValueBdt != null) 'share_value_bdt': shareValueBdt,
      if (dueAmountBdt != null) 'due_amount_bdt': dueAmountBdt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyDuesCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? memberId,
    Value<int>? shares,
    Value<int>? shareValueBdt,
    Value<int>? dueAmountBdt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MonthlyDuesCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      memberId: memberId ?? this.memberId,
      shares: shares ?? this.shares,
      shareValueBdt: shareValueBdt ?? this.shareValueBdt,
      dueAmountBdt: dueAmountBdt ?? this.dueAmountBdt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (shares.present) {
      map['shares'] = Variable<int>(shares.value);
    }
    if (shareValueBdt.present) {
      map['share_value_bdt'] = Variable<int>(shareValueBdt.value);
    }
    if (dueAmountBdt.present) {
      map['due_amount_bdt'] = Variable<int>(dueAmountBdt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyDuesCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('memberId: $memberId, ')
          ..write('shares: $shares, ')
          ..write('shareValueBdt: $shareValueBdt, ')
          ..write('dueAmountBdt: $dueAmountBdt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
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
  static const VerificationMeta _amountBdtMeta = const VerificationMeta(
    'amountBdt',
  );
  @override
  late final GeneratedColumn<int> amountBdt = GeneratedColumn<int>(
    'amount_bdt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proofNoteMeta = const VerificationMeta(
    'proofNote',
  );
  @override
  late final GeneratedColumn<String> proofNote = GeneratedColumn<String>(
    'proof_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confirmedAtMeta = const VerificationMeta(
    'confirmedAt',
  );
  @override
  late final GeneratedColumn<DateTime> confirmedAt = GeneratedColumn<DateTime>(
    'confirmed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiptNumberMeta = const VerificationMeta(
    'receiptNumber',
  );
  @override
  late final GeneratedColumn<String> receiptNumber = GeneratedColumn<String>(
    'receipt_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptIssuedAtMeta = const VerificationMeta(
    'receiptIssuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receiptIssuedAt =
      GeneratedColumn<DateTime>(
        'receipt_issued_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shomitiId,
    monthKey,
    memberId,
    amountBdt,
    method,
    reference,
    proofNote,
    recordedAt,
    confirmedAt,
    receiptNumber,
    receiptIssuedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('amount_bdt')) {
      context.handle(
        _amountBdtMeta,
        amountBdt.isAcceptableOrUnknown(data['amount_bdt']!, _amountBdtMeta),
      );
    } else if (isInserting) {
      context.missing(_amountBdtMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('proof_note')) {
      context.handle(
        _proofNoteMeta,
        proofNote.isAcceptableOrUnknown(data['proof_note']!, _proofNoteMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('confirmed_at')) {
      context.handle(
        _confirmedAtMeta,
        confirmedAt.isAcceptableOrUnknown(
          data['confirmed_at']!,
          _confirmedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confirmedAtMeta);
    }
    if (data.containsKey('receipt_number')) {
      context.handle(
        _receiptNumberMeta,
        receiptNumber.isAcceptableOrUnknown(
          data['receipt_number']!,
          _receiptNumberMeta,
        ),
      );
    }
    if (data.containsKey('receipt_issued_at')) {
      context.handle(
        _receiptIssuedAtMeta,
        receiptIssuedAt.isAcceptableOrUnknown(
          data['receipt_issued_at']!,
          _receiptIssuedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {shomitiId, monthKey, memberId},
  ];
  @override
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      amountBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_bdt'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      proofNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_note'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      confirmedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}confirmed_at'],
      )!,
      receiptNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_number'],
      ),
      receiptIssuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}receipt_issued_at'],
      ),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final String id;
  final String shomitiId;
  final String monthKey;
  final String memberId;
  final int amountBdt;
  final String method;
  final String reference;
  final String? proofNote;
  final DateTime recordedAt;
  final DateTime confirmedAt;
  final String? receiptNumber;
  final DateTime? receiptIssuedAt;
  const PaymentRow({
    required this.id,
    required this.shomitiId,
    required this.monthKey,
    required this.memberId,
    required this.amountBdt,
    required this.method,
    required this.reference,
    this.proofNote,
    required this.recordedAt,
    required this.confirmedAt,
    this.receiptNumber,
    this.receiptIssuedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['member_id'] = Variable<String>(memberId);
    map['amount_bdt'] = Variable<int>(amountBdt);
    map['method'] = Variable<String>(method);
    map['reference'] = Variable<String>(reference);
    if (!nullToAbsent || proofNote != null) {
      map['proof_note'] = Variable<String>(proofNote);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['confirmed_at'] = Variable<DateTime>(confirmedAt);
    if (!nullToAbsent || receiptNumber != null) {
      map['receipt_number'] = Variable<String>(receiptNumber);
    }
    if (!nullToAbsent || receiptIssuedAt != null) {
      map['receipt_issued_at'] = Variable<DateTime>(receiptIssuedAt);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      memberId: Value(memberId),
      amountBdt: Value(amountBdt),
      method: Value(method),
      reference: Value(reference),
      proofNote: proofNote == null && nullToAbsent
          ? const Value.absent()
          : Value(proofNote),
      recordedAt: Value(recordedAt),
      confirmedAt: Value(confirmedAt),
      receiptNumber: receiptNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptNumber),
      receiptIssuedAt: receiptIssuedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptIssuedAt),
    );
  }

  factory PaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      id: serializer.fromJson<String>(json['id']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      memberId: serializer.fromJson<String>(json['memberId']),
      amountBdt: serializer.fromJson<int>(json['amountBdt']),
      method: serializer.fromJson<String>(json['method']),
      reference: serializer.fromJson<String>(json['reference']),
      proofNote: serializer.fromJson<String?>(json['proofNote']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      confirmedAt: serializer.fromJson<DateTime>(json['confirmedAt']),
      receiptNumber: serializer.fromJson<String?>(json['receiptNumber']),
      receiptIssuedAt: serializer.fromJson<DateTime?>(json['receiptIssuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'memberId': serializer.toJson<String>(memberId),
      'amountBdt': serializer.toJson<int>(amountBdt),
      'method': serializer.toJson<String>(method),
      'reference': serializer.toJson<String>(reference),
      'proofNote': serializer.toJson<String?>(proofNote),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'confirmedAt': serializer.toJson<DateTime>(confirmedAt),
      'receiptNumber': serializer.toJson<String?>(receiptNumber),
      'receiptIssuedAt': serializer.toJson<DateTime?>(receiptIssuedAt),
    };
  }

  PaymentRow copyWith({
    String? id,
    String? shomitiId,
    String? monthKey,
    String? memberId,
    int? amountBdt,
    String? method,
    String? reference,
    Value<String?> proofNote = const Value.absent(),
    DateTime? recordedAt,
    DateTime? confirmedAt,
    Value<String?> receiptNumber = const Value.absent(),
    Value<DateTime?> receiptIssuedAt = const Value.absent(),
  }) => PaymentRow(
    id: id ?? this.id,
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    memberId: memberId ?? this.memberId,
    amountBdt: amountBdt ?? this.amountBdt,
    method: method ?? this.method,
    reference: reference ?? this.reference,
    proofNote: proofNote.present ? proofNote.value : this.proofNote,
    recordedAt: recordedAt ?? this.recordedAt,
    confirmedAt: confirmedAt ?? this.confirmedAt,
    receiptNumber: receiptNumber.present
        ? receiptNumber.value
        : this.receiptNumber,
    receiptIssuedAt: receiptIssuedAt.present
        ? receiptIssuedAt.value
        : this.receiptIssuedAt,
  );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      id: data.id.present ? data.id.value : this.id,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      amountBdt: data.amountBdt.present ? data.amountBdt.value : this.amountBdt,
      method: data.method.present ? data.method.value : this.method,
      reference: data.reference.present ? data.reference.value : this.reference,
      proofNote: data.proofNote.present ? data.proofNote.value : this.proofNote,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      confirmedAt: data.confirmedAt.present
          ? data.confirmedAt.value
          : this.confirmedAt,
      receiptNumber: data.receiptNumber.present
          ? data.receiptNumber.value
          : this.receiptNumber,
      receiptIssuedAt: data.receiptIssuedAt.present
          ? data.receiptIssuedAt.value
          : this.receiptIssuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('memberId: $memberId, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('proofNote: $proofNote, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('receiptIssuedAt: $receiptIssuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shomitiId,
    monthKey,
    memberId,
    amountBdt,
    method,
    reference,
    proofNote,
    recordedAt,
    confirmedAt,
    receiptNumber,
    receiptIssuedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.id == this.id &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.memberId == this.memberId &&
          other.amountBdt == this.amountBdt &&
          other.method == this.method &&
          other.reference == this.reference &&
          other.proofNote == this.proofNote &&
          other.recordedAt == this.recordedAt &&
          other.confirmedAt == this.confirmedAt &&
          other.receiptNumber == this.receiptNumber &&
          other.receiptIssuedAt == this.receiptIssuedAt);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<String> id;
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> memberId;
  final Value<int> amountBdt;
  final Value<String> method;
  final Value<String> reference;
  final Value<String?> proofNote;
  final Value<DateTime> recordedAt;
  final Value<DateTime> confirmedAt;
  final Value<String?> receiptNumber;
  final Value<DateTime?> receiptIssuedAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.memberId = const Value.absent(),
    this.amountBdt = const Value.absent(),
    this.method = const Value.absent(),
    this.reference = const Value.absent(),
    this.proofNote = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.confirmedAt = const Value.absent(),
    this.receiptNumber = const Value.absent(),
    this.receiptIssuedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String shomitiId,
    required String monthKey,
    required String memberId,
    required int amountBdt,
    required String method,
    required String reference,
    this.proofNote = const Value.absent(),
    required DateTime recordedAt,
    required DateTime confirmedAt,
    this.receiptNumber = const Value.absent(),
    this.receiptIssuedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       memberId = Value(memberId),
       amountBdt = Value(amountBdt),
       method = Value(method),
       reference = Value(reference),
       recordedAt = Value(recordedAt),
       confirmedAt = Value(confirmedAt);
  static Insertable<PaymentRow> custom({
    Expression<String>? id,
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? memberId,
    Expression<int>? amountBdt,
    Expression<String>? method,
    Expression<String>? reference,
    Expression<String>? proofNote,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? confirmedAt,
    Expression<String>? receiptNumber,
    Expression<DateTime>? receiptIssuedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (memberId != null) 'member_id': memberId,
      if (amountBdt != null) 'amount_bdt': amountBdt,
      if (method != null) 'method': method,
      if (reference != null) 'reference': reference,
      if (proofNote != null) 'proof_note': proofNote,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (confirmedAt != null) 'confirmed_at': confirmedAt,
      if (receiptNumber != null) 'receipt_number': receiptNumber,
      if (receiptIssuedAt != null) 'receipt_issued_at': receiptIssuedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? memberId,
    Value<int>? amountBdt,
    Value<String>? method,
    Value<String>? reference,
    Value<String?>? proofNote,
    Value<DateTime>? recordedAt,
    Value<DateTime>? confirmedAt,
    Value<String?>? receiptNumber,
    Value<DateTime?>? receiptIssuedAt,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      memberId: memberId ?? this.memberId,
      amountBdt: amountBdt ?? this.amountBdt,
      method: method ?? this.method,
      reference: reference ?? this.reference,
      proofNote: proofNote ?? this.proofNote,
      recordedAt: recordedAt ?? this.recordedAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      receiptIssuedAt: receiptIssuedAt ?? this.receiptIssuedAt,
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
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (amountBdt.present) {
      map['amount_bdt'] = Variable<int>(amountBdt.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (proofNote.present) {
      map['proof_note'] = Variable<String>(proofNote.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (confirmedAt.present) {
      map['confirmed_at'] = Variable<DateTime>(confirmedAt.value);
    }
    if (receiptNumber.present) {
      map['receipt_number'] = Variable<String>(receiptNumber.value);
    }
    if (receiptIssuedAt.present) {
      map['receipt_issued_at'] = Variable<DateTime>(receiptIssuedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('memberId: $memberId, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('proofNote: $proofNote, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('confirmedAt: $confirmedAt, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('receiptIssuedAt: $receiptIssuedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionResolutionsTable extends CollectionResolutions
    with TableInfo<$CollectionResolutionsTable, CollectionResolutionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionResolutionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountBdtMeta = const VerificationMeta(
    'amountBdt',
  );
  @override
  late final GeneratedColumn<int> amountBdt = GeneratedColumn<int>(
    'amount_bdt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    method,
    amountBdt,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_resolutions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionResolutionRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('amount_bdt')) {
      context.handle(
        _amountBdtMeta,
        amountBdt.isAcceptableOrUnknown(data['amount_bdt']!, _amountBdtMeta),
      );
    } else if (isInserting) {
      context.missing(_amountBdtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey};
  @override
  CollectionResolutionRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionResolutionRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      amountBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_bdt'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CollectionResolutionsTable createAlias(String alias) {
    return $CollectionResolutionsTable(attachedDatabase, alias);
  }
}

class CollectionResolutionRow extends DataClass
    implements Insertable<CollectionResolutionRow> {
  final String shomitiId;
  final String monthKey;

  /// reserve | guarantor
  final String method;

  /// Amount covered (BDT, taka).
  final int amountBdt;

  /// Optional note (avoid PII).
  final String? note;
  final DateTime createdAt;
  const CollectionResolutionRow({
    required this.shomitiId,
    required this.monthKey,
    required this.method,
    required this.amountBdt,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['method'] = Variable<String>(method);
    map['amount_bdt'] = Variable<int>(amountBdt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CollectionResolutionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionResolutionsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      method: Value(method),
      amountBdt: Value(amountBdt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory CollectionResolutionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionResolutionRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      method: serializer.fromJson<String>(json['method']),
      amountBdt: serializer.fromJson<int>(json['amountBdt']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'method': serializer.toJson<String>(method),
      'amountBdt': serializer.toJson<int>(amountBdt),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CollectionResolutionRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? method,
    int? amountBdt,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => CollectionResolutionRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    method: method ?? this.method,
    amountBdt: amountBdt ?? this.amountBdt,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  CollectionResolutionRow copyWithCompanion(
    CollectionResolutionsCompanion data,
  ) {
    return CollectionResolutionRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      method: data.method.present ? data.method.value : this.method,
      amountBdt: data.amountBdt.present ? data.amountBdt.value : this.amountBdt,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionResolutionRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('method: $method, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(shomitiId, monthKey, method, amountBdt, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionResolutionRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.method == this.method &&
          other.amountBdt == this.amountBdt &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class CollectionResolutionsCompanion
    extends UpdateCompanion<CollectionResolutionRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> method;
  final Value<int> amountBdt;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CollectionResolutionsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.method = const Value.absent(),
    this.amountBdt = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionResolutionsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String method,
    required int amountBdt,
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       method = Value(method),
       amountBdt = Value(amountBdt),
       createdAt = Value(createdAt);
  static Insertable<CollectionResolutionRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? method,
    Expression<int>? amountBdt,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (method != null) 'method': method,
      if (amountBdt != null) 'amount_bdt': amountBdt,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionResolutionsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? method,
    Value<int>? amountBdt,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CollectionResolutionsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      method: method ?? this.method,
      amountBdt: amountBdt ?? this.amountBdt,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (amountBdt.present) {
      map['amount_bdt'] = Variable<int>(amountBdt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionResolutionsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('method: $method, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DefaultEnforcementStepsTable extends DefaultEnforcementSteps
    with TableInfo<$DefaultEnforcementStepsTable, DefaultEnforcementStepRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DefaultEnforcementStepsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _episodeKeyMeta = const VerificationMeta(
    'episodeKey',
  );
  @override
  late final GeneratedColumn<String> episodeKey = GeneratedColumn<String>(
    'episode_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepTypeMeta = const VerificationMeta(
    'stepType',
  );
  @override
  late final GeneratedColumn<String> stepType = GeneratedColumn<String>(
    'step_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  static const VerificationMeta _amountBdtMeta = const VerificationMeta(
    'amountBdt',
  );
  @override
  late final GeneratedColumn<int> amountBdt = GeneratedColumn<int>(
    'amount_bdt',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shomitiId,
    memberId,
    episodeKey,
    stepType,
    ruleSetVersionId,
    recordedAt,
    note,
    amountBdt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'default_enforcement_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<DefaultEnforcementStepRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shomiti_id')) {
      context.handle(
        _shomitiIdMeta,
        shomitiId.isAcceptableOrUnknown(data['shomiti_id']!, _shomitiIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shomitiIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('episode_key')) {
      context.handle(
        _episodeKeyMeta,
        episodeKey.isAcceptableOrUnknown(data['episode_key']!, _episodeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_episodeKeyMeta);
    }
    if (data.containsKey('step_type')) {
      context.handle(
        _stepTypeMeta,
        stepType.isAcceptableOrUnknown(data['step_type']!, _stepTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_stepTypeMeta);
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
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('amount_bdt')) {
      context.handle(
        _amountBdtMeta,
        amountBdt.isAcceptableOrUnknown(data['amount_bdt']!, _amountBdtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {shomitiId, memberId, episodeKey, stepType},
  ];
  @override
  DefaultEnforcementStepRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DefaultEnforcementStepRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      episodeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_key'],
      )!,
      stepType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_type'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      amountBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_bdt'],
      ),
    );
  }

  @override
  $DefaultEnforcementStepsTable createAlias(String alias) {
    return $DefaultEnforcementStepsTable(attachedDatabase, alias);
  }
}

class DefaultEnforcementStepRow extends DataClass
    implements Insertable<DefaultEnforcementStepRow> {
  final int id;
  final String shomitiId;
  final String memberId;

  /// Identifier for the current default episode (BillingMonth key of the
  /// earliest missed payment in the current consecutive streak).
  final String episodeKey;

  /// Enforcement step type (reminder/notice/guarantor_or_deposit/dispute).
  final String stepType;
  final String ruleSetVersionId;
  final DateTime recordedAt;
  final String? note;

  /// Optional: amount covered when applying guarantor/deposit (BDT).
  final int? amountBdt;
  const DefaultEnforcementStepRow({
    required this.id,
    required this.shomitiId,
    required this.memberId,
    required this.episodeKey,
    required this.stepType,
    required this.ruleSetVersionId,
    required this.recordedAt,
    this.note,
    this.amountBdt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['member_id'] = Variable<String>(memberId);
    map['episode_key'] = Variable<String>(episodeKey);
    map['step_type'] = Variable<String>(stepType);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || amountBdt != null) {
      map['amount_bdt'] = Variable<int>(amountBdt);
    }
    return map;
  }

  DefaultEnforcementStepsCompanion toCompanion(bool nullToAbsent) {
    return DefaultEnforcementStepsCompanion(
      id: Value(id),
      shomitiId: Value(shomitiId),
      memberId: Value(memberId),
      episodeKey: Value(episodeKey),
      stepType: Value(stepType),
      ruleSetVersionId: Value(ruleSetVersionId),
      recordedAt: Value(recordedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      amountBdt: amountBdt == null && nullToAbsent
          ? const Value.absent()
          : Value(amountBdt),
    );
  }

  factory DefaultEnforcementStepRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DefaultEnforcementStepRow(
      id: serializer.fromJson<int>(json['id']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      episodeKey: serializer.fromJson<String>(json['episodeKey']),
      stepType: serializer.fromJson<String>(json['stepType']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      note: serializer.fromJson<String?>(json['note']),
      amountBdt: serializer.fromJson<int?>(json['amountBdt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'memberId': serializer.toJson<String>(memberId),
      'episodeKey': serializer.toJson<String>(episodeKey),
      'stepType': serializer.toJson<String>(stepType),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'note': serializer.toJson<String?>(note),
      'amountBdt': serializer.toJson<int?>(amountBdt),
    };
  }

  DefaultEnforcementStepRow copyWith({
    int? id,
    String? shomitiId,
    String? memberId,
    String? episodeKey,
    String? stepType,
    String? ruleSetVersionId,
    DateTime? recordedAt,
    Value<String?> note = const Value.absent(),
    Value<int?> amountBdt = const Value.absent(),
  }) => DefaultEnforcementStepRow(
    id: id ?? this.id,
    shomitiId: shomitiId ?? this.shomitiId,
    memberId: memberId ?? this.memberId,
    episodeKey: episodeKey ?? this.episodeKey,
    stepType: stepType ?? this.stepType,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    recordedAt: recordedAt ?? this.recordedAt,
    note: note.present ? note.value : this.note,
    amountBdt: amountBdt.present ? amountBdt.value : this.amountBdt,
  );
  DefaultEnforcementStepRow copyWithCompanion(
    DefaultEnforcementStepsCompanion data,
  ) {
    return DefaultEnforcementStepRow(
      id: data.id.present ? data.id.value : this.id,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      episodeKey: data.episodeKey.present
          ? data.episodeKey.value
          : this.episodeKey,
      stepType: data.stepType.present ? data.stepType.value : this.stepType,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      note: data.note.present ? data.note.value : this.note,
      amountBdt: data.amountBdt.present ? data.amountBdt.value : this.amountBdt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DefaultEnforcementStepRow(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('episodeKey: $episodeKey, ')
          ..write('stepType: $stepType, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('note: $note, ')
          ..write('amountBdt: $amountBdt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shomitiId,
    memberId,
    episodeKey,
    stepType,
    ruleSetVersionId,
    recordedAt,
    note,
    amountBdt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DefaultEnforcementStepRow &&
          other.id == this.id &&
          other.shomitiId == this.shomitiId &&
          other.memberId == this.memberId &&
          other.episodeKey == this.episodeKey &&
          other.stepType == this.stepType &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.recordedAt == this.recordedAt &&
          other.note == this.note &&
          other.amountBdt == this.amountBdt);
}

class DefaultEnforcementStepsCompanion
    extends UpdateCompanion<DefaultEnforcementStepRow> {
  final Value<int> id;
  final Value<String> shomitiId;
  final Value<String> memberId;
  final Value<String> episodeKey;
  final Value<String> stepType;
  final Value<String> ruleSetVersionId;
  final Value<DateTime> recordedAt;
  final Value<String?> note;
  final Value<int?> amountBdt;
  const DefaultEnforcementStepsCompanion({
    this.id = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.episodeKey = const Value.absent(),
    this.stepType = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.note = const Value.absent(),
    this.amountBdt = const Value.absent(),
  });
  DefaultEnforcementStepsCompanion.insert({
    this.id = const Value.absent(),
    required String shomitiId,
    required String memberId,
    required String episodeKey,
    required String stepType,
    required String ruleSetVersionId,
    required DateTime recordedAt,
    this.note = const Value.absent(),
    this.amountBdt = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       memberId = Value(memberId),
       episodeKey = Value(episodeKey),
       stepType = Value(stepType),
       ruleSetVersionId = Value(ruleSetVersionId),
       recordedAt = Value(recordedAt);
  static Insertable<DefaultEnforcementStepRow> custom({
    Expression<int>? id,
    Expression<String>? shomitiId,
    Expression<String>? memberId,
    Expression<String>? episodeKey,
    Expression<String>? stepType,
    Expression<String>? ruleSetVersionId,
    Expression<DateTime>? recordedAt,
    Expression<String>? note,
    Expression<int>? amountBdt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (memberId != null) 'member_id': memberId,
      if (episodeKey != null) 'episode_key': episodeKey,
      if (stepType != null) 'step_type': stepType,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (note != null) 'note': note,
      if (amountBdt != null) 'amount_bdt': amountBdt,
    });
  }

  DefaultEnforcementStepsCompanion copyWith({
    Value<int>? id,
    Value<String>? shomitiId,
    Value<String>? memberId,
    Value<String>? episodeKey,
    Value<String>? stepType,
    Value<String>? ruleSetVersionId,
    Value<DateTime>? recordedAt,
    Value<String?>? note,
    Value<int?>? amountBdt,
  }) {
    return DefaultEnforcementStepsCompanion(
      id: id ?? this.id,
      shomitiId: shomitiId ?? this.shomitiId,
      memberId: memberId ?? this.memberId,
      episodeKey: episodeKey ?? this.episodeKey,
      stepType: stepType ?? this.stepType,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      recordedAt: recordedAt ?? this.recordedAt,
      note: note ?? this.note,
      amountBdt: amountBdt ?? this.amountBdt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (episodeKey.present) {
      map['episode_key'] = Variable<String>(episodeKey.value);
    }
    if (stepType.present) {
      map['step_type'] = Variable<String>(stepType.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (amountBdt.present) {
      map['amount_bdt'] = Variable<int>(amountBdt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DefaultEnforcementStepsCompanion(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('memberId: $memberId, ')
          ..write('episodeKey: $episodeKey, ')
          ..write('stepType: $stepType, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('note: $note, ')
          ..write('amountBdt: $amountBdt')
          ..write(')'))
        .toString();
  }
}

class $DrawRecordsTable extends DrawRecords
    with TableInfo<$DrawRecordsTable, DrawRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrawRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _winnerMemberIdMeta = const VerificationMeta(
    'winnerMemberId',
  );
  @override
  late final GeneratedColumn<String> winnerMemberId = GeneratedColumn<String>(
    'winner_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winnerShareIndexMeta = const VerificationMeta(
    'winnerShareIndex',
  );
  @override
  late final GeneratedColumn<int> winnerShareIndex = GeneratedColumn<int>(
    'winner_share_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eligibleShareKeysJsonMeta =
      const VerificationMeta('eligibleShareKeysJson');
  @override
  late final GeneratedColumn<String> eligibleShareKeysJson =
      GeneratedColumn<String>(
        'eligible_share_keys_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _redoOfDrawIdMeta = const VerificationMeta(
    'redoOfDrawId',
  );
  @override
  late final GeneratedColumn<String> redoOfDrawId = GeneratedColumn<String>(
    'redo_of_draw_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invalidatedAtMeta = const VerificationMeta(
    'invalidatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> invalidatedAt =
      GeneratedColumn<DateTime>(
        'invalidated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _invalidatedReasonMeta = const VerificationMeta(
    'invalidatedReason',
  );
  @override
  late final GeneratedColumn<String> invalidatedReason =
      GeneratedColumn<String>(
        'invalidated_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _finalizedAtMeta = const VerificationMeta(
    'finalizedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finalizedAt = GeneratedColumn<DateTime>(
    'finalized_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shomitiId,
    monthKey,
    ruleSetVersionId,
    method,
    proofReference,
    notes,
    winnerMemberId,
    winnerShareIndex,
    eligibleShareKeysJson,
    redoOfDrawId,
    invalidatedAt,
    invalidatedReason,
    finalizedAt,
    recordedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draw_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrawRecordRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
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
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
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
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('winner_member_id')) {
      context.handle(
        _winnerMemberIdMeta,
        winnerMemberId.isAcceptableOrUnknown(
          data['winner_member_id']!,
          _winnerMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winnerMemberIdMeta);
    }
    if (data.containsKey('winner_share_index')) {
      context.handle(
        _winnerShareIndexMeta,
        winnerShareIndex.isAcceptableOrUnknown(
          data['winner_share_index']!,
          _winnerShareIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winnerShareIndexMeta);
    }
    if (data.containsKey('eligible_share_keys_json')) {
      context.handle(
        _eligibleShareKeysJsonMeta,
        eligibleShareKeysJson.isAcceptableOrUnknown(
          data['eligible_share_keys_json']!,
          _eligibleShareKeysJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eligibleShareKeysJsonMeta);
    }
    if (data.containsKey('redo_of_draw_id')) {
      context.handle(
        _redoOfDrawIdMeta,
        redoOfDrawId.isAcceptableOrUnknown(
          data['redo_of_draw_id']!,
          _redoOfDrawIdMeta,
        ),
      );
    }
    if (data.containsKey('invalidated_at')) {
      context.handle(
        _invalidatedAtMeta,
        invalidatedAt.isAcceptableOrUnknown(
          data['invalidated_at']!,
          _invalidatedAtMeta,
        ),
      );
    }
    if (data.containsKey('invalidated_reason')) {
      context.handle(
        _invalidatedReasonMeta,
        invalidatedReason.isAcceptableOrUnknown(
          data['invalidated_reason']!,
          _invalidatedReasonMeta,
        ),
      );
    }
    if (data.containsKey('finalized_at')) {
      context.handle(
        _finalizedAtMeta,
        finalizedAt.isAcceptableOrUnknown(
          data['finalized_at']!,
          _finalizedAtMeta,
        ),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrawRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrawRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      proofReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_reference'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      winnerMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner_member_id'],
      )!,
      winnerShareIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}winner_share_index'],
      )!,
      eligibleShareKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}eligible_share_keys_json'],
      )!,
      redoOfDrawId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}redo_of_draw_id'],
      ),
      invalidatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invalidated_at'],
      ),
      invalidatedReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invalidated_reason'],
      ),
      finalizedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finalized_at'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $DrawRecordsTable createAlias(String alias) {
    return $DrawRecordsTable(attachedDatabase, alias);
  }
}

class DrawRecordRow extends DataClass implements Insertable<DrawRecordRow> {
  final String id;
  final String shomitiId;

  /// YYYY-MM (e.g. 2026-02)
  final String monthKey;
  final String ruleSetVersionId;

  /// Storage value for draw method (see DrawMethodStorage).
  final String method;

  /// Video/screenshot/link id.
  final String proofReference;
  final String? notes;
  final String winnerMemberId;

  /// 1-based share index within the winner member's shares for this month.
  final int winnerShareIndex;

  /// JSON array of eligible share entry keys at record time.
  final String eligibleShareKeysJson;

  /// Optional linkage when this record is a redo of a previous record.
  final String? redoOfDrawId;

  /// Set when the draw is invalidated (redo flow). Invalidated draws are not
  /// effective for eligibility/winner exclusion.
  final DateTime? invalidatedAt;

  /// Required when invalidating a draw.
  final String? invalidatedReason;

  /// Set when witness approvals are complete and the draw is finalized.
  final DateTime? finalizedAt;
  final DateTime recordedAt;
  const DrawRecordRow({
    required this.id,
    required this.shomitiId,
    required this.monthKey,
    required this.ruleSetVersionId,
    required this.method,
    required this.proofReference,
    this.notes,
    required this.winnerMemberId,
    required this.winnerShareIndex,
    required this.eligibleShareKeysJson,
    this.redoOfDrawId,
    this.invalidatedAt,
    this.invalidatedReason,
    this.finalizedAt,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['method'] = Variable<String>(method);
    map['proof_reference'] = Variable<String>(proofReference);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['winner_member_id'] = Variable<String>(winnerMemberId);
    map['winner_share_index'] = Variable<int>(winnerShareIndex);
    map['eligible_share_keys_json'] = Variable<String>(eligibleShareKeysJson);
    if (!nullToAbsent || redoOfDrawId != null) {
      map['redo_of_draw_id'] = Variable<String>(redoOfDrawId);
    }
    if (!nullToAbsent || invalidatedAt != null) {
      map['invalidated_at'] = Variable<DateTime>(invalidatedAt);
    }
    if (!nullToAbsent || invalidatedReason != null) {
      map['invalidated_reason'] = Variable<String>(invalidatedReason);
    }
    if (!nullToAbsent || finalizedAt != null) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  DrawRecordsCompanion toCompanion(bool nullToAbsent) {
    return DrawRecordsCompanion(
      id: Value(id),
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      ruleSetVersionId: Value(ruleSetVersionId),
      method: Value(method),
      proofReference: Value(proofReference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      winnerMemberId: Value(winnerMemberId),
      winnerShareIndex: Value(winnerShareIndex),
      eligibleShareKeysJson: Value(eligibleShareKeysJson),
      redoOfDrawId: redoOfDrawId == null && nullToAbsent
          ? const Value.absent()
          : Value(redoOfDrawId),
      invalidatedAt: invalidatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(invalidatedAt),
      invalidatedReason: invalidatedReason == null && nullToAbsent
          ? const Value.absent()
          : Value(invalidatedReason),
      finalizedAt: finalizedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finalizedAt),
      recordedAt: Value(recordedAt),
    );
  }

  factory DrawRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrawRecordRow(
      id: serializer.fromJson<String>(json['id']),
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      method: serializer.fromJson<String>(json['method']),
      proofReference: serializer.fromJson<String>(json['proofReference']),
      notes: serializer.fromJson<String?>(json['notes']),
      winnerMemberId: serializer.fromJson<String>(json['winnerMemberId']),
      winnerShareIndex: serializer.fromJson<int>(json['winnerShareIndex']),
      eligibleShareKeysJson: serializer.fromJson<String>(
        json['eligibleShareKeysJson'],
      ),
      redoOfDrawId: serializer.fromJson<String?>(json['redoOfDrawId']),
      invalidatedAt: serializer.fromJson<DateTime?>(json['invalidatedAt']),
      invalidatedReason: serializer.fromJson<String?>(
        json['invalidatedReason'],
      ),
      finalizedAt: serializer.fromJson<DateTime?>(json['finalizedAt']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'method': serializer.toJson<String>(method),
      'proofReference': serializer.toJson<String>(proofReference),
      'notes': serializer.toJson<String?>(notes),
      'winnerMemberId': serializer.toJson<String>(winnerMemberId),
      'winnerShareIndex': serializer.toJson<int>(winnerShareIndex),
      'eligibleShareKeysJson': serializer.toJson<String>(eligibleShareKeysJson),
      'redoOfDrawId': serializer.toJson<String?>(redoOfDrawId),
      'invalidatedAt': serializer.toJson<DateTime?>(invalidatedAt),
      'invalidatedReason': serializer.toJson<String?>(invalidatedReason),
      'finalizedAt': serializer.toJson<DateTime?>(finalizedAt),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  DrawRecordRow copyWith({
    String? id,
    String? shomitiId,
    String? monthKey,
    String? ruleSetVersionId,
    String? method,
    String? proofReference,
    Value<String?> notes = const Value.absent(),
    String? winnerMemberId,
    int? winnerShareIndex,
    String? eligibleShareKeysJson,
    Value<String?> redoOfDrawId = const Value.absent(),
    Value<DateTime?> invalidatedAt = const Value.absent(),
    Value<String?> invalidatedReason = const Value.absent(),
    Value<DateTime?> finalizedAt = const Value.absent(),
    DateTime? recordedAt,
  }) => DrawRecordRow(
    id: id ?? this.id,
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    method: method ?? this.method,
    proofReference: proofReference ?? this.proofReference,
    notes: notes.present ? notes.value : this.notes,
    winnerMemberId: winnerMemberId ?? this.winnerMemberId,
    winnerShareIndex: winnerShareIndex ?? this.winnerShareIndex,
    eligibleShareKeysJson: eligibleShareKeysJson ?? this.eligibleShareKeysJson,
    redoOfDrawId: redoOfDrawId.present ? redoOfDrawId.value : this.redoOfDrawId,
    invalidatedAt: invalidatedAt.present
        ? invalidatedAt.value
        : this.invalidatedAt,
    invalidatedReason: invalidatedReason.present
        ? invalidatedReason.value
        : this.invalidatedReason,
    finalizedAt: finalizedAt.present ? finalizedAt.value : this.finalizedAt,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  DrawRecordRow copyWithCompanion(DrawRecordsCompanion data) {
    return DrawRecordRow(
      id: data.id.present ? data.id.value : this.id,
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      method: data.method.present ? data.method.value : this.method,
      proofReference: data.proofReference.present
          ? data.proofReference.value
          : this.proofReference,
      notes: data.notes.present ? data.notes.value : this.notes,
      winnerMemberId: data.winnerMemberId.present
          ? data.winnerMemberId.value
          : this.winnerMemberId,
      winnerShareIndex: data.winnerShareIndex.present
          ? data.winnerShareIndex.value
          : this.winnerShareIndex,
      eligibleShareKeysJson: data.eligibleShareKeysJson.present
          ? data.eligibleShareKeysJson.value
          : this.eligibleShareKeysJson,
      redoOfDrawId: data.redoOfDrawId.present
          ? data.redoOfDrawId.value
          : this.redoOfDrawId,
      invalidatedAt: data.invalidatedAt.present
          ? data.invalidatedAt.value
          : this.invalidatedAt,
      invalidatedReason: data.invalidatedReason.present
          ? data.invalidatedReason.value
          : this.invalidatedReason,
      finalizedAt: data.finalizedAt.present
          ? data.finalizedAt.value
          : this.finalizedAt,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrawRecordRow(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('method: $method, ')
          ..write('proofReference: $proofReference, ')
          ..write('notes: $notes, ')
          ..write('winnerMemberId: $winnerMemberId, ')
          ..write('winnerShareIndex: $winnerShareIndex, ')
          ..write('eligibleShareKeysJson: $eligibleShareKeysJson, ')
          ..write('redoOfDrawId: $redoOfDrawId, ')
          ..write('invalidatedAt: $invalidatedAt, ')
          ..write('invalidatedReason: $invalidatedReason, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shomitiId,
    monthKey,
    ruleSetVersionId,
    method,
    proofReference,
    notes,
    winnerMemberId,
    winnerShareIndex,
    eligibleShareKeysJson,
    redoOfDrawId,
    invalidatedAt,
    invalidatedReason,
    finalizedAt,
    recordedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrawRecordRow &&
          other.id == this.id &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.method == this.method &&
          other.proofReference == this.proofReference &&
          other.notes == this.notes &&
          other.winnerMemberId == this.winnerMemberId &&
          other.winnerShareIndex == this.winnerShareIndex &&
          other.eligibleShareKeysJson == this.eligibleShareKeysJson &&
          other.redoOfDrawId == this.redoOfDrawId &&
          other.invalidatedAt == this.invalidatedAt &&
          other.invalidatedReason == this.invalidatedReason &&
          other.finalizedAt == this.finalizedAt &&
          other.recordedAt == this.recordedAt);
}

class DrawRecordsCompanion extends UpdateCompanion<DrawRecordRow> {
  final Value<String> id;
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> ruleSetVersionId;
  final Value<String> method;
  final Value<String> proofReference;
  final Value<String?> notes;
  final Value<String> winnerMemberId;
  final Value<int> winnerShareIndex;
  final Value<String> eligibleShareKeysJson;
  final Value<String?> redoOfDrawId;
  final Value<DateTime?> invalidatedAt;
  final Value<String?> invalidatedReason;
  final Value<DateTime?> finalizedAt;
  final Value<DateTime> recordedAt;
  final Value<int> rowid;
  const DrawRecordsCompanion({
    this.id = const Value.absent(),
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.method = const Value.absent(),
    this.proofReference = const Value.absent(),
    this.notes = const Value.absent(),
    this.winnerMemberId = const Value.absent(),
    this.winnerShareIndex = const Value.absent(),
    this.eligibleShareKeysJson = const Value.absent(),
    this.redoOfDrawId = const Value.absent(),
    this.invalidatedAt = const Value.absent(),
    this.invalidatedReason = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrawRecordsCompanion.insert({
    required String id,
    required String shomitiId,
    required String monthKey,
    required String ruleSetVersionId,
    required String method,
    required String proofReference,
    this.notes = const Value.absent(),
    required String winnerMemberId,
    required int winnerShareIndex,
    required String eligibleShareKeysJson,
    this.redoOfDrawId = const Value.absent(),
    this.invalidatedAt = const Value.absent(),
    this.invalidatedReason = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    required DateTime recordedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       ruleSetVersionId = Value(ruleSetVersionId),
       method = Value(method),
       proofReference = Value(proofReference),
       winnerMemberId = Value(winnerMemberId),
       winnerShareIndex = Value(winnerShareIndex),
       eligibleShareKeysJson = Value(eligibleShareKeysJson),
       recordedAt = Value(recordedAt);
  static Insertable<DrawRecordRow> custom({
    Expression<String>? id,
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? ruleSetVersionId,
    Expression<String>? method,
    Expression<String>? proofReference,
    Expression<String>? notes,
    Expression<String>? winnerMemberId,
    Expression<int>? winnerShareIndex,
    Expression<String>? eligibleShareKeysJson,
    Expression<String>? redoOfDrawId,
    Expression<DateTime>? invalidatedAt,
    Expression<String>? invalidatedReason,
    Expression<DateTime>? finalizedAt,
    Expression<DateTime>? recordedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (method != null) 'method': method,
      if (proofReference != null) 'proof_reference': proofReference,
      if (notes != null) 'notes': notes,
      if (winnerMemberId != null) 'winner_member_id': winnerMemberId,
      if (winnerShareIndex != null) 'winner_share_index': winnerShareIndex,
      if (eligibleShareKeysJson != null)
        'eligible_share_keys_json': eligibleShareKeysJson,
      if (redoOfDrawId != null) 'redo_of_draw_id': redoOfDrawId,
      if (invalidatedAt != null) 'invalidated_at': invalidatedAt,
      if (invalidatedReason != null) 'invalidated_reason': invalidatedReason,
      if (finalizedAt != null) 'finalized_at': finalizedAt,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrawRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? ruleSetVersionId,
    Value<String>? method,
    Value<String>? proofReference,
    Value<String?>? notes,
    Value<String>? winnerMemberId,
    Value<int>? winnerShareIndex,
    Value<String>? eligibleShareKeysJson,
    Value<String?>? redoOfDrawId,
    Value<DateTime?>? invalidatedAt,
    Value<String?>? invalidatedReason,
    Value<DateTime?>? finalizedAt,
    Value<DateTime>? recordedAt,
    Value<int>? rowid,
  }) {
    return DrawRecordsCompanion(
      id: id ?? this.id,
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      method: method ?? this.method,
      proofReference: proofReference ?? this.proofReference,
      notes: notes ?? this.notes,
      winnerMemberId: winnerMemberId ?? this.winnerMemberId,
      winnerShareIndex: winnerShareIndex ?? this.winnerShareIndex,
      eligibleShareKeysJson:
          eligibleShareKeysJson ?? this.eligibleShareKeysJson,
      redoOfDrawId: redoOfDrawId ?? this.redoOfDrawId,
      invalidatedAt: invalidatedAt ?? this.invalidatedAt,
      invalidatedReason: invalidatedReason ?? this.invalidatedReason,
      finalizedAt: finalizedAt ?? this.finalizedAt,
      recordedAt: recordedAt ?? this.recordedAt,
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
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (proofReference.present) {
      map['proof_reference'] = Variable<String>(proofReference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (winnerMemberId.present) {
      map['winner_member_id'] = Variable<String>(winnerMemberId.value);
    }
    if (winnerShareIndex.present) {
      map['winner_share_index'] = Variable<int>(winnerShareIndex.value);
    }
    if (eligibleShareKeysJson.present) {
      map['eligible_share_keys_json'] = Variable<String>(
        eligibleShareKeysJson.value,
      );
    }
    if (redoOfDrawId.present) {
      map['redo_of_draw_id'] = Variable<String>(redoOfDrawId.value);
    }
    if (invalidatedAt.present) {
      map['invalidated_at'] = Variable<DateTime>(invalidatedAt.value);
    }
    if (invalidatedReason.present) {
      map['invalidated_reason'] = Variable<String>(invalidatedReason.value);
    }
    if (finalizedAt.present) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrawRecordsCompanion(')
          ..write('id: $id, ')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('method: $method, ')
          ..write('proofReference: $proofReference, ')
          ..write('notes: $notes, ')
          ..write('winnerMemberId: $winnerMemberId, ')
          ..write('winnerShareIndex: $winnerShareIndex, ')
          ..write('eligibleShareKeysJson: $eligibleShareKeysJson, ')
          ..write('redoOfDrawId: $redoOfDrawId, ')
          ..write('invalidatedAt: $invalidatedAt, ')
          ..write('invalidatedReason: $invalidatedReason, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrawWitnessApprovalsTable extends DrawWitnessApprovals
    with TableInfo<$DrawWitnessApprovalsTable, DrawWitnessApprovalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrawWitnessApprovalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _drawIdMeta = const VerificationMeta('drawId');
  @override
  late final GeneratedColumn<String> drawId = GeneratedColumn<String>(
    'draw_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES draw_records (id)',
    ),
  );
  static const VerificationMeta _witnessMemberIdMeta = const VerificationMeta(
    'witnessMemberId',
  );
  @override
  late final GeneratedColumn<String> witnessMemberId = GeneratedColumn<String>(
    'witness_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
    'approved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    drawId,
    witnessMemberId,
    ruleSetVersionId,
    note,
    approvedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draw_witness_approvals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrawWitnessApprovalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('draw_id')) {
      context.handle(
        _drawIdMeta,
        drawId.isAcceptableOrUnknown(data['draw_id']!, _drawIdMeta),
      );
    } else if (isInserting) {
      context.missing(_drawIdMeta);
    }
    if (data.containsKey('witness_member_id')) {
      context.handle(
        _witnessMemberIdMeta,
        witnessMemberId.isAcceptableOrUnknown(
          data['witness_member_id']!,
          _witnessMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_witnessMemberIdMeta);
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
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_approvedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {drawId, witnessMemberId};
  @override
  DrawWitnessApprovalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrawWitnessApprovalRow(
      drawId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draw_id'],
      )!,
      witnessMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}witness_member_id'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      )!,
    );
  }

  @override
  $DrawWitnessApprovalsTable createAlias(String alias) {
    return $DrawWitnessApprovalsTable(attachedDatabase, alias);
  }
}

class DrawWitnessApprovalRow extends DataClass
    implements Insertable<DrawWitnessApprovalRow> {
  final String drawId;
  final String witnessMemberId;
  final String ruleSetVersionId;
  final String? note;
  final DateTime approvedAt;
  const DrawWitnessApprovalRow({
    required this.drawId,
    required this.witnessMemberId,
    required this.ruleSetVersionId,
    this.note,
    required this.approvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['draw_id'] = Variable<String>(drawId);
    map['witness_member_id'] = Variable<String>(witnessMemberId);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['approved_at'] = Variable<DateTime>(approvedAt);
    return map;
  }

  DrawWitnessApprovalsCompanion toCompanion(bool nullToAbsent) {
    return DrawWitnessApprovalsCompanion(
      drawId: Value(drawId),
      witnessMemberId: Value(witnessMemberId),
      ruleSetVersionId: Value(ruleSetVersionId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      approvedAt: Value(approvedAt),
    );
  }

  factory DrawWitnessApprovalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrawWitnessApprovalRow(
      drawId: serializer.fromJson<String>(json['drawId']),
      witnessMemberId: serializer.fromJson<String>(json['witnessMemberId']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      note: serializer.fromJson<String?>(json['note']),
      approvedAt: serializer.fromJson<DateTime>(json['approvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'drawId': serializer.toJson<String>(drawId),
      'witnessMemberId': serializer.toJson<String>(witnessMemberId),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'note': serializer.toJson<String?>(note),
      'approvedAt': serializer.toJson<DateTime>(approvedAt),
    };
  }

  DrawWitnessApprovalRow copyWith({
    String? drawId,
    String? witnessMemberId,
    String? ruleSetVersionId,
    Value<String?> note = const Value.absent(),
    DateTime? approvedAt,
  }) => DrawWitnessApprovalRow(
    drawId: drawId ?? this.drawId,
    witnessMemberId: witnessMemberId ?? this.witnessMemberId,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    note: note.present ? note.value : this.note,
    approvedAt: approvedAt ?? this.approvedAt,
  );
  DrawWitnessApprovalRow copyWithCompanion(DrawWitnessApprovalsCompanion data) {
    return DrawWitnessApprovalRow(
      drawId: data.drawId.present ? data.drawId.value : this.drawId,
      witnessMemberId: data.witnessMemberId.present
          ? data.witnessMemberId.value
          : this.witnessMemberId,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      note: data.note.present ? data.note.value : this.note,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrawWitnessApprovalRow(')
          ..write('drawId: $drawId, ')
          ..write('witnessMemberId: $witnessMemberId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('note: $note, ')
          ..write('approvedAt: $approvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(drawId, witnessMemberId, ruleSetVersionId, note, approvedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrawWitnessApprovalRow &&
          other.drawId == this.drawId &&
          other.witnessMemberId == this.witnessMemberId &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.note == this.note &&
          other.approvedAt == this.approvedAt);
}

class DrawWitnessApprovalsCompanion
    extends UpdateCompanion<DrawWitnessApprovalRow> {
  final Value<String> drawId;
  final Value<String> witnessMemberId;
  final Value<String> ruleSetVersionId;
  final Value<String?> note;
  final Value<DateTime> approvedAt;
  final Value<int> rowid;
  const DrawWitnessApprovalsCompanion({
    this.drawId = const Value.absent(),
    this.witnessMemberId = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.note = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrawWitnessApprovalsCompanion.insert({
    required String drawId,
    required String witnessMemberId,
    required String ruleSetVersionId,
    this.note = const Value.absent(),
    required DateTime approvedAt,
    this.rowid = const Value.absent(),
  }) : drawId = Value(drawId),
       witnessMemberId = Value(witnessMemberId),
       ruleSetVersionId = Value(ruleSetVersionId),
       approvedAt = Value(approvedAt);
  static Insertable<DrawWitnessApprovalRow> custom({
    Expression<String>? drawId,
    Expression<String>? witnessMemberId,
    Expression<String>? ruleSetVersionId,
    Expression<String>? note,
    Expression<DateTime>? approvedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (drawId != null) 'draw_id': drawId,
      if (witnessMemberId != null) 'witness_member_id': witnessMemberId,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (note != null) 'note': note,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrawWitnessApprovalsCompanion copyWith({
    Value<String>? drawId,
    Value<String>? witnessMemberId,
    Value<String>? ruleSetVersionId,
    Value<String?>? note,
    Value<DateTime>? approvedAt,
    Value<int>? rowid,
  }) {
    return DrawWitnessApprovalsCompanion(
      drawId: drawId ?? this.drawId,
      witnessMemberId: witnessMemberId ?? this.witnessMemberId,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      note: note ?? this.note,
      approvedAt: approvedAt ?? this.approvedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (drawId.present) {
      map['draw_id'] = Variable<String>(drawId.value);
    }
    if (witnessMemberId.present) {
      map['witness_member_id'] = Variable<String>(witnessMemberId.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrawWitnessApprovalsCompanion(')
          ..write('drawId: $drawId, ')
          ..write('witnessMemberId: $witnessMemberId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('note: $note, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyStatementsTable extends MonthlyStatements
    with TableInfo<$MonthlyStatementsTable, MonthlyStatementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyStatementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    ruleSetVersionId,
    json,
    generatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_statements';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyStatementRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
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
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey};
  @override
  MonthlyStatementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyStatementRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      json: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $MonthlyStatementsTable createAlias(String alias) {
    return $MonthlyStatementsTable(attachedDatabase, alias);
  }
}

class MonthlyStatementRow extends DataClass
    implements Insertable<MonthlyStatementRow> {
  final String shomitiId;
  final String monthKey;
  final String ruleSetVersionId;

  /// Statement snapshot JSON (avoid PII).
  final String json;
  final DateTime generatedAt;
  const MonthlyStatementRow({
    required this.shomitiId,
    required this.monthKey,
    required this.ruleSetVersionId,
    required this.json,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['json'] = Variable<String>(json);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  MonthlyStatementsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyStatementsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      ruleSetVersionId: Value(ruleSetVersionId),
      json: Value(json),
      generatedAt: Value(generatedAt),
    );
  }

  factory MonthlyStatementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyStatementRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      json: serializer.fromJson<String>(json['json']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'json': serializer.toJson<String>(json),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  MonthlyStatementRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? ruleSetVersionId,
    String? json,
    DateTime? generatedAt,
  }) => MonthlyStatementRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    json: json ?? this.json,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  MonthlyStatementRow copyWithCompanion(MonthlyStatementsCompanion data) {
    return MonthlyStatementRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      json: data.json.present ? data.json.value : this.json,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyStatementRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('json: $json, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(shomitiId, monthKey, ruleSetVersionId, json, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyStatementRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.json == this.json &&
          other.generatedAt == this.generatedAt);
}

class MonthlyStatementsCompanion extends UpdateCompanion<MonthlyStatementRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> ruleSetVersionId;
  final Value<String> json;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const MonthlyStatementsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.json = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyStatementsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String ruleSetVersionId,
    required String json,
    required DateTime generatedAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       ruleSetVersionId = Value(ruleSetVersionId),
       json = Value(json),
       generatedAt = Value(generatedAt);
  static Insertable<MonthlyStatementRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? ruleSetVersionId,
    Expression<String>? json,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (json != null) 'json': json,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyStatementsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? ruleSetVersionId,
    Value<String>? json,
    Value<DateTime>? generatedAt,
    Value<int>? rowid,
  }) {
    return MonthlyStatementsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      json: json ?? this.json,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyStatementsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('json: $json, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StatementSignoffsTable extends StatementSignoffs
    with TableInfo<$StatementSignoffsTable, StatementSignoffRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatementSignoffsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _signerMemberIdMeta = const VerificationMeta(
    'signerMemberId',
  );
  @override
  late final GeneratedColumn<String> signerMemberId = GeneratedColumn<String>(
    'signer_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _signerRoleMeta = const VerificationMeta(
    'signerRole',
  );
  @override
  late final GeneratedColumn<String> signerRole = GeneratedColumn<String>(
    'signer_role',
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
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    signerMemberId,
    signerRole,
    proofReference,
    note,
    signedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'statement_signoffs';
  @override
  VerificationContext validateIntegrity(
    Insertable<StatementSignoffRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('signer_member_id')) {
      context.handle(
        _signerMemberIdMeta,
        signerMemberId.isAcceptableOrUnknown(
          data['signer_member_id']!,
          _signerMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_signerMemberIdMeta);
    }
    if (data.containsKey('signer_role')) {
      context.handle(
        _signerRoleMeta,
        signerRole.isAcceptableOrUnknown(data['signer_role']!, _signerRoleMeta),
      );
    } else if (isInserting) {
      context.missing(_signerRoleMeta);
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
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('signed_at')) {
      context.handle(
        _signedAtMeta,
        signedAt.isAcceptableOrUnknown(data['signed_at']!, _signedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_signedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey, signerMemberId};
  @override
  StatementSignoffRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatementSignoffRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      signerMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signer_member_id'],
      )!,
      signerRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signer_role'],
      )!,
      proofReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_reference'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      signedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}signed_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StatementSignoffsTable createAlias(String alias) {
    return $StatementSignoffsTable(attachedDatabase, alias);
  }
}

class StatementSignoffRow extends DataClass
    implements Insertable<StatementSignoffRow> {
  final String shomitiId;

  /// `BillingMonth.key` (e.g. "2026-02").
  final String monthKey;
  final String signerMemberId;

  /// "auditor" | "witness"
  final String signerRole;
  final String proofReference;
  final String? note;
  final DateTime signedAt;
  final DateTime createdAt;
  const StatementSignoffRow({
    required this.shomitiId,
    required this.monthKey,
    required this.signerMemberId,
    required this.signerRole,
    required this.proofReference,
    this.note,
    required this.signedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['signer_member_id'] = Variable<String>(signerMemberId);
    map['signer_role'] = Variable<String>(signerRole);
    map['proof_reference'] = Variable<String>(proofReference);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['signed_at'] = Variable<DateTime>(signedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StatementSignoffsCompanion toCompanion(bool nullToAbsent) {
    return StatementSignoffsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      signerMemberId: Value(signerMemberId),
      signerRole: Value(signerRole),
      proofReference: Value(proofReference),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      signedAt: Value(signedAt),
      createdAt: Value(createdAt),
    );
  }

  factory StatementSignoffRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatementSignoffRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      signerMemberId: serializer.fromJson<String>(json['signerMemberId']),
      signerRole: serializer.fromJson<String>(json['signerRole']),
      proofReference: serializer.fromJson<String>(json['proofReference']),
      note: serializer.fromJson<String?>(json['note']),
      signedAt: serializer.fromJson<DateTime>(json['signedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'signerMemberId': serializer.toJson<String>(signerMemberId),
      'signerRole': serializer.toJson<String>(signerRole),
      'proofReference': serializer.toJson<String>(proofReference),
      'note': serializer.toJson<String?>(note),
      'signedAt': serializer.toJson<DateTime>(signedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StatementSignoffRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? signerMemberId,
    String? signerRole,
    String? proofReference,
    Value<String?> note = const Value.absent(),
    DateTime? signedAt,
    DateTime? createdAt,
  }) => StatementSignoffRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    signerMemberId: signerMemberId ?? this.signerMemberId,
    signerRole: signerRole ?? this.signerRole,
    proofReference: proofReference ?? this.proofReference,
    note: note.present ? note.value : this.note,
    signedAt: signedAt ?? this.signedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  StatementSignoffRow copyWithCompanion(StatementSignoffsCompanion data) {
    return StatementSignoffRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      signerMemberId: data.signerMemberId.present
          ? data.signerMemberId.value
          : this.signerMemberId,
      signerRole: data.signerRole.present
          ? data.signerRole.value
          : this.signerRole,
      proofReference: data.proofReference.present
          ? data.proofReference.value
          : this.proofReference,
      note: data.note.present ? data.note.value : this.note,
      signedAt: data.signedAt.present ? data.signedAt.value : this.signedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatementSignoffRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('signerMemberId: $signerMemberId, ')
          ..write('signerRole: $signerRole, ')
          ..write('proofReference: $proofReference, ')
          ..write('note: $note, ')
          ..write('signedAt: $signedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    monthKey,
    signerMemberId,
    signerRole,
    proofReference,
    note,
    signedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatementSignoffRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.signerMemberId == this.signerMemberId &&
          other.signerRole == this.signerRole &&
          other.proofReference == this.proofReference &&
          other.note == this.note &&
          other.signedAt == this.signedAt &&
          other.createdAt == this.createdAt);
}

class StatementSignoffsCompanion extends UpdateCompanion<StatementSignoffRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> signerMemberId;
  final Value<String> signerRole;
  final Value<String> proofReference;
  final Value<String?> note;
  final Value<DateTime> signedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StatementSignoffsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.signerMemberId = const Value.absent(),
    this.signerRole = const Value.absent(),
    this.proofReference = const Value.absent(),
    this.note = const Value.absent(),
    this.signedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StatementSignoffsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String signerMemberId,
    required String signerRole,
    required String proofReference,
    this.note = const Value.absent(),
    required DateTime signedAt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       signerMemberId = Value(signerMemberId),
       signerRole = Value(signerRole),
       proofReference = Value(proofReference),
       signedAt = Value(signedAt),
       createdAt = Value(createdAt);
  static Insertable<StatementSignoffRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? signerMemberId,
    Expression<String>? signerRole,
    Expression<String>? proofReference,
    Expression<String>? note,
    Expression<DateTime>? signedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (signerMemberId != null) 'signer_member_id': signerMemberId,
      if (signerRole != null) 'signer_role': signerRole,
      if (proofReference != null) 'proof_reference': proofReference,
      if (note != null) 'note': note,
      if (signedAt != null) 'signed_at': signedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StatementSignoffsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? signerMemberId,
    Value<String>? signerRole,
    Value<String>? proofReference,
    Value<String?>? note,
    Value<DateTime>? signedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StatementSignoffsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      signerMemberId: signerMemberId ?? this.signerMemberId,
      signerRole: signerRole ?? this.signerRole,
      proofReference: proofReference ?? this.proofReference,
      note: note ?? this.note,
      signedAt: signedAt ?? this.signedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (signerMemberId.present) {
      map['signer_member_id'] = Variable<String>(signerMemberId.value);
    }
    if (signerRole.present) {
      map['signer_role'] = Variable<String>(signerRole.value);
    }
    if (proofReference.present) {
      map['proof_reference'] = Variable<String>(proofReference.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (signedAt.present) {
      map['signed_at'] = Variable<DateTime>(signedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatementSignoffsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('signerMemberId: $signerMemberId, ')
          ..write('signerRole: $signerRole, ')
          ..write('proofReference: $proofReference, ')
          ..write('note: $note, ')
          ..write('signedAt: $signedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayoutCollectionVerificationsTable extends PayoutCollectionVerifications
    with
        TableInfo<
          $PayoutCollectionVerificationsTable,
          PayoutCollectionVerificationRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayoutCollectionVerificationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _verifiedByMemberIdMeta =
      const VerificationMeta('verifiedByMemberId');
  @override
  late final GeneratedColumn<String> verifiedByMemberId =
      GeneratedColumn<String>(
        'verified_by_member_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
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
  static const VerificationMeta _verifiedAtMeta = const VerificationMeta(
    'verifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> verifiedAt = GeneratedColumn<DateTime>(
    'verified_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    ruleSetVersionId,
    verifiedByMemberId,
    note,
    verifiedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payout_collection_verifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayoutCollectionVerificationRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
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
    if (data.containsKey('verified_by_member_id')) {
      context.handle(
        _verifiedByMemberIdMeta,
        verifiedByMemberId.isAcceptableOrUnknown(
          data['verified_by_member_id']!,
          _verifiedByMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verifiedByMemberIdMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('verified_at')) {
      context.handle(
        _verifiedAtMeta,
        verifiedAt.isAcceptableOrUnknown(data['verified_at']!, _verifiedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_verifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey};
  @override
  PayoutCollectionVerificationRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayoutCollectionVerificationRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      verifiedByMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verified_by_member_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      verifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}verified_at'],
      )!,
    );
  }

  @override
  $PayoutCollectionVerificationsTable createAlias(String alias) {
    return $PayoutCollectionVerificationsTable(attachedDatabase, alias);
  }
}

class PayoutCollectionVerificationRow extends DataClass
    implements Insertable<PayoutCollectionVerificationRow> {
  final String shomitiId;
  final String monthKey;
  final String ruleSetVersionId;
  final String verifiedByMemberId;
  final String? note;
  final DateTime verifiedAt;
  const PayoutCollectionVerificationRow({
    required this.shomitiId,
    required this.monthKey,
    required this.ruleSetVersionId,
    required this.verifiedByMemberId,
    this.note,
    required this.verifiedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['verified_by_member_id'] = Variable<String>(verifiedByMemberId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['verified_at'] = Variable<DateTime>(verifiedAt);
    return map;
  }

  PayoutCollectionVerificationsCompanion toCompanion(bool nullToAbsent) {
    return PayoutCollectionVerificationsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      ruleSetVersionId: Value(ruleSetVersionId),
      verifiedByMemberId: Value(verifiedByMemberId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      verifiedAt: Value(verifiedAt),
    );
  }

  factory PayoutCollectionVerificationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayoutCollectionVerificationRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      verifiedByMemberId: serializer.fromJson<String>(
        json['verifiedByMemberId'],
      ),
      note: serializer.fromJson<String?>(json['note']),
      verifiedAt: serializer.fromJson<DateTime>(json['verifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'verifiedByMemberId': serializer.toJson<String>(verifiedByMemberId),
      'note': serializer.toJson<String?>(note),
      'verifiedAt': serializer.toJson<DateTime>(verifiedAt),
    };
  }

  PayoutCollectionVerificationRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? ruleSetVersionId,
    String? verifiedByMemberId,
    Value<String?> note = const Value.absent(),
    DateTime? verifiedAt,
  }) => PayoutCollectionVerificationRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    verifiedByMemberId: verifiedByMemberId ?? this.verifiedByMemberId,
    note: note.present ? note.value : this.note,
    verifiedAt: verifiedAt ?? this.verifiedAt,
  );
  PayoutCollectionVerificationRow copyWithCompanion(
    PayoutCollectionVerificationsCompanion data,
  ) {
    return PayoutCollectionVerificationRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      verifiedByMemberId: data.verifiedByMemberId.present
          ? data.verifiedByMemberId.value
          : this.verifiedByMemberId,
      note: data.note.present ? data.note.value : this.note,
      verifiedAt: data.verifiedAt.present
          ? data.verifiedAt.value
          : this.verifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayoutCollectionVerificationRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('verifiedByMemberId: $verifiedByMemberId, ')
          ..write('note: $note, ')
          ..write('verifiedAt: $verifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    monthKey,
    ruleSetVersionId,
    verifiedByMemberId,
    note,
    verifiedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayoutCollectionVerificationRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.verifiedByMemberId == this.verifiedByMemberId &&
          other.note == this.note &&
          other.verifiedAt == this.verifiedAt);
}

class PayoutCollectionVerificationsCompanion
    extends UpdateCompanion<PayoutCollectionVerificationRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> ruleSetVersionId;
  final Value<String> verifiedByMemberId;
  final Value<String?> note;
  final Value<DateTime> verifiedAt;
  final Value<int> rowid;
  const PayoutCollectionVerificationsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.verifiedByMemberId = const Value.absent(),
    this.note = const Value.absent(),
    this.verifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayoutCollectionVerificationsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String ruleSetVersionId,
    required String verifiedByMemberId,
    this.note = const Value.absent(),
    required DateTime verifiedAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       ruleSetVersionId = Value(ruleSetVersionId),
       verifiedByMemberId = Value(verifiedByMemberId),
       verifiedAt = Value(verifiedAt);
  static Insertable<PayoutCollectionVerificationRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? ruleSetVersionId,
    Expression<String>? verifiedByMemberId,
    Expression<String>? note,
    Expression<DateTime>? verifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (verifiedByMemberId != null)
        'verified_by_member_id': verifiedByMemberId,
      if (note != null) 'note': note,
      if (verifiedAt != null) 'verified_at': verifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayoutCollectionVerificationsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? ruleSetVersionId,
    Value<String>? verifiedByMemberId,
    Value<String?>? note,
    Value<DateTime>? verifiedAt,
    Value<int>? rowid,
  }) {
    return PayoutCollectionVerificationsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      verifiedByMemberId: verifiedByMemberId ?? this.verifiedByMemberId,
      note: note ?? this.note,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (verifiedByMemberId.present) {
      map['verified_by_member_id'] = Variable<String>(verifiedByMemberId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (verifiedAt.present) {
      map['verified_at'] = Variable<DateTime>(verifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayoutCollectionVerificationsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('verifiedByMemberId: $verifiedByMemberId, ')
          ..write('note: $note, ')
          ..write('verifiedAt: $verifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayoutApprovalsTable extends PayoutApprovals
    with TableInfo<$PayoutApprovalsTable, PayoutApprovalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayoutApprovalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _approverMemberIdMeta = const VerificationMeta(
    'approverMemberId',
  );
  @override
  late final GeneratedColumn<String> approverMemberId = GeneratedColumn<String>(
    'approver_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
    'approved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    role,
    approverMemberId,
    ruleSetVersionId,
    note,
    approvedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payout_approvals';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayoutApprovalRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('approver_member_id')) {
      context.handle(
        _approverMemberIdMeta,
        approverMemberId.isAcceptableOrUnknown(
          data['approver_member_id']!,
          _approverMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_approverMemberIdMeta);
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
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_approvedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    shomitiId,
    monthKey,
    role,
    approverMemberId,
  };
  @override
  PayoutApprovalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayoutApprovalRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      approverMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}approver_member_id'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      )!,
    );
  }

  @override
  $PayoutApprovalsTable createAlias(String alias) {
    return $PayoutApprovalsTable(attachedDatabase, alias);
  }
}

class PayoutApprovalRow extends DataClass
    implements Insertable<PayoutApprovalRow> {
  final String shomitiId;
  final String monthKey;

  /// 'treasurer' or 'auditor'
  final String role;
  final String approverMemberId;
  final String ruleSetVersionId;
  final String? note;
  final DateTime approvedAt;
  const PayoutApprovalRow({
    required this.shomitiId,
    required this.monthKey,
    required this.role,
    required this.approverMemberId,
    required this.ruleSetVersionId,
    this.note,
    required this.approvedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['role'] = Variable<String>(role);
    map['approver_member_id'] = Variable<String>(approverMemberId);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['approved_at'] = Variable<DateTime>(approvedAt);
    return map;
  }

  PayoutApprovalsCompanion toCompanion(bool nullToAbsent) {
    return PayoutApprovalsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      role: Value(role),
      approverMemberId: Value(approverMemberId),
      ruleSetVersionId: Value(ruleSetVersionId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      approvedAt: Value(approvedAt),
    );
  }

  factory PayoutApprovalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayoutApprovalRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      role: serializer.fromJson<String>(json['role']),
      approverMemberId: serializer.fromJson<String>(json['approverMemberId']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      note: serializer.fromJson<String?>(json['note']),
      approvedAt: serializer.fromJson<DateTime>(json['approvedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'role': serializer.toJson<String>(role),
      'approverMemberId': serializer.toJson<String>(approverMemberId),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'note': serializer.toJson<String?>(note),
      'approvedAt': serializer.toJson<DateTime>(approvedAt),
    };
  }

  PayoutApprovalRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? role,
    String? approverMemberId,
    String? ruleSetVersionId,
    Value<String?> note = const Value.absent(),
    DateTime? approvedAt,
  }) => PayoutApprovalRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    role: role ?? this.role,
    approverMemberId: approverMemberId ?? this.approverMemberId,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    note: note.present ? note.value : this.note,
    approvedAt: approvedAt ?? this.approvedAt,
  );
  PayoutApprovalRow copyWithCompanion(PayoutApprovalsCompanion data) {
    return PayoutApprovalRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      role: data.role.present ? data.role.value : this.role,
      approverMemberId: data.approverMemberId.present
          ? data.approverMemberId.value
          : this.approverMemberId,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      note: data.note.present ? data.note.value : this.note,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayoutApprovalRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('role: $role, ')
          ..write('approverMemberId: $approverMemberId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('note: $note, ')
          ..write('approvedAt: $approvedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    monthKey,
    role,
    approverMemberId,
    ruleSetVersionId,
    note,
    approvedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayoutApprovalRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.role == this.role &&
          other.approverMemberId == this.approverMemberId &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.note == this.note &&
          other.approvedAt == this.approvedAt);
}

class PayoutApprovalsCompanion extends UpdateCompanion<PayoutApprovalRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> role;
  final Value<String> approverMemberId;
  final Value<String> ruleSetVersionId;
  final Value<String?> note;
  final Value<DateTime> approvedAt;
  final Value<int> rowid;
  const PayoutApprovalsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.role = const Value.absent(),
    this.approverMemberId = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.note = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayoutApprovalsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String role,
    required String approverMemberId,
    required String ruleSetVersionId,
    this.note = const Value.absent(),
    required DateTime approvedAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       role = Value(role),
       approverMemberId = Value(approverMemberId),
       ruleSetVersionId = Value(ruleSetVersionId),
       approvedAt = Value(approvedAt);
  static Insertable<PayoutApprovalRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? role,
    Expression<String>? approverMemberId,
    Expression<String>? ruleSetVersionId,
    Expression<String>? note,
    Expression<DateTime>? approvedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (role != null) 'role': role,
      if (approverMemberId != null) 'approver_member_id': approverMemberId,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (note != null) 'note': note,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayoutApprovalsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? role,
    Value<String>? approverMemberId,
    Value<String>? ruleSetVersionId,
    Value<String?>? note,
    Value<DateTime>? approvedAt,
    Value<int>? rowid,
  }) {
    return PayoutApprovalsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      role: role ?? this.role,
      approverMemberId: approverMemberId ?? this.approverMemberId,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      note: note ?? this.note,
      approvedAt: approvedAt ?? this.approvedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (approverMemberId.present) {
      map['approver_member_id'] = Variable<String>(approverMemberId.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayoutApprovalsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('role: $role, ')
          ..write('approverMemberId: $approverMemberId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('note: $note, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayoutRecordsTable extends PayoutRecords
    with TableInfo<$PayoutRecordsTable, PayoutRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayoutRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _drawIdMeta = const VerificationMeta('drawId');
  @override
  late final GeneratedColumn<String> drawId = GeneratedColumn<String>(
    'draw_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES draw_records (id)',
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
  static const VerificationMeta _winnerMemberIdMeta = const VerificationMeta(
    'winnerMemberId',
  );
  @override
  late final GeneratedColumn<String> winnerMemberId = GeneratedColumn<String>(
    'winner_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winnerShareIndexMeta = const VerificationMeta(
    'winnerShareIndex',
  );
  @override
  late final GeneratedColumn<int> winnerShareIndex = GeneratedColumn<int>(
    'winner_share_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountBdtMeta = const VerificationMeta(
    'amountBdt',
  );
  @override
  late final GeneratedColumn<int> amountBdt = GeneratedColumn<int>(
    'amount_bdt',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proofReferenceMeta = const VerificationMeta(
    'proofReference',
  );
  @override
  late final GeneratedColumn<String> proofReference = GeneratedColumn<String>(
    'proof_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markedPaidByMemberIdMeta =
      const VerificationMeta('markedPaidByMemberId');
  @override
  late final GeneratedColumn<String> markedPaidByMemberId =
      GeneratedColumn<String>(
        'marked_paid_by_member_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    shomitiId,
    monthKey,
    drawId,
    ruleSetVersionId,
    winnerMemberId,
    winnerShareIndex,
    amountBdt,
    proofReference,
    markedPaidByMemberId,
    paidAt,
    recordedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payout_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayoutRecordRow> instance, {
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
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('draw_id')) {
      context.handle(
        _drawIdMeta,
        drawId.isAcceptableOrUnknown(data['draw_id']!, _drawIdMeta),
      );
    } else if (isInserting) {
      context.missing(_drawIdMeta);
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
    if (data.containsKey('winner_member_id')) {
      context.handle(
        _winnerMemberIdMeta,
        winnerMemberId.isAcceptableOrUnknown(
          data['winner_member_id']!,
          _winnerMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winnerMemberIdMeta);
    }
    if (data.containsKey('winner_share_index')) {
      context.handle(
        _winnerShareIndexMeta,
        winnerShareIndex.isAcceptableOrUnknown(
          data['winner_share_index']!,
          _winnerShareIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winnerShareIndexMeta);
    }
    if (data.containsKey('amount_bdt')) {
      context.handle(
        _amountBdtMeta,
        amountBdt.isAcceptableOrUnknown(data['amount_bdt']!, _amountBdtMeta),
      );
    } else if (isInserting) {
      context.missing(_amountBdtMeta);
    }
    if (data.containsKey('proof_reference')) {
      context.handle(
        _proofReferenceMeta,
        proofReference.isAcceptableOrUnknown(
          data['proof_reference']!,
          _proofReferenceMeta,
        ),
      );
    }
    if (data.containsKey('marked_paid_by_member_id')) {
      context.handle(
        _markedPaidByMemberIdMeta,
        markedPaidByMemberId.isAcceptableOrUnknown(
          data['marked_paid_by_member_id']!,
          _markedPaidByMemberIdMeta,
        ),
      );
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shomitiId, monthKey};
  @override
  PayoutRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayoutRecordRow(
      shomitiId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shomiti_id'],
      )!,
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      drawId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draw_id'],
      )!,
      ruleSetVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_set_version_id'],
      )!,
      winnerMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}winner_member_id'],
      )!,
      winnerShareIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}winner_share_index'],
      )!,
      amountBdt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_bdt'],
      )!,
      proofReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_reference'],
      ),
      markedPaidByMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marked_paid_by_member_id'],
      ),
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $PayoutRecordsTable createAlias(String alias) {
    return $PayoutRecordsTable(attachedDatabase, alias);
  }
}

class PayoutRecordRow extends DataClass implements Insertable<PayoutRecordRow> {
  final String shomitiId;
  final String monthKey;
  final String drawId;
  final String ruleSetVersionId;
  final String winnerMemberId;
  final int winnerShareIndex;

  /// Amount to pay in BDT.
  final int amountBdt;

  /// Required to mark paid.
  final String? proofReference;

  /// Who marked this payout as paid (member id), if available.
  final String? markedPaidByMemberId;
  final DateTime? paidAt;
  final DateTime recordedAt;
  const PayoutRecordRow({
    required this.shomitiId,
    required this.monthKey,
    required this.drawId,
    required this.ruleSetVersionId,
    required this.winnerMemberId,
    required this.winnerShareIndex,
    required this.amountBdt,
    this.proofReference,
    this.markedPaidByMemberId,
    this.paidAt,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shomiti_id'] = Variable<String>(shomitiId);
    map['month_key'] = Variable<String>(monthKey);
    map['draw_id'] = Variable<String>(drawId);
    map['rule_set_version_id'] = Variable<String>(ruleSetVersionId);
    map['winner_member_id'] = Variable<String>(winnerMemberId);
    map['winner_share_index'] = Variable<int>(winnerShareIndex);
    map['amount_bdt'] = Variable<int>(amountBdt);
    if (!nullToAbsent || proofReference != null) {
      map['proof_reference'] = Variable<String>(proofReference);
    }
    if (!nullToAbsent || markedPaidByMemberId != null) {
      map['marked_paid_by_member_id'] = Variable<String>(markedPaidByMemberId);
    }
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  PayoutRecordsCompanion toCompanion(bool nullToAbsent) {
    return PayoutRecordsCompanion(
      shomitiId: Value(shomitiId),
      monthKey: Value(monthKey),
      drawId: Value(drawId),
      ruleSetVersionId: Value(ruleSetVersionId),
      winnerMemberId: Value(winnerMemberId),
      winnerShareIndex: Value(winnerShareIndex),
      amountBdt: Value(amountBdt),
      proofReference: proofReference == null && nullToAbsent
          ? const Value.absent()
          : Value(proofReference),
      markedPaidByMemberId: markedPaidByMemberId == null && nullToAbsent
          ? const Value.absent()
          : Value(markedPaidByMemberId),
      paidAt: paidAt == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAt),
      recordedAt: Value(recordedAt),
    );
  }

  factory PayoutRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayoutRecordRow(
      shomitiId: serializer.fromJson<String>(json['shomitiId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      drawId: serializer.fromJson<String>(json['drawId']),
      ruleSetVersionId: serializer.fromJson<String>(json['ruleSetVersionId']),
      winnerMemberId: serializer.fromJson<String>(json['winnerMemberId']),
      winnerShareIndex: serializer.fromJson<int>(json['winnerShareIndex']),
      amountBdt: serializer.fromJson<int>(json['amountBdt']),
      proofReference: serializer.fromJson<String?>(json['proofReference']),
      markedPaidByMemberId: serializer.fromJson<String?>(
        json['markedPaidByMemberId'],
      ),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shomitiId': serializer.toJson<String>(shomitiId),
      'monthKey': serializer.toJson<String>(monthKey),
      'drawId': serializer.toJson<String>(drawId),
      'ruleSetVersionId': serializer.toJson<String>(ruleSetVersionId),
      'winnerMemberId': serializer.toJson<String>(winnerMemberId),
      'winnerShareIndex': serializer.toJson<int>(winnerShareIndex),
      'amountBdt': serializer.toJson<int>(amountBdt),
      'proofReference': serializer.toJson<String?>(proofReference),
      'markedPaidByMemberId': serializer.toJson<String?>(markedPaidByMemberId),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  PayoutRecordRow copyWith({
    String? shomitiId,
    String? monthKey,
    String? drawId,
    String? ruleSetVersionId,
    String? winnerMemberId,
    int? winnerShareIndex,
    int? amountBdt,
    Value<String?> proofReference = const Value.absent(),
    Value<String?> markedPaidByMemberId = const Value.absent(),
    Value<DateTime?> paidAt = const Value.absent(),
    DateTime? recordedAt,
  }) => PayoutRecordRow(
    shomitiId: shomitiId ?? this.shomitiId,
    monthKey: monthKey ?? this.monthKey,
    drawId: drawId ?? this.drawId,
    ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
    winnerMemberId: winnerMemberId ?? this.winnerMemberId,
    winnerShareIndex: winnerShareIndex ?? this.winnerShareIndex,
    amountBdt: amountBdt ?? this.amountBdt,
    proofReference: proofReference.present
        ? proofReference.value
        : this.proofReference,
    markedPaidByMemberId: markedPaidByMemberId.present
        ? markedPaidByMemberId.value
        : this.markedPaidByMemberId,
    paidAt: paidAt.present ? paidAt.value : this.paidAt,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  PayoutRecordRow copyWithCompanion(PayoutRecordsCompanion data) {
    return PayoutRecordRow(
      shomitiId: data.shomitiId.present ? data.shomitiId.value : this.shomitiId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      drawId: data.drawId.present ? data.drawId.value : this.drawId,
      ruleSetVersionId: data.ruleSetVersionId.present
          ? data.ruleSetVersionId.value
          : this.ruleSetVersionId,
      winnerMemberId: data.winnerMemberId.present
          ? data.winnerMemberId.value
          : this.winnerMemberId,
      winnerShareIndex: data.winnerShareIndex.present
          ? data.winnerShareIndex.value
          : this.winnerShareIndex,
      amountBdt: data.amountBdt.present ? data.amountBdt.value : this.amountBdt,
      proofReference: data.proofReference.present
          ? data.proofReference.value
          : this.proofReference,
      markedPaidByMemberId: data.markedPaidByMemberId.present
          ? data.markedPaidByMemberId.value
          : this.markedPaidByMemberId,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayoutRecordRow(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('drawId: $drawId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('winnerMemberId: $winnerMemberId, ')
          ..write('winnerShareIndex: $winnerShareIndex, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('proofReference: $proofReference, ')
          ..write('markedPaidByMemberId: $markedPaidByMemberId, ')
          ..write('paidAt: $paidAt, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shomitiId,
    monthKey,
    drawId,
    ruleSetVersionId,
    winnerMemberId,
    winnerShareIndex,
    amountBdt,
    proofReference,
    markedPaidByMemberId,
    paidAt,
    recordedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayoutRecordRow &&
          other.shomitiId == this.shomitiId &&
          other.monthKey == this.monthKey &&
          other.drawId == this.drawId &&
          other.ruleSetVersionId == this.ruleSetVersionId &&
          other.winnerMemberId == this.winnerMemberId &&
          other.winnerShareIndex == this.winnerShareIndex &&
          other.amountBdt == this.amountBdt &&
          other.proofReference == this.proofReference &&
          other.markedPaidByMemberId == this.markedPaidByMemberId &&
          other.paidAt == this.paidAt &&
          other.recordedAt == this.recordedAt);
}

class PayoutRecordsCompanion extends UpdateCompanion<PayoutRecordRow> {
  final Value<String> shomitiId;
  final Value<String> monthKey;
  final Value<String> drawId;
  final Value<String> ruleSetVersionId;
  final Value<String> winnerMemberId;
  final Value<int> winnerShareIndex;
  final Value<int> amountBdt;
  final Value<String?> proofReference;
  final Value<String?> markedPaidByMemberId;
  final Value<DateTime?> paidAt;
  final Value<DateTime> recordedAt;
  final Value<int> rowid;
  const PayoutRecordsCompanion({
    this.shomitiId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.drawId = const Value.absent(),
    this.ruleSetVersionId = const Value.absent(),
    this.winnerMemberId = const Value.absent(),
    this.winnerShareIndex = const Value.absent(),
    this.amountBdt = const Value.absent(),
    this.proofReference = const Value.absent(),
    this.markedPaidByMemberId = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayoutRecordsCompanion.insert({
    required String shomitiId,
    required String monthKey,
    required String drawId,
    required String ruleSetVersionId,
    required String winnerMemberId,
    required int winnerShareIndex,
    required int amountBdt,
    this.proofReference = const Value.absent(),
    this.markedPaidByMemberId = const Value.absent(),
    this.paidAt = const Value.absent(),
    required DateTime recordedAt,
    this.rowid = const Value.absent(),
  }) : shomitiId = Value(shomitiId),
       monthKey = Value(monthKey),
       drawId = Value(drawId),
       ruleSetVersionId = Value(ruleSetVersionId),
       winnerMemberId = Value(winnerMemberId),
       winnerShareIndex = Value(winnerShareIndex),
       amountBdt = Value(amountBdt),
       recordedAt = Value(recordedAt);
  static Insertable<PayoutRecordRow> custom({
    Expression<String>? shomitiId,
    Expression<String>? monthKey,
    Expression<String>? drawId,
    Expression<String>? ruleSetVersionId,
    Expression<String>? winnerMemberId,
    Expression<int>? winnerShareIndex,
    Expression<int>? amountBdt,
    Expression<String>? proofReference,
    Expression<String>? markedPaidByMemberId,
    Expression<DateTime>? paidAt,
    Expression<DateTime>? recordedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shomitiId != null) 'shomiti_id': shomitiId,
      if (monthKey != null) 'month_key': monthKey,
      if (drawId != null) 'draw_id': drawId,
      if (ruleSetVersionId != null) 'rule_set_version_id': ruleSetVersionId,
      if (winnerMemberId != null) 'winner_member_id': winnerMemberId,
      if (winnerShareIndex != null) 'winner_share_index': winnerShareIndex,
      if (amountBdt != null) 'amount_bdt': amountBdt,
      if (proofReference != null) 'proof_reference': proofReference,
      if (markedPaidByMemberId != null)
        'marked_paid_by_member_id': markedPaidByMemberId,
      if (paidAt != null) 'paid_at': paidAt,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayoutRecordsCompanion copyWith({
    Value<String>? shomitiId,
    Value<String>? monthKey,
    Value<String>? drawId,
    Value<String>? ruleSetVersionId,
    Value<String>? winnerMemberId,
    Value<int>? winnerShareIndex,
    Value<int>? amountBdt,
    Value<String?>? proofReference,
    Value<String?>? markedPaidByMemberId,
    Value<DateTime?>? paidAt,
    Value<DateTime>? recordedAt,
    Value<int>? rowid,
  }) {
    return PayoutRecordsCompanion(
      shomitiId: shomitiId ?? this.shomitiId,
      monthKey: monthKey ?? this.monthKey,
      drawId: drawId ?? this.drawId,
      ruleSetVersionId: ruleSetVersionId ?? this.ruleSetVersionId,
      winnerMemberId: winnerMemberId ?? this.winnerMemberId,
      winnerShareIndex: winnerShareIndex ?? this.winnerShareIndex,
      amountBdt: amountBdt ?? this.amountBdt,
      proofReference: proofReference ?? this.proofReference,
      markedPaidByMemberId: markedPaidByMemberId ?? this.markedPaidByMemberId,
      paidAt: paidAt ?? this.paidAt,
      recordedAt: recordedAt ?? this.recordedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shomitiId.present) {
      map['shomiti_id'] = Variable<String>(shomitiId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (drawId.present) {
      map['draw_id'] = Variable<String>(drawId.value);
    }
    if (ruleSetVersionId.present) {
      map['rule_set_version_id'] = Variable<String>(ruleSetVersionId.value);
    }
    if (winnerMemberId.present) {
      map['winner_member_id'] = Variable<String>(winnerMemberId.value);
    }
    if (winnerShareIndex.present) {
      map['winner_share_index'] = Variable<int>(winnerShareIndex.value);
    }
    if (amountBdt.present) {
      map['amount_bdt'] = Variable<int>(amountBdt.value);
    }
    if (proofReference.present) {
      map['proof_reference'] = Variable<String>(proofReference.value);
    }
    if (markedPaidByMemberId.present) {
      map['marked_paid_by_member_id'] = Variable<String>(
        markedPaidByMemberId.value,
      );
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayoutRecordsCompanion(')
          ..write('shomitiId: $shomitiId, ')
          ..write('monthKey: $monthKey, ')
          ..write('drawId: $drawId, ')
          ..write('ruleSetVersionId: $ruleSetVersionId, ')
          ..write('winnerMemberId: $winnerMemberId, ')
          ..write('winnerShareIndex: $winnerShareIndex, ')
          ..write('amountBdt: $amountBdt, ')
          ..write('proofReference: $proofReference, ')
          ..write('markedPaidByMemberId: $markedPaidByMemberId, ')
          ..write('paidAt: $paidAt, ')
          ..write('recordedAt: $recordedAt, ')
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
  late final $MemberSharesTable memberShares = $MemberSharesTable(this);
  late final $GuarantorsTable guarantors = $GuarantorsTable(this);
  late final $SecurityDepositsTable securityDeposits = $SecurityDepositsTable(
    this,
  );
  late final $RoleAssignmentsTable roleAssignments = $RoleAssignmentsTable(
    this,
  );
  late final $RuleSetVersionsTable ruleSetVersions = $RuleSetVersionsTable(
    this,
  );
  late final $MemberConsentsTable memberConsents = $MemberConsentsTable(this);
  late final $RuleAmendmentsTable ruleAmendments = $RuleAmendmentsTable(this);
  late final $MembershipChangeRequestsTable membershipChangeRequests =
      $MembershipChangeRequestsTable(this);
  late final $MembershipChangeApprovalsTable membershipChangeApprovals =
      $MembershipChangeApprovalsTable(this);
  late final $DueMonthsTable dueMonths = $DueMonthsTable(this);
  late final $MonthlyDuesTable monthlyDues = $MonthlyDuesTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $CollectionResolutionsTable collectionResolutions =
      $CollectionResolutionsTable(this);
  late final $DefaultEnforcementStepsTable defaultEnforcementSteps =
      $DefaultEnforcementStepsTable(this);
  late final $DrawRecordsTable drawRecords = $DrawRecordsTable(this);
  late final $DrawWitnessApprovalsTable drawWitnessApprovals =
      $DrawWitnessApprovalsTable(this);
  late final $MonthlyStatementsTable monthlyStatements =
      $MonthlyStatementsTable(this);
  late final $StatementSignoffsTable statementSignoffs =
      $StatementSignoffsTable(this);
  late final $PayoutCollectionVerificationsTable payoutCollectionVerifications =
      $PayoutCollectionVerificationsTable(this);
  late final $PayoutApprovalsTable payoutApprovals = $PayoutApprovalsTable(
    this,
  );
  late final $PayoutRecordsTable payoutRecords = $PayoutRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    auditEvents,
    ledgerEntries,
    shomitis,
    members,
    memberShares,
    guarantors,
    securityDeposits,
    roleAssignments,
    ruleSetVersions,
    memberConsents,
    ruleAmendments,
    membershipChangeRequests,
    membershipChangeApprovals,
    dueMonths,
    monthlyDues,
    payments,
    collectionResolutions,
    defaultEnforcementSteps,
    drawRecords,
    drawWitnessApprovals,
    monthlyStatements,
    statementSignoffs,
    payoutCollectionVerifications,
    payoutApprovals,
    payoutRecords,
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

  static MultiTypedResultKey<$RuleAmendmentsTable, List<RuleAmendmentRow>>
  _ruleAmendmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ruleAmendments,
    aliasName: $_aliasNameGenerator(
      db.shomitis.id,
      db.ruleAmendments.shomitiId,
    ),
  );

  $$RuleAmendmentsTableProcessedTableManager get ruleAmendmentsRefs {
    final manager = $$RuleAmendmentsTableTableManager(
      $_db,
      $_db.ruleAmendments,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ruleAmendmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MembershipChangeRequestsTable,
    List<MembershipChangeRequestRow>
  >
  _membershipChangeRequestsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.membershipChangeRequests,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.membershipChangeRequests.shomitiId,
        ),
      );

  $$MembershipChangeRequestsTableProcessedTableManager
  get membershipChangeRequestsRefs {
    final manager = $$MembershipChangeRequestsTableTableManager(
      $_db,
      $_db.membershipChangeRequests,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _membershipChangeRequestsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MembershipChangeApprovalsTable,
    List<MembershipChangeApprovalRow>
  >
  _membershipChangeApprovalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.membershipChangeApprovals,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.membershipChangeApprovals.shomitiId,
        ),
      );

  $$MembershipChangeApprovalsTableProcessedTableManager
  get membershipChangeApprovalsRefs {
    final manager = $$MembershipChangeApprovalsTableTableManager(
      $_db,
      $_db.membershipChangeApprovals,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _membershipChangeApprovalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DueMonthsTable, List<DueMonthRow>>
  _dueMonthsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dueMonths,
    aliasName: $_aliasNameGenerator(db.shomitis.id, db.dueMonths.shomitiId),
  );

  $$DueMonthsTableProcessedTableManager get dueMonthsRefs {
    final manager = $$DueMonthsTableTableManager(
      $_db,
      $_db.dueMonths,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dueMonthsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyDuesTable, List<MonthlyDueRow>>
  _monthlyDuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyDues,
    aliasName: $_aliasNameGenerator(db.shomitis.id, db.monthlyDues.shomitiId),
  );

  $$MonthlyDuesTableProcessedTableManager get monthlyDuesRefs {
    final manager = $$MonthlyDuesTableTableManager(
      $_db,
      $_db.monthlyDues,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_monthlyDuesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentRow>>
  _paymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.shomitis.id, db.payments.shomitiId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CollectionResolutionsTable,
    List<CollectionResolutionRow>
  >
  _collectionResolutionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionResolutions,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.collectionResolutions.shomitiId,
        ),
      );

  $$CollectionResolutionsTableProcessedTableManager
  get collectionResolutionsRefs {
    final manager = $$CollectionResolutionsTableTableManager(
      $_db,
      $_db.collectionResolutions,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionResolutionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DefaultEnforcementStepsTable,
    List<DefaultEnforcementStepRow>
  >
  _defaultEnforcementStepsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.defaultEnforcementSteps,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.defaultEnforcementSteps.shomitiId,
        ),
      );

  $$DefaultEnforcementStepsTableProcessedTableManager
  get defaultEnforcementStepsRefs {
    final manager = $$DefaultEnforcementStepsTableTableManager(
      $_db,
      $_db.defaultEnforcementSteps,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _defaultEnforcementStepsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DrawRecordsTable, List<DrawRecordRow>>
  _drawRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.drawRecords,
    aliasName: $_aliasNameGenerator(db.shomitis.id, db.drawRecords.shomitiId),
  );

  $$DrawRecordsTableProcessedTableManager get drawRecordsRefs {
    final manager = $$DrawRecordsTableTableManager(
      $_db,
      $_db.drawRecords,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drawRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyStatementsTable, List<MonthlyStatementRow>>
  _monthlyStatementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.monthlyStatements,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.monthlyStatements.shomitiId,
        ),
      );

  $$MonthlyStatementsTableProcessedTableManager get monthlyStatementsRefs {
    final manager = $$MonthlyStatementsTableTableManager(
      $_db,
      $_db.monthlyStatements,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _monthlyStatementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StatementSignoffsTable, List<StatementSignoffRow>>
  _statementSignoffsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.statementSignoffs,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.statementSignoffs.shomitiId,
        ),
      );

  $$StatementSignoffsTableProcessedTableManager get statementSignoffsRefs {
    final manager = $$StatementSignoffsTableTableManager(
      $_db,
      $_db.statementSignoffs,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _statementSignoffsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PayoutCollectionVerificationsTable,
    List<PayoutCollectionVerificationRow>
  >
  _payoutCollectionVerificationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.payoutCollectionVerifications,
        aliasName: $_aliasNameGenerator(
          db.shomitis.id,
          db.payoutCollectionVerifications.shomitiId,
        ),
      );

  $$PayoutCollectionVerificationsTableProcessedTableManager
  get payoutCollectionVerificationsRefs {
    final manager = $$PayoutCollectionVerificationsTableTableManager(
      $_db,
      $_db.payoutCollectionVerifications,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _payoutCollectionVerificationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PayoutApprovalsTable, List<PayoutApprovalRow>>
  _payoutApprovalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payoutApprovals,
    aliasName: $_aliasNameGenerator(
      db.shomitis.id,
      db.payoutApprovals.shomitiId,
    ),
  );

  $$PayoutApprovalsTableProcessedTableManager get payoutApprovalsRefs {
    final manager = $$PayoutApprovalsTableTableManager(
      $_db,
      $_db.payoutApprovals,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _payoutApprovalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PayoutRecordsTable, List<PayoutRecordRow>>
  _payoutRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payoutRecords,
    aliasName: $_aliasNameGenerator(db.shomitis.id, db.payoutRecords.shomitiId),
  );

  $$PayoutRecordsTableProcessedTableManager get payoutRecordsRefs {
    final manager = $$PayoutRecordsTableTableManager(
      $_db,
      $_db.payoutRecords,
    ).filter((f) => f.shomitiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_payoutRecordsRefsTable($_db));
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

  Expression<bool> ruleAmendmentsRefs(
    Expression<bool> Function($$RuleAmendmentsTableFilterComposer f) f,
  ) {
    final $$RuleAmendmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleAmendments,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleAmendmentsTableFilterComposer(
            $db: $db,
            $table: $db.ruleAmendments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> membershipChangeRequestsRefs(
    Expression<bool> Function($$MembershipChangeRequestsTableFilterComposer f)
    f,
  ) {
    final $$MembershipChangeRequestsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableFilterComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> membershipChangeApprovalsRefs(
    Expression<bool> Function($$MembershipChangeApprovalsTableFilterComposer f)
    f,
  ) {
    final $$MembershipChangeApprovalsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeApprovals,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeApprovalsTableFilterComposer(
                $db: $db,
                $table: $db.membershipChangeApprovals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> dueMonthsRefs(
    Expression<bool> Function($$DueMonthsTableFilterComposer f) f,
  ) {
    final $$DueMonthsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dueMonths,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DueMonthsTableFilterComposer(
            $db: $db,
            $table: $db.dueMonths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyDuesRefs(
    Expression<bool> Function($$MonthlyDuesTableFilterComposer f) f,
  ) {
    final $$MonthlyDuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyDues,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyDuesTableFilterComposer(
            $db: $db,
            $table: $db.monthlyDues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> collectionResolutionsRefs(
    Expression<bool> Function($$CollectionResolutionsTableFilterComposer f) f,
  ) {
    final $$CollectionResolutionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionResolutions,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionResolutionsTableFilterComposer(
                $db: $db,
                $table: $db.collectionResolutions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> defaultEnforcementStepsRefs(
    Expression<bool> Function($$DefaultEnforcementStepsTableFilterComposer f) f,
  ) {
    final $$DefaultEnforcementStepsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.defaultEnforcementSteps,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DefaultEnforcementStepsTableFilterComposer(
                $db: $db,
                $table: $db.defaultEnforcementSteps,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> drawRecordsRefs(
    Expression<bool> Function($$DrawRecordsTableFilterComposer f) f,
  ) {
    final $$DrawRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableFilterComposer(
            $db: $db,
            $table: $db.drawRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyStatementsRefs(
    Expression<bool> Function($$MonthlyStatementsTableFilterComposer f) f,
  ) {
    final $$MonthlyStatementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyStatements,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyStatementsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyStatements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> statementSignoffsRefs(
    Expression<bool> Function($$StatementSignoffsTableFilterComposer f) f,
  ) {
    final $$StatementSignoffsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.statementSignoffs,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatementSignoffsTableFilterComposer(
            $db: $db,
            $table: $db.statementSignoffs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> payoutCollectionVerificationsRefs(
    Expression<bool> Function(
      $$PayoutCollectionVerificationsTableFilterComposer f,
    )
    f,
  ) {
    final $$PayoutCollectionVerificationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.payoutCollectionVerifications,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PayoutCollectionVerificationsTableFilterComposer(
                $db: $db,
                $table: $db.payoutCollectionVerifications,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> payoutApprovalsRefs(
    Expression<bool> Function($$PayoutApprovalsTableFilterComposer f) f,
  ) {
    final $$PayoutApprovalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutApprovals,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutApprovalsTableFilterComposer(
            $db: $db,
            $table: $db.payoutApprovals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> payoutRecordsRefs(
    Expression<bool> Function($$PayoutRecordsTableFilterComposer f) f,
  ) {
    final $$PayoutRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutRecords,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutRecordsTableFilterComposer(
            $db: $db,
            $table: $db.payoutRecords,
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

  Expression<T> ruleAmendmentsRefs<T extends Object>(
    Expression<T> Function($$RuleAmendmentsTableAnnotationComposer a) f,
  ) {
    final $$RuleAmendmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleAmendments,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleAmendmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.ruleAmendments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> membershipChangeRequestsRefs<T extends Object>(
    Expression<T> Function($$MembershipChangeRequestsTableAnnotationComposer a)
    f,
  ) {
    final $$MembershipChangeRequestsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableAnnotationComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> membershipChangeApprovalsRefs<T extends Object>(
    Expression<T> Function($$MembershipChangeApprovalsTableAnnotationComposer a)
    f,
  ) {
    final $$MembershipChangeApprovalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeApprovals,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeApprovalsTableAnnotationComposer(
                $db: $db,
                $table: $db.membershipChangeApprovals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> dueMonthsRefs<T extends Object>(
    Expression<T> Function($$DueMonthsTableAnnotationComposer a) f,
  ) {
    final $$DueMonthsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dueMonths,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DueMonthsTableAnnotationComposer(
            $db: $db,
            $table: $db.dueMonths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> monthlyDuesRefs<T extends Object>(
    Expression<T> Function($$MonthlyDuesTableAnnotationComposer a) f,
  ) {
    final $$MonthlyDuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyDues,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyDuesTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyDues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> collectionResolutionsRefs<T extends Object>(
    Expression<T> Function($$CollectionResolutionsTableAnnotationComposer a) f,
  ) {
    final $$CollectionResolutionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionResolutions,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionResolutionsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionResolutions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> defaultEnforcementStepsRefs<T extends Object>(
    Expression<T> Function($$DefaultEnforcementStepsTableAnnotationComposer a)
    f,
  ) {
    final $$DefaultEnforcementStepsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.defaultEnforcementSteps,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DefaultEnforcementStepsTableAnnotationComposer(
                $db: $db,
                $table: $db.defaultEnforcementSteps,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> drawRecordsRefs<T extends Object>(
    Expression<T> Function($$DrawRecordsTableAnnotationComposer a) f,
  ) {
    final $$DrawRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.drawRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> monthlyStatementsRefs<T extends Object>(
    Expression<T> Function($$MonthlyStatementsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyStatementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.monthlyStatements,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyStatementsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyStatements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> statementSignoffsRefs<T extends Object>(
    Expression<T> Function($$StatementSignoffsTableAnnotationComposer a) f,
  ) {
    final $$StatementSignoffsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.statementSignoffs,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StatementSignoffsTableAnnotationComposer(
                $db: $db,
                $table: $db.statementSignoffs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> payoutCollectionVerificationsRefs<T extends Object>(
    Expression<T> Function(
      $$PayoutCollectionVerificationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PayoutCollectionVerificationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.payoutCollectionVerifications,
          getReferencedColumn: (t) => t.shomitiId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PayoutCollectionVerificationsTableAnnotationComposer(
                $db: $db,
                $table: $db.payoutCollectionVerifications,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> payoutApprovalsRefs<T extends Object>(
    Expression<T> Function($$PayoutApprovalsTableAnnotationComposer a) f,
  ) {
    final $$PayoutApprovalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutApprovals,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutApprovalsTableAnnotationComposer(
            $db: $db,
            $table: $db.payoutApprovals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> payoutRecordsRefs<T extends Object>(
    Expression<T> Function($$PayoutRecordsTableAnnotationComposer a) f,
  ) {
    final $$PayoutRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutRecords,
      getReferencedColumn: (t) => t.shomitiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.payoutRecords,
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
            bool ruleAmendmentsRefs,
            bool membershipChangeRequestsRefs,
            bool membershipChangeApprovalsRefs,
            bool dueMonthsRefs,
            bool monthlyDuesRefs,
            bool paymentsRefs,
            bool collectionResolutionsRefs,
            bool defaultEnforcementStepsRefs,
            bool drawRecordsRefs,
            bool monthlyStatementsRefs,
            bool statementSignoffsRefs,
            bool payoutCollectionVerificationsRefs,
            bool payoutApprovalsRefs,
            bool payoutRecordsRefs,
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
                ruleAmendmentsRefs = false,
                membershipChangeRequestsRefs = false,
                membershipChangeApprovalsRefs = false,
                dueMonthsRefs = false,
                monthlyDuesRefs = false,
                paymentsRefs = false,
                collectionResolutionsRefs = false,
                defaultEnforcementStepsRefs = false,
                drawRecordsRefs = false,
                monthlyStatementsRefs = false,
                statementSignoffsRefs = false,
                payoutCollectionVerificationsRefs = false,
                payoutApprovalsRefs = false,
                payoutRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (membersRefs) db.members,
                    if (roleAssignmentsRefs) db.roleAssignments,
                    if (memberConsentsRefs) db.memberConsents,
                    if (ruleAmendmentsRefs) db.ruleAmendments,
                    if (membershipChangeRequestsRefs)
                      db.membershipChangeRequests,
                    if (membershipChangeApprovalsRefs)
                      db.membershipChangeApprovals,
                    if (dueMonthsRefs) db.dueMonths,
                    if (monthlyDuesRefs) db.monthlyDues,
                    if (paymentsRefs) db.payments,
                    if (collectionResolutionsRefs) db.collectionResolutions,
                    if (defaultEnforcementStepsRefs) db.defaultEnforcementSteps,
                    if (drawRecordsRefs) db.drawRecords,
                    if (monthlyStatementsRefs) db.monthlyStatements,
                    if (statementSignoffsRefs) db.statementSignoffs,
                    if (payoutCollectionVerificationsRefs)
                      db.payoutCollectionVerifications,
                    if (payoutApprovalsRefs) db.payoutApprovals,
                    if (payoutRecordsRefs) db.payoutRecords,
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
                      if (ruleAmendmentsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          RuleAmendmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._ruleAmendmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).ruleAmendmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (membershipChangeRequestsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          MembershipChangeRequestRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._membershipChangeRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).membershipChangeRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (membershipChangeApprovalsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          MembershipChangeApprovalRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._membershipChangeApprovalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).membershipChangeApprovalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dueMonthsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          DueMonthRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._dueMonthsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).dueMonthsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyDuesRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          MonthlyDueRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._monthlyDuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyDuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          PaymentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (collectionResolutionsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          CollectionResolutionRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._collectionResolutionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionResolutionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (defaultEnforcementStepsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          DefaultEnforcementStepRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._defaultEnforcementStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).defaultEnforcementStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (drawRecordsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          DrawRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._drawRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).drawRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyStatementsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          MonthlyStatementRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._monthlyStatementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyStatementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (statementSignoffsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          StatementSignoffRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._statementSignoffsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).statementSignoffsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutCollectionVerificationsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          PayoutCollectionVerificationRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._payoutCollectionVerificationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutCollectionVerificationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutApprovalsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          PayoutApprovalRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._payoutApprovalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutApprovalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shomitiId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutRecordsRefs)
                        await $_getPrefetchedData<
                          ShomitiRow,
                          $ShomitisTable,
                          PayoutRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$ShomitisTableReferences
                              ._payoutRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ShomitisTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutRecordsRefs,
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
        bool ruleAmendmentsRefs,
        bool membershipChangeRequestsRefs,
        bool membershipChangeApprovalsRefs,
        bool dueMonthsRefs,
        bool monthlyDuesRefs,
        bool paymentsRefs,
        bool collectionResolutionsRefs,
        bool defaultEnforcementStepsRefs,
        bool drawRecordsRefs,
        bool monthlyStatementsRefs,
        bool statementSignoffsRefs,
        bool payoutCollectionVerificationsRefs,
        bool payoutApprovalsRefs,
        bool payoutRecordsRefs,
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

  static MultiTypedResultKey<
    $MembershipChangeRequestsTable,
    List<MembershipChangeRequestRow>
  >
  _membershipChangeRequestsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.membershipChangeRequests,
        aliasName: $_aliasNameGenerator(
          db.members.id,
          db.membershipChangeRequests.outgoingMemberId,
        ),
      );

  $$MembershipChangeRequestsTableProcessedTableManager
  get membershipChangeRequestsRefs {
    final manager =
        $$MembershipChangeRequestsTableTableManager(
          $_db,
          $_db.membershipChangeRequests,
        ).filter(
          (f) => f.outgoingMemberId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _membershipChangeRequestsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyDuesTable, List<MonthlyDueRow>>
  _monthlyDuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyDues,
    aliasName: $_aliasNameGenerator(db.members.id, db.monthlyDues.memberId),
  );

  $$MonthlyDuesTableProcessedTableManager get monthlyDuesRefs {
    final manager = $$MonthlyDuesTableTableManager(
      $_db,
      $_db.monthlyDues,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_monthlyDuesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentRow>>
  _paymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.members.id, db.payments.memberId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DefaultEnforcementStepsTable,
    List<DefaultEnforcementStepRow>
  >
  _defaultEnforcementStepsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.defaultEnforcementSteps,
        aliasName: $_aliasNameGenerator(
          db.members.id,
          db.defaultEnforcementSteps.memberId,
        ),
      );

  $$DefaultEnforcementStepsTableProcessedTableManager
  get defaultEnforcementStepsRefs {
    final manager = $$DefaultEnforcementStepsTableTableManager(
      $_db,
      $_db.defaultEnforcementSteps,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _defaultEnforcementStepsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StatementSignoffsTable, List<StatementSignoffRow>>
  _statementSignoffsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.statementSignoffs,
        aliasName: $_aliasNameGenerator(
          db.members.id,
          db.statementSignoffs.signerMemberId,
        ),
      );

  $$StatementSignoffsTableProcessedTableManager get statementSignoffsRefs {
    final manager = $$StatementSignoffsTableTableManager(
      $_db,
      $_db.statementSignoffs,
    ).filter((f) => f.signerMemberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _statementSignoffsRefsTable($_db),
    );
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

  Expression<bool> membershipChangeRequestsRefs(
    Expression<bool> Function($$MembershipChangeRequestsTableFilterComposer f)
    f,
  ) {
    final $$MembershipChangeRequestsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.outgoingMemberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableFilterComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> monthlyDuesRefs(
    Expression<bool> Function($$MonthlyDuesTableFilterComposer f) f,
  ) {
    final $$MonthlyDuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyDues,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyDuesTableFilterComposer(
            $db: $db,
            $table: $db.monthlyDues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> defaultEnforcementStepsRefs(
    Expression<bool> Function($$DefaultEnforcementStepsTableFilterComposer f) f,
  ) {
    final $$DefaultEnforcementStepsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.defaultEnforcementSteps,
          getReferencedColumn: (t) => t.memberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DefaultEnforcementStepsTableFilterComposer(
                $db: $db,
                $table: $db.defaultEnforcementSteps,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> statementSignoffsRefs(
    Expression<bool> Function($$StatementSignoffsTableFilterComposer f) f,
  ) {
    final $$StatementSignoffsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.statementSignoffs,
      getReferencedColumn: (t) => t.signerMemberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StatementSignoffsTableFilterComposer(
            $db: $db,
            $table: $db.statementSignoffs,
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

  Expression<T> membershipChangeRequestsRefs<T extends Object>(
    Expression<T> Function($$MembershipChangeRequestsTableAnnotationComposer a)
    f,
  ) {
    final $$MembershipChangeRequestsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.outgoingMemberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableAnnotationComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> monthlyDuesRefs<T extends Object>(
    Expression<T> Function($$MonthlyDuesTableAnnotationComposer a) f,
  ) {
    final $$MonthlyDuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyDues,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyDuesTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyDues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> defaultEnforcementStepsRefs<T extends Object>(
    Expression<T> Function($$DefaultEnforcementStepsTableAnnotationComposer a)
    f,
  ) {
    final $$DefaultEnforcementStepsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.defaultEnforcementSteps,
          getReferencedColumn: (t) => t.memberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DefaultEnforcementStepsTableAnnotationComposer(
                $db: $db,
                $table: $db.defaultEnforcementSteps,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> statementSignoffsRefs<T extends Object>(
    Expression<T> Function($$StatementSignoffsTableAnnotationComposer a) f,
  ) {
    final $$StatementSignoffsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.statementSignoffs,
          getReferencedColumn: (t) => t.signerMemberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StatementSignoffsTableAnnotationComposer(
                $db: $db,
                $table: $db.statementSignoffs,
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
            bool membershipChangeRequestsRefs,
            bool monthlyDuesRefs,
            bool paymentsRefs,
            bool defaultEnforcementStepsRefs,
            bool statementSignoffsRefs,
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
                membershipChangeRequestsRefs = false,
                monthlyDuesRefs = false,
                paymentsRefs = false,
                defaultEnforcementStepsRefs = false,
                statementSignoffsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roleAssignmentsRefs) db.roleAssignments,
                    if (memberConsentsRefs) db.memberConsents,
                    if (membershipChangeRequestsRefs)
                      db.membershipChangeRequests,
                    if (monthlyDuesRefs) db.monthlyDues,
                    if (paymentsRefs) db.payments,
                    if (defaultEnforcementStepsRefs) db.defaultEnforcementSteps,
                    if (statementSignoffsRefs) db.statementSignoffs,
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
                      if (membershipChangeRequestsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          MembershipChangeRequestRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._membershipChangeRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).membershipChangeRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.outgoingMemberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyDuesRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          MonthlyDueRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._monthlyDuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyDuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          PaymentRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (defaultEnforcementStepsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          DefaultEnforcementStepRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._defaultEnforcementStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).defaultEnforcementStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (statementSignoffsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          StatementSignoffRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._statementSignoffsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).statementSignoffsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.signerMemberId == item.id,
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
        bool membershipChangeRequestsRefs,
        bool monthlyDuesRefs,
        bool paymentsRefs,
        bool defaultEnforcementStepsRefs,
        bool statementSignoffsRefs,
      })
    >;
typedef $$MemberSharesTableCreateCompanionBuilder =
    MemberSharesCompanion Function({
      required String shomitiId,
      required String memberId,
      required int shares,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$MemberSharesTableUpdateCompanionBuilder =
    MemberSharesCompanion Function({
      Value<String> shomitiId,
      Value<String> memberId,
      Value<int> shares,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$MemberSharesTableFilterComposer
    extends Composer<_$AppDatabase, $MemberSharesTable> {
  $$MemberSharesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get shomitiId => $composableBuilder(
    column: $table.shomitiId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shares => $composableBuilder(
    column: $table.shares,
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
}

class $$MemberSharesTableOrderingComposer
    extends Composer<_$AppDatabase, $MemberSharesTable> {
  $$MemberSharesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get shomitiId => $composableBuilder(
    column: $table.shomitiId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shares => $composableBuilder(
    column: $table.shares,
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
}

class $$MemberSharesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemberSharesTable> {
  $$MemberSharesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get shomitiId =>
      $composableBuilder(column: $table.shomitiId, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<int> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MemberSharesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemberSharesTable,
          MemberShare,
          $$MemberSharesTableFilterComposer,
          $$MemberSharesTableOrderingComposer,
          $$MemberSharesTableAnnotationComposer,
          $$MemberSharesTableCreateCompanionBuilder,
          $$MemberSharesTableUpdateCompanionBuilder,
          (
            MemberShare,
            BaseReferences<_$AppDatabase, $MemberSharesTable, MemberShare>,
          ),
          MemberShare,
          PrefetchHooks Function()
        > {
  $$MemberSharesTableTableManager(_$AppDatabase db, $MemberSharesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemberSharesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemberSharesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemberSharesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<int> shares = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemberSharesCompanion(
                shomitiId: shomitiId,
                memberId: memberId,
                shares: shares,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String memberId,
                required int shares,
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemberSharesCompanion.insert(
                shomitiId: shomitiId,
                memberId: memberId,
                shares: shares,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemberSharesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemberSharesTable,
      MemberShare,
      $$MemberSharesTableFilterComposer,
      $$MemberSharesTableOrderingComposer,
      $$MemberSharesTableAnnotationComposer,
      $$MemberSharesTableCreateCompanionBuilder,
      $$MemberSharesTableUpdateCompanionBuilder,
      (
        MemberShare,
        BaseReferences<_$AppDatabase, $MemberSharesTable, MemberShare>,
      ),
      MemberShare,
      PrefetchHooks Function()
    >;
typedef $$GuarantorsTableCreateCompanionBuilder =
    GuarantorsCompanion Function({
      required String shomitiId,
      required String memberId,
      required String name,
      required String phone,
      Value<String?> relationship,
      Value<String?> proofRef,
      required DateTime recordedAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$GuarantorsTableUpdateCompanionBuilder =
    GuarantorsCompanion Function({
      Value<String> shomitiId,
      Value<String> memberId,
      Value<String> name,
      Value<String> phone,
      Value<String?> relationship,
      Value<String?> proofRef,
      Value<DateTime> recordedAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$GuarantorsTableFilterComposer
    extends Composer<_$AppDatabase, $GuarantorsTable> {
  $$GuarantorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get shomitiId => $composableBuilder(
    column: $table.shomitiId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofRef => $composableBuilder(
    column: $table.proofRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GuarantorsTableOrderingComposer
    extends Composer<_$AppDatabase, $GuarantorsTable> {
  $$GuarantorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get shomitiId => $composableBuilder(
    column: $table.shomitiId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofRef => $composableBuilder(
    column: $table.proofRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GuarantorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GuarantorsTable> {
  $$GuarantorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get shomitiId =>
      $composableBuilder(column: $table.shomitiId, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proofRef =>
      $composableBuilder(column: $table.proofRef, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GuarantorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GuarantorsTable,
          GuarantorRow,
          $$GuarantorsTableFilterComposer,
          $$GuarantorsTableOrderingComposer,
          $$GuarantorsTableAnnotationComposer,
          $$GuarantorsTableCreateCompanionBuilder,
          $$GuarantorsTableUpdateCompanionBuilder,
          (
            GuarantorRow,
            BaseReferences<_$AppDatabase, $GuarantorsTable, GuarantorRow>,
          ),
          GuarantorRow,
          PrefetchHooks Function()
        > {
  $$GuarantorsTableTableManager(_$AppDatabase db, $GuarantorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GuarantorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GuarantorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GuarantorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> relationship = const Value.absent(),
                Value<String?> proofRef = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GuarantorsCompanion(
                shomitiId: shomitiId,
                memberId: memberId,
                name: name,
                phone: phone,
                relationship: relationship,
                proofRef: proofRef,
                recordedAt: recordedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String memberId,
                required String name,
                required String phone,
                Value<String?> relationship = const Value.absent(),
                Value<String?> proofRef = const Value.absent(),
                required DateTime recordedAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GuarantorsCompanion.insert(
                shomitiId: shomitiId,
                memberId: memberId,
                name: name,
                phone: phone,
                relationship: relationship,
                proofRef: proofRef,
                recordedAt: recordedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GuarantorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GuarantorsTable,
      GuarantorRow,
      $$GuarantorsTableFilterComposer,
      $$GuarantorsTableOrderingComposer,
      $$GuarantorsTableAnnotationComposer,
      $$GuarantorsTableCreateCompanionBuilder,
      $$GuarantorsTableUpdateCompanionBuilder,
      (
        GuarantorRow,
        BaseReferences<_$AppDatabase, $GuarantorsTable, GuarantorRow>,
      ),
      GuarantorRow,
      PrefetchHooks Function()
    >;
typedef $$SecurityDepositsTableCreateCompanionBuilder =
    SecurityDepositsCompanion Function({
      required String shomitiId,
      required String memberId,
      required int amountBdt,
      required String heldBy,
      Value<String?> proofRef,
      required DateTime recordedAt,
      Value<DateTime?> returnedAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$SecurityDepositsTableUpdateCompanionBuilder =
    SecurityDepositsCompanion Function({
      Value<String> shomitiId,
      Value<String> memberId,
      Value<int> amountBdt,
      Value<String> heldBy,
      Value<String?> proofRef,
      Value<DateTime> recordedAt,
      Value<DateTime?> returnedAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$SecurityDepositsTableFilterComposer
    extends Composer<_$AppDatabase, $SecurityDepositsTable> {
  $$SecurityDepositsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get shomitiId => $composableBuilder(
    column: $table.shomitiId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heldBy => $composableBuilder(
    column: $table.heldBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofRef => $composableBuilder(
    column: $table.proofRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SecurityDepositsTableOrderingComposer
    extends Composer<_$AppDatabase, $SecurityDepositsTable> {
  $$SecurityDepositsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get shomitiId => $composableBuilder(
    column: $table.shomitiId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heldBy => $composableBuilder(
    column: $table.heldBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofRef => $composableBuilder(
    column: $table.proofRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SecurityDepositsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SecurityDepositsTable> {
  $$SecurityDepositsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get shomitiId =>
      $composableBuilder(column: $table.shomitiId, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<int> get amountBdt =>
      $composableBuilder(column: $table.amountBdt, builder: (column) => column);

  GeneratedColumn<String> get heldBy =>
      $composableBuilder(column: $table.heldBy, builder: (column) => column);

  GeneratedColumn<String> get proofRef =>
      $composableBuilder(column: $table.proofRef, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SecurityDepositsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SecurityDepositsTable,
          SecurityDepositRow,
          $$SecurityDepositsTableFilterComposer,
          $$SecurityDepositsTableOrderingComposer,
          $$SecurityDepositsTableAnnotationComposer,
          $$SecurityDepositsTableCreateCompanionBuilder,
          $$SecurityDepositsTableUpdateCompanionBuilder,
          (
            SecurityDepositRow,
            BaseReferences<
              _$AppDatabase,
              $SecurityDepositsTable,
              SecurityDepositRow
            >,
          ),
          SecurityDepositRow,
          PrefetchHooks Function()
        > {
  $$SecurityDepositsTableTableManager(
    _$AppDatabase db,
    $SecurityDepositsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SecurityDepositsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SecurityDepositsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SecurityDepositsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<int> amountBdt = const Value.absent(),
                Value<String> heldBy = const Value.absent(),
                Value<String?> proofRef = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SecurityDepositsCompanion(
                shomitiId: shomitiId,
                memberId: memberId,
                amountBdt: amountBdt,
                heldBy: heldBy,
                proofRef: proofRef,
                recordedAt: recordedAt,
                returnedAt: returnedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String memberId,
                required int amountBdt,
                required String heldBy,
                Value<String?> proofRef = const Value.absent(),
                required DateTime recordedAt,
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SecurityDepositsCompanion.insert(
                shomitiId: shomitiId,
                memberId: memberId,
                amountBdt: amountBdt,
                heldBy: heldBy,
                proofRef: proofRef,
                recordedAt: recordedAt,
                returnedAt: returnedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SecurityDepositsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SecurityDepositsTable,
      SecurityDepositRow,
      $$SecurityDepositsTableFilterComposer,
      $$SecurityDepositsTableOrderingComposer,
      $$SecurityDepositsTableAnnotationComposer,
      $$SecurityDepositsTableCreateCompanionBuilder,
      $$SecurityDepositsTableUpdateCompanionBuilder,
      (
        SecurityDepositRow,
        BaseReferences<
          _$AppDatabase,
          $SecurityDepositsTable,
          SecurityDepositRow
        >,
      ),
      SecurityDepositRow,
      PrefetchHooks Function()
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

  static MultiTypedResultKey<$RuleAmendmentsTable, List<RuleAmendmentRow>>
  _ruleAmendmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ruleAmendments,
    aliasName: $_aliasNameGenerator(
      db.ruleSetVersions.id,
      db.ruleAmendments.proposedRuleSetVersionId,
    ),
  );

  $$RuleAmendmentsTableProcessedTableManager get ruleAmendmentsRefs {
    final manager = $$RuleAmendmentsTableTableManager($_db, $_db.ruleAmendments)
        .filter(
          (f) => f.proposedRuleSetVersionId.id.sqlEquals(
            $_itemColumn<String>('id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_ruleAmendmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DueMonthsTable, List<DueMonthRow>>
  _dueMonthsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dueMonths,
    aliasName: $_aliasNameGenerator(
      db.ruleSetVersions.id,
      db.dueMonths.ruleSetVersionId,
    ),
  );

  $$DueMonthsTableProcessedTableManager get dueMonthsRefs {
    final manager = $$DueMonthsTableTableManager($_db, $_db.dueMonths).filter(
      (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_dueMonthsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DefaultEnforcementStepsTable,
    List<DefaultEnforcementStepRow>
  >
  _defaultEnforcementStepsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.defaultEnforcementSteps,
        aliasName: $_aliasNameGenerator(
          db.ruleSetVersions.id,
          db.defaultEnforcementSteps.ruleSetVersionId,
        ),
      );

  $$DefaultEnforcementStepsTableProcessedTableManager
  get defaultEnforcementStepsRefs {
    final manager =
        $$DefaultEnforcementStepsTableTableManager(
          $_db,
          $_db.defaultEnforcementSteps,
        ).filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _defaultEnforcementStepsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DrawRecordsTable, List<DrawRecordRow>>
  _drawRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.drawRecords,
    aliasName: $_aliasNameGenerator(
      db.ruleSetVersions.id,
      db.drawRecords.ruleSetVersionId,
    ),
  );

  $$DrawRecordsTableProcessedTableManager get drawRecordsRefs {
    final manager = $$DrawRecordsTableTableManager($_db, $_db.drawRecords)
        .filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_drawRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DrawWitnessApprovalsTable,
    List<DrawWitnessApprovalRow>
  >
  _drawWitnessApprovalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.drawWitnessApprovals,
        aliasName: $_aliasNameGenerator(
          db.ruleSetVersions.id,
          db.drawWitnessApprovals.ruleSetVersionId,
        ),
      );

  $$DrawWitnessApprovalsTableProcessedTableManager
  get drawWitnessApprovalsRefs {
    final manager =
        $$DrawWitnessApprovalsTableTableManager(
          $_db,
          $_db.drawWitnessApprovals,
        ).filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _drawWitnessApprovalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyStatementsTable, List<MonthlyStatementRow>>
  _monthlyStatementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.monthlyStatements,
        aliasName: $_aliasNameGenerator(
          db.ruleSetVersions.id,
          db.monthlyStatements.ruleSetVersionId,
        ),
      );

  $$MonthlyStatementsTableProcessedTableManager get monthlyStatementsRefs {
    final manager =
        $$MonthlyStatementsTableTableManager(
          $_db,
          $_db.monthlyStatements,
        ).filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _monthlyStatementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PayoutCollectionVerificationsTable,
    List<PayoutCollectionVerificationRow>
  >
  _payoutCollectionVerificationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.payoutCollectionVerifications,
        aliasName: $_aliasNameGenerator(
          db.ruleSetVersions.id,
          db.payoutCollectionVerifications.ruleSetVersionId,
        ),
      );

  $$PayoutCollectionVerificationsTableProcessedTableManager
  get payoutCollectionVerificationsRefs {
    final manager =
        $$PayoutCollectionVerificationsTableTableManager(
          $_db,
          $_db.payoutCollectionVerifications,
        ).filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _payoutCollectionVerificationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PayoutApprovalsTable, List<PayoutApprovalRow>>
  _payoutApprovalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payoutApprovals,
    aliasName: $_aliasNameGenerator(
      db.ruleSetVersions.id,
      db.payoutApprovals.ruleSetVersionId,
    ),
  );

  $$PayoutApprovalsTableProcessedTableManager get payoutApprovalsRefs {
    final manager =
        $$PayoutApprovalsTableTableManager($_db, $_db.payoutApprovals).filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _payoutApprovalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PayoutRecordsTable, List<PayoutRecordRow>>
  _payoutRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payoutRecords,
    aliasName: $_aliasNameGenerator(
      db.ruleSetVersions.id,
      db.payoutRecords.ruleSetVersionId,
    ),
  );

  $$PayoutRecordsTableProcessedTableManager get payoutRecordsRefs {
    final manager = $$PayoutRecordsTableTableManager($_db, $_db.payoutRecords)
        .filter(
          (f) => f.ruleSetVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_payoutRecordsRefsTable($_db));
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

  Expression<bool> ruleAmendmentsRefs(
    Expression<bool> Function($$RuleAmendmentsTableFilterComposer f) f,
  ) {
    final $$RuleAmendmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleAmendments,
      getReferencedColumn: (t) => t.proposedRuleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleAmendmentsTableFilterComposer(
            $db: $db,
            $table: $db.ruleAmendments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dueMonthsRefs(
    Expression<bool> Function($$DueMonthsTableFilterComposer f) f,
  ) {
    final $$DueMonthsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dueMonths,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DueMonthsTableFilterComposer(
            $db: $db,
            $table: $db.dueMonths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> defaultEnforcementStepsRefs(
    Expression<bool> Function($$DefaultEnforcementStepsTableFilterComposer f) f,
  ) {
    final $$DefaultEnforcementStepsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.defaultEnforcementSteps,
          getReferencedColumn: (t) => t.ruleSetVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DefaultEnforcementStepsTableFilterComposer(
                $db: $db,
                $table: $db.defaultEnforcementSteps,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> drawRecordsRefs(
    Expression<bool> Function($$DrawRecordsTableFilterComposer f) f,
  ) {
    final $$DrawRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableFilterComposer(
            $db: $db,
            $table: $db.drawRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> drawWitnessApprovalsRefs(
    Expression<bool> Function($$DrawWitnessApprovalsTableFilterComposer f) f,
  ) {
    final $$DrawWitnessApprovalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawWitnessApprovals,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawWitnessApprovalsTableFilterComposer(
            $db: $db,
            $table: $db.drawWitnessApprovals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyStatementsRefs(
    Expression<bool> Function($$MonthlyStatementsTableFilterComposer f) f,
  ) {
    final $$MonthlyStatementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyStatements,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyStatementsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyStatements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> payoutCollectionVerificationsRefs(
    Expression<bool> Function(
      $$PayoutCollectionVerificationsTableFilterComposer f,
    )
    f,
  ) {
    final $$PayoutCollectionVerificationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.payoutCollectionVerifications,
          getReferencedColumn: (t) => t.ruleSetVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PayoutCollectionVerificationsTableFilterComposer(
                $db: $db,
                $table: $db.payoutCollectionVerifications,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> payoutApprovalsRefs(
    Expression<bool> Function($$PayoutApprovalsTableFilterComposer f) f,
  ) {
    final $$PayoutApprovalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutApprovals,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutApprovalsTableFilterComposer(
            $db: $db,
            $table: $db.payoutApprovals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> payoutRecordsRefs(
    Expression<bool> Function($$PayoutRecordsTableFilterComposer f) f,
  ) {
    final $$PayoutRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutRecords,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutRecordsTableFilterComposer(
            $db: $db,
            $table: $db.payoutRecords,
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

  Expression<T> ruleAmendmentsRefs<T extends Object>(
    Expression<T> Function($$RuleAmendmentsTableAnnotationComposer a) f,
  ) {
    final $$RuleAmendmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleAmendments,
      getReferencedColumn: (t) => t.proposedRuleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RuleAmendmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.ruleAmendments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dueMonthsRefs<T extends Object>(
    Expression<T> Function($$DueMonthsTableAnnotationComposer a) f,
  ) {
    final $$DueMonthsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dueMonths,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DueMonthsTableAnnotationComposer(
            $db: $db,
            $table: $db.dueMonths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> defaultEnforcementStepsRefs<T extends Object>(
    Expression<T> Function($$DefaultEnforcementStepsTableAnnotationComposer a)
    f,
  ) {
    final $$DefaultEnforcementStepsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.defaultEnforcementSteps,
          getReferencedColumn: (t) => t.ruleSetVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DefaultEnforcementStepsTableAnnotationComposer(
                $db: $db,
                $table: $db.defaultEnforcementSteps,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> drawRecordsRefs<T extends Object>(
    Expression<T> Function($$DrawRecordsTableAnnotationComposer a) f,
  ) {
    final $$DrawRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.drawRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> drawWitnessApprovalsRefs<T extends Object>(
    Expression<T> Function($$DrawWitnessApprovalsTableAnnotationComposer a) f,
  ) {
    final $$DrawWitnessApprovalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.drawWitnessApprovals,
          getReferencedColumn: (t) => t.ruleSetVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DrawWitnessApprovalsTableAnnotationComposer(
                $db: $db,
                $table: $db.drawWitnessApprovals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> monthlyStatementsRefs<T extends Object>(
    Expression<T> Function($$MonthlyStatementsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyStatementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.monthlyStatements,
          getReferencedColumn: (t) => t.ruleSetVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyStatementsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyStatements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> payoutCollectionVerificationsRefs<T extends Object>(
    Expression<T> Function(
      $$PayoutCollectionVerificationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PayoutCollectionVerificationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.payoutCollectionVerifications,
          getReferencedColumn: (t) => t.ruleSetVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PayoutCollectionVerificationsTableAnnotationComposer(
                $db: $db,
                $table: $db.payoutCollectionVerifications,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> payoutApprovalsRefs<T extends Object>(
    Expression<T> Function($$PayoutApprovalsTableAnnotationComposer a) f,
  ) {
    final $$PayoutApprovalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutApprovals,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutApprovalsTableAnnotationComposer(
            $db: $db,
            $table: $db.payoutApprovals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> payoutRecordsRefs<T extends Object>(
    Expression<T> Function($$PayoutRecordsTableAnnotationComposer a) f,
  ) {
    final $$PayoutRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutRecords,
      getReferencedColumn: (t) => t.ruleSetVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.payoutRecords,
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
          PrefetchHooks Function({
            bool memberConsentsRefs,
            bool ruleAmendmentsRefs,
            bool dueMonthsRefs,
            bool defaultEnforcementStepsRefs,
            bool drawRecordsRefs,
            bool drawWitnessApprovalsRefs,
            bool monthlyStatementsRefs,
            bool payoutCollectionVerificationsRefs,
            bool payoutApprovalsRefs,
            bool payoutRecordsRefs,
          })
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
          prefetchHooksCallback:
              ({
                memberConsentsRefs = false,
                ruleAmendmentsRefs = false,
                dueMonthsRefs = false,
                defaultEnforcementStepsRefs = false,
                drawRecordsRefs = false,
                drawWitnessApprovalsRefs = false,
                monthlyStatementsRefs = false,
                payoutCollectionVerificationsRefs = false,
                payoutApprovalsRefs = false,
                payoutRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (memberConsentsRefs) db.memberConsents,
                    if (ruleAmendmentsRefs) db.ruleAmendments,
                    if (dueMonthsRefs) db.dueMonths,
                    if (defaultEnforcementStepsRefs) db.defaultEnforcementSteps,
                    if (drawRecordsRefs) db.drawRecords,
                    if (drawWitnessApprovalsRefs) db.drawWitnessApprovals,
                    if (monthlyStatementsRefs) db.monthlyStatements,
                    if (payoutCollectionVerificationsRefs)
                      db.payoutCollectionVerifications,
                    if (payoutApprovalsRefs) db.payoutApprovals,
                    if (payoutRecordsRefs) db.payoutRecords,
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
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ruleAmendmentsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          RuleAmendmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._ruleAmendmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).ruleAmendmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.proposedRuleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dueMonthsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          DueMonthRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._dueMonthsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).dueMonthsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (defaultEnforcementStepsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          DefaultEnforcementStepRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._defaultEnforcementStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).defaultEnforcementStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (drawRecordsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          DrawRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._drawRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).drawRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (drawWitnessApprovalsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          DrawWitnessApprovalRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._drawWitnessApprovalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).drawWitnessApprovalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyStatementsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          MonthlyStatementRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._monthlyStatementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyStatementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutCollectionVerificationsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          PayoutCollectionVerificationRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._payoutCollectionVerificationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutCollectionVerificationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutApprovalsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          PayoutApprovalRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._payoutApprovalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutApprovalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ruleSetVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutRecordsRefs)
                        await $_getPrefetchedData<
                          RuleSetVersionRow,
                          $RuleSetVersionsTable,
                          PayoutRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$RuleSetVersionsTableReferences
                              ._payoutRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RuleSetVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
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
      PrefetchHooks Function({
        bool memberConsentsRefs,
        bool ruleAmendmentsRefs,
        bool dueMonthsRefs,
        bool defaultEnforcementStepsRefs,
        bool drawRecordsRefs,
        bool drawWitnessApprovalsRefs,
        bool monthlyStatementsRefs,
        bool payoutCollectionVerificationsRefs,
        bool payoutApprovalsRefs,
        bool payoutRecordsRefs,
      })
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
typedef $$RuleAmendmentsTableCreateCompanionBuilder =
    RuleAmendmentsCompanion Function({
      required String id,
      required String shomitiId,
      required String baseRuleSetVersionId,
      required String proposedRuleSetVersionId,
      required String status,
      Value<String?> note,
      Value<String?> sharedReference,
      required DateTime createdAt,
      Value<DateTime?> appliedAt,
      Value<int> rowid,
    });
typedef $$RuleAmendmentsTableUpdateCompanionBuilder =
    RuleAmendmentsCompanion Function({
      Value<String> id,
      Value<String> shomitiId,
      Value<String> baseRuleSetVersionId,
      Value<String> proposedRuleSetVersionId,
      Value<String> status,
      Value<String?> note,
      Value<String?> sharedReference,
      Value<DateTime> createdAt,
      Value<DateTime?> appliedAt,
      Value<int> rowid,
    });

final class $$RuleAmendmentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $RuleAmendmentsTable, RuleAmendmentRow> {
  $$RuleAmendmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.ruleAmendments.shomitiId, db.shomitis.id),
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

  static $RuleSetVersionsTable _proposedRuleSetVersionIdTable(
    _$AppDatabase db,
  ) => db.ruleSetVersions.createAlias(
    $_aliasNameGenerator(
      db.ruleAmendments.proposedRuleSetVersionId,
      db.ruleSetVersions.id,
    ),
  );

  $$RuleSetVersionsTableProcessedTableManager get proposedRuleSetVersionId {
    final $_column = $_itemColumn<String>('proposed_rule_set_version_id')!;

    final manager = $$RuleSetVersionsTableTableManager(
      $_db,
      $_db.ruleSetVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _proposedRuleSetVersionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RuleAmendmentsTableFilterComposer
    extends Composer<_$AppDatabase, $RuleAmendmentsTable> {
  $$RuleAmendmentsTableFilterComposer({
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

  ColumnFilters<String> get baseRuleSetVersionId => $composableBuilder(
    column: $table.baseRuleSetVersionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sharedReference => $composableBuilder(
    column: $table.sharedReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
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

  $$RuleSetVersionsTableFilterComposer get proposedRuleSetVersionId {
    final $$RuleSetVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposedRuleSetVersionId,
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
}

class $$RuleAmendmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $RuleAmendmentsTable> {
  $$RuleAmendmentsTableOrderingComposer({
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

  ColumnOrderings<String> get baseRuleSetVersionId => $composableBuilder(
    column: $table.baseRuleSetVersionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sharedReference => $composableBuilder(
    column: $table.sharedReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appliedAt => $composableBuilder(
    column: $table.appliedAt,
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

  $$RuleSetVersionsTableOrderingComposer get proposedRuleSetVersionId {
    final $$RuleSetVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposedRuleSetVersionId,
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
}

class $$RuleAmendmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RuleAmendmentsTable> {
  $$RuleAmendmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseRuleSetVersionId => $composableBuilder(
    column: $table.baseRuleSetVersionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get sharedReference => $composableBuilder(
    column: $table.sharedReference,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get appliedAt =>
      $composableBuilder(column: $table.appliedAt, builder: (column) => column);

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

  $$RuleSetVersionsTableAnnotationComposer get proposedRuleSetVersionId {
    final $$RuleSetVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proposedRuleSetVersionId,
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
}

class $$RuleAmendmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RuleAmendmentsTable,
          RuleAmendmentRow,
          $$RuleAmendmentsTableFilterComposer,
          $$RuleAmendmentsTableOrderingComposer,
          $$RuleAmendmentsTableAnnotationComposer,
          $$RuleAmendmentsTableCreateCompanionBuilder,
          $$RuleAmendmentsTableUpdateCompanionBuilder,
          (RuleAmendmentRow, $$RuleAmendmentsTableReferences),
          RuleAmendmentRow,
          PrefetchHooks Function({
            bool shomitiId,
            bool proposedRuleSetVersionId,
          })
        > {
  $$RuleAmendmentsTableTableManager(
    _$AppDatabase db,
    $RuleAmendmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RuleAmendmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RuleAmendmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RuleAmendmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<String> baseRuleSetVersionId = const Value.absent(),
                Value<String> proposedRuleSetVersionId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> sharedReference = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> appliedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RuleAmendmentsCompanion(
                id: id,
                shomitiId: shomitiId,
                baseRuleSetVersionId: baseRuleSetVersionId,
                proposedRuleSetVersionId: proposedRuleSetVersionId,
                status: status,
                note: note,
                sharedReference: sharedReference,
                createdAt: createdAt,
                appliedAt: appliedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shomitiId,
                required String baseRuleSetVersionId,
                required String proposedRuleSetVersionId,
                required String status,
                Value<String?> note = const Value.absent(),
                Value<String?> sharedReference = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> appliedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RuleAmendmentsCompanion.insert(
                id: id,
                shomitiId: shomitiId,
                baseRuleSetVersionId: baseRuleSetVersionId,
                proposedRuleSetVersionId: proposedRuleSetVersionId,
                status: status,
                note: note,
                sharedReference: sharedReference,
                createdAt: createdAt,
                appliedAt: appliedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RuleAmendmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shomitiId = false, proposedRuleSetVersionId = false}) {
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
                                        $$RuleAmendmentsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$RuleAmendmentsTableReferences
                                            ._shomitiIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (proposedRuleSetVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn:
                                        table.proposedRuleSetVersionId,
                                    referencedTable:
                                        $$RuleAmendmentsTableReferences
                                            ._proposedRuleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$RuleAmendmentsTableReferences
                                            ._proposedRuleSetVersionIdTable(db)
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

typedef $$RuleAmendmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RuleAmendmentsTable,
      RuleAmendmentRow,
      $$RuleAmendmentsTableFilterComposer,
      $$RuleAmendmentsTableOrderingComposer,
      $$RuleAmendmentsTableAnnotationComposer,
      $$RuleAmendmentsTableCreateCompanionBuilder,
      $$RuleAmendmentsTableUpdateCompanionBuilder,
      (RuleAmendmentRow, $$RuleAmendmentsTableReferences),
      RuleAmendmentRow,
      PrefetchHooks Function({bool shomitiId, bool proposedRuleSetVersionId})
    >;
typedef $$MembershipChangeRequestsTableCreateCompanionBuilder =
    MembershipChangeRequestsCompanion Function({
      required String id,
      required String shomitiId,
      required String outgoingMemberId,
      required String type,
      Value<bool> requiresReplacement,
      Value<String?> replacementCandidateName,
      Value<String?> replacementCandidatePhone,
      Value<String?> removalReasonCode,
      Value<String?> removalReasonDetails,
      required DateTime requestedAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> finalizedAt,
      Value<int> rowid,
    });
typedef $$MembershipChangeRequestsTableUpdateCompanionBuilder =
    MembershipChangeRequestsCompanion Function({
      Value<String> id,
      Value<String> shomitiId,
      Value<String> outgoingMemberId,
      Value<String> type,
      Value<bool> requiresReplacement,
      Value<String?> replacementCandidateName,
      Value<String?> replacementCandidatePhone,
      Value<String?> removalReasonCode,
      Value<String?> removalReasonDetails,
      Value<DateTime> requestedAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> finalizedAt,
      Value<int> rowid,
    });

final class $$MembershipChangeRequestsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MembershipChangeRequestsTable,
          MembershipChangeRequestRow
        > {
  $$MembershipChangeRequestsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(
          db.membershipChangeRequests.shomitiId,
          db.shomitis.id,
        ),
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

  static $MembersTable _outgoingMemberIdTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(
          db.membershipChangeRequests.outgoingMemberId,
          db.members.id,
        ),
      );

  $$MembersTableProcessedTableManager get outgoingMemberId {
    final $_column = $_itemColumn<String>('outgoing_member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_outgoingMemberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $MembershipChangeApprovalsTable,
    List<MembershipChangeApprovalRow>
  >
  _membershipChangeApprovalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.membershipChangeApprovals,
        aliasName: $_aliasNameGenerator(
          db.membershipChangeRequests.id,
          db.membershipChangeApprovals.requestId,
        ),
      );

  $$MembershipChangeApprovalsTableProcessedTableManager
  get membershipChangeApprovalsRefs {
    final manager = $$MembershipChangeApprovalsTableTableManager(
      $_db,
      $_db.membershipChangeApprovals,
    ).filter((f) => f.requestId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _membershipChangeApprovalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MembershipChangeRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipChangeRequestsTable> {
  $$MembershipChangeRequestsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresReplacement => $composableBuilder(
    column: $table.requiresReplacement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replacementCandidateName => $composableBuilder(
    column: $table.replacementCandidateName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replacementCandidatePhone => $composableBuilder(
    column: $table.replacementCandidatePhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get removalReasonCode => $composableBuilder(
    column: $table.removalReasonCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get removalReasonDetails => $composableBuilder(
    column: $table.removalReasonDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
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

  $$MembersTableFilterComposer get outgoingMemberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.outgoingMemberId,
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

  Expression<bool> membershipChangeApprovalsRefs(
    Expression<bool> Function($$MembershipChangeApprovalsTableFilterComposer f)
    f,
  ) {
    final $$MembershipChangeApprovalsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeApprovals,
          getReferencedColumn: (t) => t.requestId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeApprovalsTableFilterComposer(
                $db: $db,
                $table: $db.membershipChangeApprovals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MembershipChangeRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipChangeRequestsTable> {
  $$MembershipChangeRequestsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresReplacement => $composableBuilder(
    column: $table.requiresReplacement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replacementCandidateName => $composableBuilder(
    column: $table.replacementCandidateName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replacementCandidatePhone => $composableBuilder(
    column: $table.replacementCandidatePhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get removalReasonCode => $composableBuilder(
    column: $table.removalReasonCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get removalReasonDetails => $composableBuilder(
    column: $table.removalReasonDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
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

  $$MembersTableOrderingComposer get outgoingMemberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.outgoingMemberId,
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

class $$MembershipChangeRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipChangeRequestsTable> {
  $$MembershipChangeRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get requiresReplacement => $composableBuilder(
    column: $table.requiresReplacement,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replacementCandidateName => $composableBuilder(
    column: $table.replacementCandidateName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replacementCandidatePhone => $composableBuilder(
    column: $table.replacementCandidatePhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get removalReasonCode => $composableBuilder(
    column: $table.removalReasonCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get removalReasonDetails => $composableBuilder(
    column: $table.removalReasonDetails,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
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

  $$MembersTableAnnotationComposer get outgoingMemberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.outgoingMemberId,
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

  Expression<T> membershipChangeApprovalsRefs<T extends Object>(
    Expression<T> Function($$MembershipChangeApprovalsTableAnnotationComposer a)
    f,
  ) {
    final $$MembershipChangeApprovalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.membershipChangeApprovals,
          getReferencedColumn: (t) => t.requestId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeApprovalsTableAnnotationComposer(
                $db: $db,
                $table: $db.membershipChangeApprovals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MembershipChangeRequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembershipChangeRequestsTable,
          MembershipChangeRequestRow,
          $$MembershipChangeRequestsTableFilterComposer,
          $$MembershipChangeRequestsTableOrderingComposer,
          $$MembershipChangeRequestsTableAnnotationComposer,
          $$MembershipChangeRequestsTableCreateCompanionBuilder,
          $$MembershipChangeRequestsTableUpdateCompanionBuilder,
          (
            MembershipChangeRequestRow,
            $$MembershipChangeRequestsTableReferences,
          ),
          MembershipChangeRequestRow,
          PrefetchHooks Function({
            bool shomitiId,
            bool outgoingMemberId,
            bool membershipChangeApprovalsRefs,
          })
        > {
  $$MembershipChangeRequestsTableTableManager(
    _$AppDatabase db,
    $MembershipChangeRequestsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipChangeRequestsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MembershipChangeRequestsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MembershipChangeRequestsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<String> outgoingMemberId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> requiresReplacement = const Value.absent(),
                Value<String?> replacementCandidateName = const Value.absent(),
                Value<String?> replacementCandidatePhone = const Value.absent(),
                Value<String?> removalReasonCode = const Value.absent(),
                Value<String?> removalReasonDetails = const Value.absent(),
                Value<DateTime> requestedAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipChangeRequestsCompanion(
                id: id,
                shomitiId: shomitiId,
                outgoingMemberId: outgoingMemberId,
                type: type,
                requiresReplacement: requiresReplacement,
                replacementCandidateName: replacementCandidateName,
                replacementCandidatePhone: replacementCandidatePhone,
                removalReasonCode: removalReasonCode,
                removalReasonDetails: removalReasonDetails,
                requestedAt: requestedAt,
                updatedAt: updatedAt,
                finalizedAt: finalizedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shomitiId,
                required String outgoingMemberId,
                required String type,
                Value<bool> requiresReplacement = const Value.absent(),
                Value<String?> replacementCandidateName = const Value.absent(),
                Value<String?> replacementCandidatePhone = const Value.absent(),
                Value<String?> removalReasonCode = const Value.absent(),
                Value<String?> removalReasonDetails = const Value.absent(),
                required DateTime requestedAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipChangeRequestsCompanion.insert(
                id: id,
                shomitiId: shomitiId,
                outgoingMemberId: outgoingMemberId,
                type: type,
                requiresReplacement: requiresReplacement,
                replacementCandidateName: replacementCandidateName,
                replacementCandidatePhone: replacementCandidatePhone,
                removalReasonCode: removalReasonCode,
                removalReasonDetails: removalReasonDetails,
                requestedAt: requestedAt,
                updatedAt: updatedAt,
                finalizedAt: finalizedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembershipChangeRequestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shomitiId = false,
                outgoingMemberId = false,
                membershipChangeApprovalsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (membershipChangeApprovalsRefs)
                      db.membershipChangeApprovals,
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
                                    referencedTable:
                                        $$MembershipChangeRequestsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$MembershipChangeRequestsTableReferences
                                            ._shomitiIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (outgoingMemberId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.outgoingMemberId,
                                    referencedTable:
                                        $$MembershipChangeRequestsTableReferences
                                            ._outgoingMemberIdTable(db),
                                    referencedColumn:
                                        $$MembershipChangeRequestsTableReferences
                                            ._outgoingMemberIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (membershipChangeApprovalsRefs)
                        await $_getPrefetchedData<
                          MembershipChangeRequestRow,
                          $MembershipChangeRequestsTable,
                          MembershipChangeApprovalRow
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MembershipChangeRequestsTableReferences
                                  ._membershipChangeApprovalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembershipChangeRequestsTableReferences(
                                db,
                                table,
                                p0,
                              ).membershipChangeApprovalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.requestId == item.id,
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

typedef $$MembershipChangeRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembershipChangeRequestsTable,
      MembershipChangeRequestRow,
      $$MembershipChangeRequestsTableFilterComposer,
      $$MembershipChangeRequestsTableOrderingComposer,
      $$MembershipChangeRequestsTableAnnotationComposer,
      $$MembershipChangeRequestsTableCreateCompanionBuilder,
      $$MembershipChangeRequestsTableUpdateCompanionBuilder,
      (MembershipChangeRequestRow, $$MembershipChangeRequestsTableReferences),
      MembershipChangeRequestRow,
      PrefetchHooks Function({
        bool shomitiId,
        bool outgoingMemberId,
        bool membershipChangeApprovalsRefs,
      })
    >;
typedef $$MembershipChangeApprovalsTableCreateCompanionBuilder =
    MembershipChangeApprovalsCompanion Function({
      required String shomitiId,
      required String requestId,
      required String approverMemberId,
      required DateTime approvedAt,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$MembershipChangeApprovalsTableUpdateCompanionBuilder =
    MembershipChangeApprovalsCompanion Function({
      Value<String> shomitiId,
      Value<String> requestId,
      Value<String> approverMemberId,
      Value<DateTime> approvedAt,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$MembershipChangeApprovalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MembershipChangeApprovalsTable,
          MembershipChangeApprovalRow
        > {
  $$MembershipChangeApprovalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(
          db.membershipChangeApprovals.shomitiId,
          db.shomitis.id,
        ),
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

  static $MembershipChangeRequestsTable _requestIdTable(_$AppDatabase db) =>
      db.membershipChangeRequests.createAlias(
        $_aliasNameGenerator(
          db.membershipChangeApprovals.requestId,
          db.membershipChangeRequests.id,
        ),
      );

  $$MembershipChangeRequestsTableProcessedTableManager get requestId {
    final $_column = $_itemColumn<String>('request_id')!;

    final manager = $$MembershipChangeRequestsTableTableManager(
      $_db,
      $_db.membershipChangeRequests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_requestIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MembershipChangeApprovalsTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipChangeApprovalsTable> {
  $$MembershipChangeApprovalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get approverMemberId => $composableBuilder(
    column: $table.approverMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
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

  $$MembershipChangeRequestsTableFilterComposer get requestId {
    final $$MembershipChangeRequestsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.requestId,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableFilterComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MembershipChangeApprovalsTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipChangeApprovalsTable> {
  $$MembershipChangeApprovalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get approverMemberId => $composableBuilder(
    column: $table.approverMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
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

  $$MembershipChangeRequestsTableOrderingComposer get requestId {
    final $$MembershipChangeRequestsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.requestId,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableOrderingComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MembershipChangeApprovalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipChangeApprovalsTable> {
  $$MembershipChangeApprovalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get approverMemberId => $composableBuilder(
    column: $table.approverMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

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

  $$MembershipChangeRequestsTableAnnotationComposer get requestId {
    final $$MembershipChangeRequestsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.requestId,
          referencedTable: $db.membershipChangeRequests,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MembershipChangeRequestsTableAnnotationComposer(
                $db: $db,
                $table: $db.membershipChangeRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MembershipChangeApprovalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembershipChangeApprovalsTable,
          MembershipChangeApprovalRow,
          $$MembershipChangeApprovalsTableFilterComposer,
          $$MembershipChangeApprovalsTableOrderingComposer,
          $$MembershipChangeApprovalsTableAnnotationComposer,
          $$MembershipChangeApprovalsTableCreateCompanionBuilder,
          $$MembershipChangeApprovalsTableUpdateCompanionBuilder,
          (
            MembershipChangeApprovalRow,
            $$MembershipChangeApprovalsTableReferences,
          ),
          MembershipChangeApprovalRow,
          PrefetchHooks Function({bool shomitiId, bool requestId})
        > {
  $$MembershipChangeApprovalsTableTableManager(
    _$AppDatabase db,
    $MembershipChangeApprovalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipChangeApprovalsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MembershipChangeApprovalsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MembershipChangeApprovalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> requestId = const Value.absent(),
                Value<String> approverMemberId = const Value.absent(),
                Value<DateTime> approvedAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipChangeApprovalsCompanion(
                shomitiId: shomitiId,
                requestId: requestId,
                approverMemberId: approverMemberId,
                approvedAt: approvedAt,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String requestId,
                required String approverMemberId,
                required DateTime approvedAt,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipChangeApprovalsCompanion.insert(
                shomitiId: shomitiId,
                requestId: requestId,
                approverMemberId: approverMemberId,
                approvedAt: approvedAt,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembershipChangeApprovalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shomitiId = false, requestId = false}) {
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
                                    $$MembershipChangeApprovalsTableReferences
                                        ._shomitiIdTable(db),
                                referencedColumn:
                                    $$MembershipChangeApprovalsTableReferences
                                        ._shomitiIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (requestId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.requestId,
                                referencedTable:
                                    $$MembershipChangeApprovalsTableReferences
                                        ._requestIdTable(db),
                                referencedColumn:
                                    $$MembershipChangeApprovalsTableReferences
                                        ._requestIdTable(db)
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

typedef $$MembershipChangeApprovalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembershipChangeApprovalsTable,
      MembershipChangeApprovalRow,
      $$MembershipChangeApprovalsTableFilterComposer,
      $$MembershipChangeApprovalsTableOrderingComposer,
      $$MembershipChangeApprovalsTableAnnotationComposer,
      $$MembershipChangeApprovalsTableCreateCompanionBuilder,
      $$MembershipChangeApprovalsTableUpdateCompanionBuilder,
      (MembershipChangeApprovalRow, $$MembershipChangeApprovalsTableReferences),
      MembershipChangeApprovalRow,
      PrefetchHooks Function({bool shomitiId, bool requestId})
    >;
typedef $$DueMonthsTableCreateCompanionBuilder =
    DueMonthsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String ruleSetVersionId,
      required DateTime generatedAt,
      Value<int> rowid,
    });
typedef $$DueMonthsTableUpdateCompanionBuilder =
    DueMonthsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> ruleSetVersionId,
      Value<DateTime> generatedAt,
      Value<int> rowid,
    });

final class $$DueMonthsTableReferences
    extends BaseReferences<_$AppDatabase, $DueMonthsTable, DueMonthRow> {
  $$DueMonthsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.dueMonths.shomitiId, db.shomitis.id),
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

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.dueMonths.ruleSetVersionId,
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
}

class $$DueMonthsTableFilterComposer
    extends Composer<_$AppDatabase, $DueMonthsTable> {
  $$DueMonthsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
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
}

class $$DueMonthsTableOrderingComposer
    extends Composer<_$AppDatabase, $DueMonthsTable> {
  $$DueMonthsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
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
}

class $$DueMonthsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DueMonthsTable> {
  $$DueMonthsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
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
}

class $$DueMonthsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DueMonthsTable,
          DueMonthRow,
          $$DueMonthsTableFilterComposer,
          $$DueMonthsTableOrderingComposer,
          $$DueMonthsTableAnnotationComposer,
          $$DueMonthsTableCreateCompanionBuilder,
          $$DueMonthsTableUpdateCompanionBuilder,
          (DueMonthRow, $$DueMonthsTableReferences),
          DueMonthRow,
          PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
        > {
  $$DueMonthsTableTableManager(_$AppDatabase db, $DueMonthsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DueMonthsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DueMonthsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DueMonthsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DueMonthsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String ruleSetVersionId,
                required DateTime generatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DueMonthsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DueMonthsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shomitiId = false, ruleSetVersionId = false}) {
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
                                    referencedTable: $$DueMonthsTableReferences
                                        ._shomitiIdTable(db),
                                    referencedColumn: $$DueMonthsTableReferences
                                        ._shomitiIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (ruleSetVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ruleSetVersionId,
                                    referencedTable: $$DueMonthsTableReferences
                                        ._ruleSetVersionIdTable(db),
                                    referencedColumn: $$DueMonthsTableReferences
                                        ._ruleSetVersionIdTable(db)
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

typedef $$DueMonthsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DueMonthsTable,
      DueMonthRow,
      $$DueMonthsTableFilterComposer,
      $$DueMonthsTableOrderingComposer,
      $$DueMonthsTableAnnotationComposer,
      $$DueMonthsTableCreateCompanionBuilder,
      $$DueMonthsTableUpdateCompanionBuilder,
      (DueMonthRow, $$DueMonthsTableReferences),
      DueMonthRow,
      PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
    >;
typedef $$MonthlyDuesTableCreateCompanionBuilder =
    MonthlyDuesCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String memberId,
      required int shares,
      required int shareValueBdt,
      required int dueAmountBdt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$MonthlyDuesTableUpdateCompanionBuilder =
    MonthlyDuesCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> memberId,
      Value<int> shares,
      Value<int> shareValueBdt,
      Value<int> dueAmountBdt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MonthlyDuesTableReferences
    extends BaseReferences<_$AppDatabase, $MonthlyDuesTable, MonthlyDueRow> {
  $$MonthlyDuesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.monthlyDues.shomitiId, db.shomitis.id),
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
        $_aliasNameGenerator(db.monthlyDues.memberId, db.members.id),
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

class $$MonthlyDuesTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyDuesTable> {
  $$MonthlyDuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shareValueBdt => $composableBuilder(
    column: $table.shareValueBdt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueAmountBdt => $composableBuilder(
    column: $table.dueAmountBdt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$MonthlyDuesTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyDuesTable> {
  $$MonthlyDuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shareValueBdt => $composableBuilder(
    column: $table.shareValueBdt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueAmountBdt => $composableBuilder(
    column: $table.dueAmountBdt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$MonthlyDuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyDuesTable> {
  $$MonthlyDuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<int> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<int> get shareValueBdt => $composableBuilder(
    column: $table.shareValueBdt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueAmountBdt => $composableBuilder(
    column: $table.dueAmountBdt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

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

class $$MonthlyDuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyDuesTable,
          MonthlyDueRow,
          $$MonthlyDuesTableFilterComposer,
          $$MonthlyDuesTableOrderingComposer,
          $$MonthlyDuesTableAnnotationComposer,
          $$MonthlyDuesTableCreateCompanionBuilder,
          $$MonthlyDuesTableUpdateCompanionBuilder,
          (MonthlyDueRow, $$MonthlyDuesTableReferences),
          MonthlyDueRow,
          PrefetchHooks Function({bool shomitiId, bool memberId})
        > {
  $$MonthlyDuesTableTableManager(_$AppDatabase db, $MonthlyDuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyDuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyDuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyDuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<int> shares = const Value.absent(),
                Value<int> shareValueBdt = const Value.absent(),
                Value<int> dueAmountBdt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyDuesCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                memberId: memberId,
                shares: shares,
                shareValueBdt: shareValueBdt,
                dueAmountBdt: dueAmountBdt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String memberId,
                required int shares,
                required int shareValueBdt,
                required int dueAmountBdt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyDuesCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                memberId: memberId,
                shares: shares,
                shareValueBdt: shareValueBdt,
                dueAmountBdt: dueAmountBdt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyDuesTableReferences(db, table, e),
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
                                referencedTable: $$MonthlyDuesTableReferences
                                    ._shomitiIdTable(db),
                                referencedColumn: $$MonthlyDuesTableReferences
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
                                referencedTable: $$MonthlyDuesTableReferences
                                    ._memberIdTable(db),
                                referencedColumn: $$MonthlyDuesTableReferences
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

typedef $$MonthlyDuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyDuesTable,
      MonthlyDueRow,
      $$MonthlyDuesTableFilterComposer,
      $$MonthlyDuesTableOrderingComposer,
      $$MonthlyDuesTableAnnotationComposer,
      $$MonthlyDuesTableCreateCompanionBuilder,
      $$MonthlyDuesTableUpdateCompanionBuilder,
      (MonthlyDueRow, $$MonthlyDuesTableReferences),
      MonthlyDueRow,
      PrefetchHooks Function({bool shomitiId, bool memberId})
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      required String id,
      required String shomitiId,
      required String monthKey,
      required String memberId,
      required int amountBdt,
      required String method,
      required String reference,
      Value<String?> proofNote,
      required DateTime recordedAt,
      required DateTime confirmedAt,
      Value<String?> receiptNumber,
      Value<DateTime?> receiptIssuedAt,
      Value<int> rowid,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<String> id,
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> memberId,
      Value<int> amountBdt,
      Value<String> method,
      Value<String> reference,
      Value<String?> proofNote,
      Value<DateTime> recordedAt,
      Value<DateTime> confirmedAt,
      Value<String?> receiptNumber,
      Value<DateTime?> receiptIssuedAt,
      Value<int> rowid,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) => db.shomitis
      .createAlias($_aliasNameGenerator(db.payments.shomitiId, db.shomitis.id));

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

  static $MembersTable _memberIdTable(_$AppDatabase db) => db.members
      .createAlias($_aliasNameGenerator(db.payments.memberId, db.members.id));

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

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofNote => $composableBuilder(
    column: $table.proofNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receiptIssuedAt => $composableBuilder(
    column: $table.receiptIssuedAt,
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

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofNote => $composableBuilder(
    column: $table.proofNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receiptIssuedAt => $composableBuilder(
    column: $table.receiptIssuedAt,
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

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<int> get amountBdt =>
      $composableBuilder(column: $table.amountBdt, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get proofNote =>
      $composableBuilder(column: $table.proofNote, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get confirmedAt => $composableBuilder(
    column: $table.confirmedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptNumber => $composableBuilder(
    column: $table.receiptNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get receiptIssuedAt => $composableBuilder(
    column: $table.receiptIssuedAt,
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

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentRow,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (PaymentRow, $$PaymentsTableReferences),
          PaymentRow,
          PrefetchHooks Function({bool shomitiId, bool memberId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<int> amountBdt = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<String?> proofNote = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime> confirmedAt = const Value.absent(),
                Value<String?> receiptNumber = const Value.absent(),
                Value<DateTime?> receiptIssuedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                shomitiId: shomitiId,
                monthKey: monthKey,
                memberId: memberId,
                amountBdt: amountBdt,
                method: method,
                reference: reference,
                proofNote: proofNote,
                recordedAt: recordedAt,
                confirmedAt: confirmedAt,
                receiptNumber: receiptNumber,
                receiptIssuedAt: receiptIssuedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shomitiId,
                required String monthKey,
                required String memberId,
                required int amountBdt,
                required String method,
                required String reference,
                Value<String?> proofNote = const Value.absent(),
                required DateTime recordedAt,
                required DateTime confirmedAt,
                Value<String?> receiptNumber = const Value.absent(),
                Value<DateTime?> receiptIssuedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                shomitiId: shomitiId,
                monthKey: monthKey,
                memberId: memberId,
                amountBdt: amountBdt,
                method: method,
                reference: reference,
                proofNote: proofNote,
                recordedAt: recordedAt,
                confirmedAt: confirmedAt,
                receiptNumber: receiptNumber,
                receiptIssuedAt: receiptIssuedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
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
                                referencedTable: $$PaymentsTableReferences
                                    ._shomitiIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
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
                                referencedTable: $$PaymentsTableReferences
                                    ._memberIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
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

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentRow,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentRow, $$PaymentsTableReferences),
      PaymentRow,
      PrefetchHooks Function({bool shomitiId, bool memberId})
    >;
typedef $$CollectionResolutionsTableCreateCompanionBuilder =
    CollectionResolutionsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String method,
      required int amountBdt,
      Value<String?> note,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CollectionResolutionsTableUpdateCompanionBuilder =
    CollectionResolutionsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> method,
      Value<int> amountBdt,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CollectionResolutionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionResolutionsTable,
          CollectionResolutionRow
        > {
  $$CollectionResolutionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(
          db.collectionResolutions.shomitiId,
          db.shomitis.id,
        ),
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

class $$CollectionResolutionsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionResolutionsTable> {
  $$CollectionResolutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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
}

class $$CollectionResolutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionResolutionsTable> {
  $$CollectionResolutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$CollectionResolutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionResolutionsTable> {
  $$CollectionResolutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<int> get amountBdt =>
      $composableBuilder(column: $table.amountBdt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

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

class $$CollectionResolutionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionResolutionsTable,
          CollectionResolutionRow,
          $$CollectionResolutionsTableFilterComposer,
          $$CollectionResolutionsTableOrderingComposer,
          $$CollectionResolutionsTableAnnotationComposer,
          $$CollectionResolutionsTableCreateCompanionBuilder,
          $$CollectionResolutionsTableUpdateCompanionBuilder,
          (CollectionResolutionRow, $$CollectionResolutionsTableReferences),
          CollectionResolutionRow,
          PrefetchHooks Function({bool shomitiId})
        > {
  $$CollectionResolutionsTableTableManager(
    _$AppDatabase db,
    $CollectionResolutionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionResolutionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CollectionResolutionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CollectionResolutionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<int> amountBdt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CollectionResolutionsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                method: method,
                amountBdt: amountBdt,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String method,
                required int amountBdt,
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CollectionResolutionsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                method: method,
                amountBdt: amountBdt,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionResolutionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shomitiId = false}) {
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
                                    $$CollectionResolutionsTableReferences
                                        ._shomitiIdTable(db),
                                referencedColumn:
                                    $$CollectionResolutionsTableReferences
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

typedef $$CollectionResolutionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionResolutionsTable,
      CollectionResolutionRow,
      $$CollectionResolutionsTableFilterComposer,
      $$CollectionResolutionsTableOrderingComposer,
      $$CollectionResolutionsTableAnnotationComposer,
      $$CollectionResolutionsTableCreateCompanionBuilder,
      $$CollectionResolutionsTableUpdateCompanionBuilder,
      (CollectionResolutionRow, $$CollectionResolutionsTableReferences),
      CollectionResolutionRow,
      PrefetchHooks Function({bool shomitiId})
    >;
typedef $$DefaultEnforcementStepsTableCreateCompanionBuilder =
    DefaultEnforcementStepsCompanion Function({
      Value<int> id,
      required String shomitiId,
      required String memberId,
      required String episodeKey,
      required String stepType,
      required String ruleSetVersionId,
      required DateTime recordedAt,
      Value<String?> note,
      Value<int?> amountBdt,
    });
typedef $$DefaultEnforcementStepsTableUpdateCompanionBuilder =
    DefaultEnforcementStepsCompanion Function({
      Value<int> id,
      Value<String> shomitiId,
      Value<String> memberId,
      Value<String> episodeKey,
      Value<String> stepType,
      Value<String> ruleSetVersionId,
      Value<DateTime> recordedAt,
      Value<String?> note,
      Value<int?> amountBdt,
    });

final class $$DefaultEnforcementStepsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DefaultEnforcementStepsTable,
          DefaultEnforcementStepRow
        > {
  $$DefaultEnforcementStepsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(
          db.defaultEnforcementSteps.shomitiId,
          db.shomitis.id,
        ),
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
        $_aliasNameGenerator(
          db.defaultEnforcementSteps.memberId,
          db.members.id,
        ),
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
          db.defaultEnforcementSteps.ruleSetVersionId,
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
}

class $$DefaultEnforcementStepsTableFilterComposer
    extends Composer<_$AppDatabase, $DefaultEnforcementStepsTable> {
  $$DefaultEnforcementStepsTableFilterComposer({
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

  ColumnFilters<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepType => $composableBuilder(
    column: $table.stepType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
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
}

class $$DefaultEnforcementStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $DefaultEnforcementStepsTable> {
  $$DefaultEnforcementStepsTableOrderingComposer({
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

  ColumnOrderings<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepType => $composableBuilder(
    column: $table.stepType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
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
}

class $$DefaultEnforcementStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DefaultEnforcementStepsTable> {
  $$DefaultEnforcementStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get episodeKey => $composableBuilder(
    column: $table.episodeKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stepType =>
      $composableBuilder(column: $table.stepType, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get amountBdt =>
      $composableBuilder(column: $table.amountBdt, builder: (column) => column);

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
}

class $$DefaultEnforcementStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DefaultEnforcementStepsTable,
          DefaultEnforcementStepRow,
          $$DefaultEnforcementStepsTableFilterComposer,
          $$DefaultEnforcementStepsTableOrderingComposer,
          $$DefaultEnforcementStepsTableAnnotationComposer,
          $$DefaultEnforcementStepsTableCreateCompanionBuilder,
          $$DefaultEnforcementStepsTableUpdateCompanionBuilder,
          (DefaultEnforcementStepRow, $$DefaultEnforcementStepsTableReferences),
          DefaultEnforcementStepRow,
          PrefetchHooks Function({
            bool shomitiId,
            bool memberId,
            bool ruleSetVersionId,
          })
        > {
  $$DefaultEnforcementStepsTableTableManager(
    _$AppDatabase db,
    $DefaultEnforcementStepsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DefaultEnforcementStepsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DefaultEnforcementStepsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DefaultEnforcementStepsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> episodeKey = const Value.absent(),
                Value<String> stepType = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> amountBdt = const Value.absent(),
              }) => DefaultEnforcementStepsCompanion(
                id: id,
                shomitiId: shomitiId,
                memberId: memberId,
                episodeKey: episodeKey,
                stepType: stepType,
                ruleSetVersionId: ruleSetVersionId,
                recordedAt: recordedAt,
                note: note,
                amountBdt: amountBdt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String shomitiId,
                required String memberId,
                required String episodeKey,
                required String stepType,
                required String ruleSetVersionId,
                required DateTime recordedAt,
                Value<String?> note = const Value.absent(),
                Value<int?> amountBdt = const Value.absent(),
              }) => DefaultEnforcementStepsCompanion.insert(
                id: id,
                shomitiId: shomitiId,
                memberId: memberId,
                episodeKey: episodeKey,
                stepType: stepType,
                ruleSetVersionId: ruleSetVersionId,
                recordedAt: recordedAt,
                note: note,
                amountBdt: amountBdt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DefaultEnforcementStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shomitiId = false,
                memberId = false,
                ruleSetVersionId = false,
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
                        if (shomitiId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shomitiId,
                                    referencedTable:
                                        $$DefaultEnforcementStepsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$DefaultEnforcementStepsTableReferences
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
                                        $$DefaultEnforcementStepsTableReferences
                                            ._memberIdTable(db),
                                    referencedColumn:
                                        $$DefaultEnforcementStepsTableReferences
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
                                        $$DefaultEnforcementStepsTableReferences
                                            ._ruleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$DefaultEnforcementStepsTableReferences
                                            ._ruleSetVersionIdTable(db)
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

typedef $$DefaultEnforcementStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DefaultEnforcementStepsTable,
      DefaultEnforcementStepRow,
      $$DefaultEnforcementStepsTableFilterComposer,
      $$DefaultEnforcementStepsTableOrderingComposer,
      $$DefaultEnforcementStepsTableAnnotationComposer,
      $$DefaultEnforcementStepsTableCreateCompanionBuilder,
      $$DefaultEnforcementStepsTableUpdateCompanionBuilder,
      (DefaultEnforcementStepRow, $$DefaultEnforcementStepsTableReferences),
      DefaultEnforcementStepRow,
      PrefetchHooks Function({
        bool shomitiId,
        bool memberId,
        bool ruleSetVersionId,
      })
    >;
typedef $$DrawRecordsTableCreateCompanionBuilder =
    DrawRecordsCompanion Function({
      required String id,
      required String shomitiId,
      required String monthKey,
      required String ruleSetVersionId,
      required String method,
      required String proofReference,
      Value<String?> notes,
      required String winnerMemberId,
      required int winnerShareIndex,
      required String eligibleShareKeysJson,
      Value<String?> redoOfDrawId,
      Value<DateTime?> invalidatedAt,
      Value<String?> invalidatedReason,
      Value<DateTime?> finalizedAt,
      required DateTime recordedAt,
      Value<int> rowid,
    });
typedef $$DrawRecordsTableUpdateCompanionBuilder =
    DrawRecordsCompanion Function({
      Value<String> id,
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> ruleSetVersionId,
      Value<String> method,
      Value<String> proofReference,
      Value<String?> notes,
      Value<String> winnerMemberId,
      Value<int> winnerShareIndex,
      Value<String> eligibleShareKeysJson,
      Value<String?> redoOfDrawId,
      Value<DateTime?> invalidatedAt,
      Value<String?> invalidatedReason,
      Value<DateTime?> finalizedAt,
      Value<DateTime> recordedAt,
      Value<int> rowid,
    });

final class $$DrawRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $DrawRecordsTable, DrawRecordRow> {
  $$DrawRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.drawRecords.shomitiId, db.shomitis.id),
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

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.drawRecords.ruleSetVersionId,
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

  static MultiTypedResultKey<
    $DrawWitnessApprovalsTable,
    List<DrawWitnessApprovalRow>
  >
  _drawWitnessApprovalsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.drawWitnessApprovals,
        aliasName: $_aliasNameGenerator(
          db.drawRecords.id,
          db.drawWitnessApprovals.drawId,
        ),
      );

  $$DrawWitnessApprovalsTableProcessedTableManager
  get drawWitnessApprovalsRefs {
    final manager = $$DrawWitnessApprovalsTableTableManager(
      $_db,
      $_db.drawWitnessApprovals,
    ).filter((f) => f.drawId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _drawWitnessApprovalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PayoutRecordsTable, List<PayoutRecordRow>>
  _payoutRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payoutRecords,
    aliasName: $_aliasNameGenerator(db.drawRecords.id, db.payoutRecords.drawId),
  );

  $$PayoutRecordsTableProcessedTableManager get payoutRecordsRefs {
    final manager = $$PayoutRecordsTableTableManager(
      $_db,
      $_db.payoutRecords,
    ).filter((f) => f.drawId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_payoutRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DrawRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DrawRecordsTable> {
  $$DrawRecordsTableFilterComposer({
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

  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get winnerMemberId => $composableBuilder(
    column: $table.winnerMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get winnerShareIndex => $composableBuilder(
    column: $table.winnerShareIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eligibleShareKeysJson => $composableBuilder(
    column: $table.eligibleShareKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get redoOfDrawId => $composableBuilder(
    column: $table.redoOfDrawId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invalidatedAt => $composableBuilder(
    column: $table.invalidatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invalidatedReason => $composableBuilder(
    column: $table.invalidatedReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
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

  Expression<bool> drawWitnessApprovalsRefs(
    Expression<bool> Function($$DrawWitnessApprovalsTableFilterComposer f) f,
  ) {
    final $$DrawWitnessApprovalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drawWitnessApprovals,
      getReferencedColumn: (t) => t.drawId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawWitnessApprovalsTableFilterComposer(
            $db: $db,
            $table: $db.drawWitnessApprovals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> payoutRecordsRefs(
    Expression<bool> Function($$PayoutRecordsTableFilterComposer f) f,
  ) {
    final $$PayoutRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutRecords,
      getReferencedColumn: (t) => t.drawId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutRecordsTableFilterComposer(
            $db: $db,
            $table: $db.payoutRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DrawRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrawRecordsTable> {
  $$DrawRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get winnerMemberId => $composableBuilder(
    column: $table.winnerMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get winnerShareIndex => $composableBuilder(
    column: $table.winnerShareIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eligibleShareKeysJson => $composableBuilder(
    column: $table.eligibleShareKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get redoOfDrawId => $composableBuilder(
    column: $table.redoOfDrawId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invalidatedAt => $composableBuilder(
    column: $table.invalidatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invalidatedReason => $composableBuilder(
    column: $table.invalidatedReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
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
}

class $$DrawRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrawRecordsTable> {
  $$DrawRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get winnerMemberId => $composableBuilder(
    column: $table.winnerMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get winnerShareIndex => $composableBuilder(
    column: $table.winnerShareIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eligibleShareKeysJson => $composableBuilder(
    column: $table.eligibleShareKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get redoOfDrawId => $composableBuilder(
    column: $table.redoOfDrawId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get invalidatedAt => $composableBuilder(
    column: $table.invalidatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invalidatedReason => $composableBuilder(
    column: $table.invalidatedReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
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

  Expression<T> drawWitnessApprovalsRefs<T extends Object>(
    Expression<T> Function($$DrawWitnessApprovalsTableAnnotationComposer a) f,
  ) {
    final $$DrawWitnessApprovalsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.drawWitnessApprovals,
          getReferencedColumn: (t) => t.drawId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DrawWitnessApprovalsTableAnnotationComposer(
                $db: $db,
                $table: $db.drawWitnessApprovals,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> payoutRecordsRefs<T extends Object>(
    Expression<T> Function($$PayoutRecordsTableAnnotationComposer a) f,
  ) {
    final $$PayoutRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payoutRecords,
      getReferencedColumn: (t) => t.drawId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PayoutRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.payoutRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DrawRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrawRecordsTable,
          DrawRecordRow,
          $$DrawRecordsTableFilterComposer,
          $$DrawRecordsTableOrderingComposer,
          $$DrawRecordsTableAnnotationComposer,
          $$DrawRecordsTableCreateCompanionBuilder,
          $$DrawRecordsTableUpdateCompanionBuilder,
          (DrawRecordRow, $$DrawRecordsTableReferences),
          DrawRecordRow,
          PrefetchHooks Function({
            bool shomitiId,
            bool ruleSetVersionId,
            bool drawWitnessApprovalsRefs,
            bool payoutRecordsRefs,
          })
        > {
  $$DrawRecordsTableTableManager(_$AppDatabase db, $DrawRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrawRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrawRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrawRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> proofReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> winnerMemberId = const Value.absent(),
                Value<int> winnerShareIndex = const Value.absent(),
                Value<String> eligibleShareKeysJson = const Value.absent(),
                Value<String?> redoOfDrawId = const Value.absent(),
                Value<DateTime?> invalidatedAt = const Value.absent(),
                Value<String?> invalidatedReason = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrawRecordsCompanion(
                id: id,
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                method: method,
                proofReference: proofReference,
                notes: notes,
                winnerMemberId: winnerMemberId,
                winnerShareIndex: winnerShareIndex,
                eligibleShareKeysJson: eligibleShareKeysJson,
                redoOfDrawId: redoOfDrawId,
                invalidatedAt: invalidatedAt,
                invalidatedReason: invalidatedReason,
                finalizedAt: finalizedAt,
                recordedAt: recordedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shomitiId,
                required String monthKey,
                required String ruleSetVersionId,
                required String method,
                required String proofReference,
                Value<String?> notes = const Value.absent(),
                required String winnerMemberId,
                required int winnerShareIndex,
                required String eligibleShareKeysJson,
                Value<String?> redoOfDrawId = const Value.absent(),
                Value<DateTime?> invalidatedAt = const Value.absent(),
                Value<String?> invalidatedReason = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                required DateTime recordedAt,
                Value<int> rowid = const Value.absent(),
              }) => DrawRecordsCompanion.insert(
                id: id,
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                method: method,
                proofReference: proofReference,
                notes: notes,
                winnerMemberId: winnerMemberId,
                winnerShareIndex: winnerShareIndex,
                eligibleShareKeysJson: eligibleShareKeysJson,
                redoOfDrawId: redoOfDrawId,
                invalidatedAt: invalidatedAt,
                invalidatedReason: invalidatedReason,
                finalizedAt: finalizedAt,
                recordedAt: recordedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DrawRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shomitiId = false,
                ruleSetVersionId = false,
                drawWitnessApprovalsRefs = false,
                payoutRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (drawWitnessApprovalsRefs) db.drawWitnessApprovals,
                    if (payoutRecordsRefs) db.payoutRecords,
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
                                    referencedTable:
                                        $$DrawRecordsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$DrawRecordsTableReferences
                                            ._shomitiIdTable(db)
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
                                        $$DrawRecordsTableReferences
                                            ._ruleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$DrawRecordsTableReferences
                                            ._ruleSetVersionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (drawWitnessApprovalsRefs)
                        await $_getPrefetchedData<
                          DrawRecordRow,
                          $DrawRecordsTable,
                          DrawWitnessApprovalRow
                        >(
                          currentTable: table,
                          referencedTable: $$DrawRecordsTableReferences
                              ._drawWitnessApprovalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DrawRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).drawWitnessApprovalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.drawId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (payoutRecordsRefs)
                        await $_getPrefetchedData<
                          DrawRecordRow,
                          $DrawRecordsTable,
                          PayoutRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$DrawRecordsTableReferences
                              ._payoutRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DrawRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).payoutRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.drawId == item.id,
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

typedef $$DrawRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrawRecordsTable,
      DrawRecordRow,
      $$DrawRecordsTableFilterComposer,
      $$DrawRecordsTableOrderingComposer,
      $$DrawRecordsTableAnnotationComposer,
      $$DrawRecordsTableCreateCompanionBuilder,
      $$DrawRecordsTableUpdateCompanionBuilder,
      (DrawRecordRow, $$DrawRecordsTableReferences),
      DrawRecordRow,
      PrefetchHooks Function({
        bool shomitiId,
        bool ruleSetVersionId,
        bool drawWitnessApprovalsRefs,
        bool payoutRecordsRefs,
      })
    >;
typedef $$DrawWitnessApprovalsTableCreateCompanionBuilder =
    DrawWitnessApprovalsCompanion Function({
      required String drawId,
      required String witnessMemberId,
      required String ruleSetVersionId,
      Value<String?> note,
      required DateTime approvedAt,
      Value<int> rowid,
    });
typedef $$DrawWitnessApprovalsTableUpdateCompanionBuilder =
    DrawWitnessApprovalsCompanion Function({
      Value<String> drawId,
      Value<String> witnessMemberId,
      Value<String> ruleSetVersionId,
      Value<String?> note,
      Value<DateTime> approvedAt,
      Value<int> rowid,
    });

final class $$DrawWitnessApprovalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DrawWitnessApprovalsTable,
          DrawWitnessApprovalRow
        > {
  $$DrawWitnessApprovalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DrawRecordsTable _drawIdTable(_$AppDatabase db) =>
      db.drawRecords.createAlias(
        $_aliasNameGenerator(db.drawWitnessApprovals.drawId, db.drawRecords.id),
      );

  $$DrawRecordsTableProcessedTableManager get drawId {
    final $_column = $_itemColumn<String>('draw_id')!;

    final manager = $$DrawRecordsTableTableManager(
      $_db,
      $_db.drawRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drawIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.drawWitnessApprovals.ruleSetVersionId,
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
}

class $$DrawWitnessApprovalsTableFilterComposer
    extends Composer<_$AppDatabase, $DrawWitnessApprovalsTable> {
  $$DrawWitnessApprovalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get witnessMemberId => $composableBuilder(
    column: $table.witnessMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DrawRecordsTableFilterComposer get drawId {
    final $$DrawRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drawId,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableFilterComposer(
            $db: $db,
            $table: $db.drawRecords,
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
}

class $$DrawWitnessApprovalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrawWitnessApprovalsTable> {
  $$DrawWitnessApprovalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get witnessMemberId => $composableBuilder(
    column: $table.witnessMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DrawRecordsTableOrderingComposer get drawId {
    final $$DrawRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drawId,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.drawRecords,
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
}

class $$DrawWitnessApprovalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrawWitnessApprovalsTable> {
  $$DrawWitnessApprovalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get witnessMemberId => $composableBuilder(
    column: $table.witnessMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );

  $$DrawRecordsTableAnnotationComposer get drawId {
    final $$DrawRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drawId,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.drawRecords,
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
}

class $$DrawWitnessApprovalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrawWitnessApprovalsTable,
          DrawWitnessApprovalRow,
          $$DrawWitnessApprovalsTableFilterComposer,
          $$DrawWitnessApprovalsTableOrderingComposer,
          $$DrawWitnessApprovalsTableAnnotationComposer,
          $$DrawWitnessApprovalsTableCreateCompanionBuilder,
          $$DrawWitnessApprovalsTableUpdateCompanionBuilder,
          (DrawWitnessApprovalRow, $$DrawWitnessApprovalsTableReferences),
          DrawWitnessApprovalRow,
          PrefetchHooks Function({bool drawId, bool ruleSetVersionId})
        > {
  $$DrawWitnessApprovalsTableTableManager(
    _$AppDatabase db,
    $DrawWitnessApprovalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrawWitnessApprovalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrawWitnessApprovalsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DrawWitnessApprovalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> drawId = const Value.absent(),
                Value<String> witnessMemberId = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> approvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrawWitnessApprovalsCompanion(
                drawId: drawId,
                witnessMemberId: witnessMemberId,
                ruleSetVersionId: ruleSetVersionId,
                note: note,
                approvedAt: approvedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String drawId,
                required String witnessMemberId,
                required String ruleSetVersionId,
                Value<String?> note = const Value.absent(),
                required DateTime approvedAt,
                Value<int> rowid = const Value.absent(),
              }) => DrawWitnessApprovalsCompanion.insert(
                drawId: drawId,
                witnessMemberId: witnessMemberId,
                ruleSetVersionId: ruleSetVersionId,
                note: note,
                approvedAt: approvedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DrawWitnessApprovalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({drawId = false, ruleSetVersionId = false}) {
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
                    if (drawId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.drawId,
                                referencedTable:
                                    $$DrawWitnessApprovalsTableReferences
                                        ._drawIdTable(db),
                                referencedColumn:
                                    $$DrawWitnessApprovalsTableReferences
                                        ._drawIdTable(db)
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
                                    $$DrawWitnessApprovalsTableReferences
                                        ._ruleSetVersionIdTable(db),
                                referencedColumn:
                                    $$DrawWitnessApprovalsTableReferences
                                        ._ruleSetVersionIdTable(db)
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

typedef $$DrawWitnessApprovalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrawWitnessApprovalsTable,
      DrawWitnessApprovalRow,
      $$DrawWitnessApprovalsTableFilterComposer,
      $$DrawWitnessApprovalsTableOrderingComposer,
      $$DrawWitnessApprovalsTableAnnotationComposer,
      $$DrawWitnessApprovalsTableCreateCompanionBuilder,
      $$DrawWitnessApprovalsTableUpdateCompanionBuilder,
      (DrawWitnessApprovalRow, $$DrawWitnessApprovalsTableReferences),
      DrawWitnessApprovalRow,
      PrefetchHooks Function({bool drawId, bool ruleSetVersionId})
    >;
typedef $$MonthlyStatementsTableCreateCompanionBuilder =
    MonthlyStatementsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String ruleSetVersionId,
      required String json,
      required DateTime generatedAt,
      Value<int> rowid,
    });
typedef $$MonthlyStatementsTableUpdateCompanionBuilder =
    MonthlyStatementsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> ruleSetVersionId,
      Value<String> json,
      Value<DateTime> generatedAt,
      Value<int> rowid,
    });

final class $$MonthlyStatementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MonthlyStatementsTable,
          MonthlyStatementRow
        > {
  $$MonthlyStatementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.monthlyStatements.shomitiId, db.shomitis.id),
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

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.monthlyStatements.ruleSetVersionId,
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
}

class $$MonthlyStatementsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyStatementsTable> {
  $$MonthlyStatementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
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
}

class $$MonthlyStatementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyStatementsTable> {
  $$MonthlyStatementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
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
}

class $$MonthlyStatementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyStatementsTable> {
  $$MonthlyStatementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
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
}

class $$MonthlyStatementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyStatementsTable,
          MonthlyStatementRow,
          $$MonthlyStatementsTableFilterComposer,
          $$MonthlyStatementsTableOrderingComposer,
          $$MonthlyStatementsTableAnnotationComposer,
          $$MonthlyStatementsTableCreateCompanionBuilder,
          $$MonthlyStatementsTableUpdateCompanionBuilder,
          (MonthlyStatementRow, $$MonthlyStatementsTableReferences),
          MonthlyStatementRow,
          PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
        > {
  $$MonthlyStatementsTableTableManager(
    _$AppDatabase db,
    $MonthlyStatementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyStatementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyStatementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyStatementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyStatementsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                json: json,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String ruleSetVersionId,
                required String json,
                required DateTime generatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyStatementsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                json: json,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyStatementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shomitiId = false, ruleSetVersionId = false}) {
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
                                        $$MonthlyStatementsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$MonthlyStatementsTableReferences
                                            ._shomitiIdTable(db)
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
                                        $$MonthlyStatementsTableReferences
                                            ._ruleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$MonthlyStatementsTableReferences
                                            ._ruleSetVersionIdTable(db)
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

typedef $$MonthlyStatementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyStatementsTable,
      MonthlyStatementRow,
      $$MonthlyStatementsTableFilterComposer,
      $$MonthlyStatementsTableOrderingComposer,
      $$MonthlyStatementsTableAnnotationComposer,
      $$MonthlyStatementsTableCreateCompanionBuilder,
      $$MonthlyStatementsTableUpdateCompanionBuilder,
      (MonthlyStatementRow, $$MonthlyStatementsTableReferences),
      MonthlyStatementRow,
      PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
    >;
typedef $$StatementSignoffsTableCreateCompanionBuilder =
    StatementSignoffsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String signerMemberId,
      required String signerRole,
      required String proofReference,
      Value<String?> note,
      required DateTime signedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StatementSignoffsTableUpdateCompanionBuilder =
    StatementSignoffsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> signerMemberId,
      Value<String> signerRole,
      Value<String> proofReference,
      Value<String?> note,
      Value<DateTime> signedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$StatementSignoffsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StatementSignoffsTable,
          StatementSignoffRow
        > {
  $$StatementSignoffsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.statementSignoffs.shomitiId, db.shomitis.id),
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

  static $MembersTable _signerMemberIdTable(_$AppDatabase db) =>
      db.members.createAlias(
        $_aliasNameGenerator(
          db.statementSignoffs.signerMemberId,
          db.members.id,
        ),
      );

  $$MembersTableProcessedTableManager get signerMemberId {
    final $_column = $_itemColumn<String>('signer_member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_signerMemberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StatementSignoffsTableFilterComposer
    extends Composer<_$AppDatabase, $StatementSignoffsTable> {
  $$StatementSignoffsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signerRole => $composableBuilder(
    column: $table.signerRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get signedAt => $composableBuilder(
    column: $table.signedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

  $$MembersTableFilterComposer get signerMemberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.signerMemberId,
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

class $$StatementSignoffsTableOrderingComposer
    extends Composer<_$AppDatabase, $StatementSignoffsTable> {
  $$StatementSignoffsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signerRole => $composableBuilder(
    column: $table.signerRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get signedAt => $composableBuilder(
    column: $table.signedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

  $$MembersTableOrderingComposer get signerMemberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.signerMemberId,
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

class $$StatementSignoffsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatementSignoffsTable> {
  $$StatementSignoffsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get signerRole => $composableBuilder(
    column: $table.signerRole,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get signedAt =>
      $composableBuilder(column: $table.signedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

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

  $$MembersTableAnnotationComposer get signerMemberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.signerMemberId,
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

class $$StatementSignoffsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StatementSignoffsTable,
          StatementSignoffRow,
          $$StatementSignoffsTableFilterComposer,
          $$StatementSignoffsTableOrderingComposer,
          $$StatementSignoffsTableAnnotationComposer,
          $$StatementSignoffsTableCreateCompanionBuilder,
          $$StatementSignoffsTableUpdateCompanionBuilder,
          (StatementSignoffRow, $$StatementSignoffsTableReferences),
          StatementSignoffRow,
          PrefetchHooks Function({bool shomitiId, bool signerMemberId})
        > {
  $$StatementSignoffsTableTableManager(
    _$AppDatabase db,
    $StatementSignoffsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatementSignoffsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatementSignoffsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatementSignoffsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> signerMemberId = const Value.absent(),
                Value<String> signerRole = const Value.absent(),
                Value<String> proofReference = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> signedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StatementSignoffsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                signerMemberId: signerMemberId,
                signerRole: signerRole,
                proofReference: proofReference,
                note: note,
                signedAt: signedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String signerMemberId,
                required String signerRole,
                required String proofReference,
                Value<String?> note = const Value.absent(),
                required DateTime signedAt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StatementSignoffsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                signerMemberId: signerMemberId,
                signerRole: signerRole,
                proofReference: proofReference,
                note: note,
                signedAt: signedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StatementSignoffsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shomitiId = false, signerMemberId = false}) {
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
                                    $$StatementSignoffsTableReferences
                                        ._shomitiIdTable(db),
                                referencedColumn:
                                    $$StatementSignoffsTableReferences
                                        ._shomitiIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (signerMemberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.signerMemberId,
                                referencedTable:
                                    $$StatementSignoffsTableReferences
                                        ._signerMemberIdTable(db),
                                referencedColumn:
                                    $$StatementSignoffsTableReferences
                                        ._signerMemberIdTable(db)
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

typedef $$StatementSignoffsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StatementSignoffsTable,
      StatementSignoffRow,
      $$StatementSignoffsTableFilterComposer,
      $$StatementSignoffsTableOrderingComposer,
      $$StatementSignoffsTableAnnotationComposer,
      $$StatementSignoffsTableCreateCompanionBuilder,
      $$StatementSignoffsTableUpdateCompanionBuilder,
      (StatementSignoffRow, $$StatementSignoffsTableReferences),
      StatementSignoffRow,
      PrefetchHooks Function({bool shomitiId, bool signerMemberId})
    >;
typedef $$PayoutCollectionVerificationsTableCreateCompanionBuilder =
    PayoutCollectionVerificationsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String ruleSetVersionId,
      required String verifiedByMemberId,
      Value<String?> note,
      required DateTime verifiedAt,
      Value<int> rowid,
    });
typedef $$PayoutCollectionVerificationsTableUpdateCompanionBuilder =
    PayoutCollectionVerificationsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> ruleSetVersionId,
      Value<String> verifiedByMemberId,
      Value<String?> note,
      Value<DateTime> verifiedAt,
      Value<int> rowid,
    });

final class $$PayoutCollectionVerificationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PayoutCollectionVerificationsTable,
          PayoutCollectionVerificationRow
        > {
  $$PayoutCollectionVerificationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(
          db.payoutCollectionVerifications.shomitiId,
          db.shomitis.id,
        ),
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

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.payoutCollectionVerifications.ruleSetVersionId,
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
}

class $$PayoutCollectionVerificationsTableFilterComposer
    extends Composer<_$AppDatabase, $PayoutCollectionVerificationsTable> {
  $$PayoutCollectionVerificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verifiedByMemberId => $composableBuilder(
    column: $table.verifiedByMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
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
}

class $$PayoutCollectionVerificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PayoutCollectionVerificationsTable> {
  $$PayoutCollectionVerificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verifiedByMemberId => $composableBuilder(
    column: $table.verifiedByMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
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
}

class $$PayoutCollectionVerificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayoutCollectionVerificationsTable> {
  $$PayoutCollectionVerificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get verifiedByMemberId => $composableBuilder(
    column: $table.verifiedByMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get verifiedAt => $composableBuilder(
    column: $table.verifiedAt,
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
}

class $$PayoutCollectionVerificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayoutCollectionVerificationsTable,
          PayoutCollectionVerificationRow,
          $$PayoutCollectionVerificationsTableFilterComposer,
          $$PayoutCollectionVerificationsTableOrderingComposer,
          $$PayoutCollectionVerificationsTableAnnotationComposer,
          $$PayoutCollectionVerificationsTableCreateCompanionBuilder,
          $$PayoutCollectionVerificationsTableUpdateCompanionBuilder,
          (
            PayoutCollectionVerificationRow,
            $$PayoutCollectionVerificationsTableReferences,
          ),
          PayoutCollectionVerificationRow,
          PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
        > {
  $$PayoutCollectionVerificationsTableTableManager(
    _$AppDatabase db,
    $PayoutCollectionVerificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayoutCollectionVerificationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PayoutCollectionVerificationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PayoutCollectionVerificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String> verifiedByMemberId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> verifiedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayoutCollectionVerificationsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                verifiedByMemberId: verifiedByMemberId,
                note: note,
                verifiedAt: verifiedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String ruleSetVersionId,
                required String verifiedByMemberId,
                Value<String?> note = const Value.absent(),
                required DateTime verifiedAt,
                Value<int> rowid = const Value.absent(),
              }) => PayoutCollectionVerificationsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                ruleSetVersionId: ruleSetVersionId,
                verifiedByMemberId: verifiedByMemberId,
                note: note,
                verifiedAt: verifiedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PayoutCollectionVerificationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shomitiId = false, ruleSetVersionId = false}) {
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
                                    $$PayoutCollectionVerificationsTableReferences
                                        ._shomitiIdTable(db),
                                referencedColumn:
                                    $$PayoutCollectionVerificationsTableReferences
                                        ._shomitiIdTable(db)
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
                                    $$PayoutCollectionVerificationsTableReferences
                                        ._ruleSetVersionIdTable(db),
                                referencedColumn:
                                    $$PayoutCollectionVerificationsTableReferences
                                        ._ruleSetVersionIdTable(db)
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

typedef $$PayoutCollectionVerificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayoutCollectionVerificationsTable,
      PayoutCollectionVerificationRow,
      $$PayoutCollectionVerificationsTableFilterComposer,
      $$PayoutCollectionVerificationsTableOrderingComposer,
      $$PayoutCollectionVerificationsTableAnnotationComposer,
      $$PayoutCollectionVerificationsTableCreateCompanionBuilder,
      $$PayoutCollectionVerificationsTableUpdateCompanionBuilder,
      (
        PayoutCollectionVerificationRow,
        $$PayoutCollectionVerificationsTableReferences,
      ),
      PayoutCollectionVerificationRow,
      PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
    >;
typedef $$PayoutApprovalsTableCreateCompanionBuilder =
    PayoutApprovalsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String role,
      required String approverMemberId,
      required String ruleSetVersionId,
      Value<String?> note,
      required DateTime approvedAt,
      Value<int> rowid,
    });
typedef $$PayoutApprovalsTableUpdateCompanionBuilder =
    PayoutApprovalsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> role,
      Value<String> approverMemberId,
      Value<String> ruleSetVersionId,
      Value<String?> note,
      Value<DateTime> approvedAt,
      Value<int> rowid,
    });

final class $$PayoutApprovalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PayoutApprovalsTable,
          PayoutApprovalRow
        > {
  $$PayoutApprovalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.payoutApprovals.shomitiId, db.shomitis.id),
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

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.payoutApprovals.ruleSetVersionId,
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
}

class $$PayoutApprovalsTableFilterComposer
    extends Composer<_$AppDatabase, $PayoutApprovalsTable> {
  $$PayoutApprovalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approverMemberId => $composableBuilder(
    column: $table.approverMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
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
}

class $$PayoutApprovalsTableOrderingComposer
    extends Composer<_$AppDatabase, $PayoutApprovalsTable> {
  $$PayoutApprovalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approverMemberId => $composableBuilder(
    column: $table.approverMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
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
}

class $$PayoutApprovalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayoutApprovalsTable> {
  $$PayoutApprovalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get approverMemberId => $composableBuilder(
    column: $table.approverMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
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
}

class $$PayoutApprovalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayoutApprovalsTable,
          PayoutApprovalRow,
          $$PayoutApprovalsTableFilterComposer,
          $$PayoutApprovalsTableOrderingComposer,
          $$PayoutApprovalsTableAnnotationComposer,
          $$PayoutApprovalsTableCreateCompanionBuilder,
          $$PayoutApprovalsTableUpdateCompanionBuilder,
          (PayoutApprovalRow, $$PayoutApprovalsTableReferences),
          PayoutApprovalRow,
          PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
        > {
  $$PayoutApprovalsTableTableManager(
    _$AppDatabase db,
    $PayoutApprovalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayoutApprovalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayoutApprovalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayoutApprovalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> approverMemberId = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> approvedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayoutApprovalsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                role: role,
                approverMemberId: approverMemberId,
                ruleSetVersionId: ruleSetVersionId,
                note: note,
                approvedAt: approvedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String role,
                required String approverMemberId,
                required String ruleSetVersionId,
                Value<String?> note = const Value.absent(),
                required DateTime approvedAt,
                Value<int> rowid = const Value.absent(),
              }) => PayoutApprovalsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                role: role,
                approverMemberId: approverMemberId,
                ruleSetVersionId: ruleSetVersionId,
                note: note,
                approvedAt: approvedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PayoutApprovalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shomitiId = false, ruleSetVersionId = false}) {
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
                                        $$PayoutApprovalsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$PayoutApprovalsTableReferences
                                            ._shomitiIdTable(db)
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
                                        $$PayoutApprovalsTableReferences
                                            ._ruleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$PayoutApprovalsTableReferences
                                            ._ruleSetVersionIdTable(db)
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

typedef $$PayoutApprovalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayoutApprovalsTable,
      PayoutApprovalRow,
      $$PayoutApprovalsTableFilterComposer,
      $$PayoutApprovalsTableOrderingComposer,
      $$PayoutApprovalsTableAnnotationComposer,
      $$PayoutApprovalsTableCreateCompanionBuilder,
      $$PayoutApprovalsTableUpdateCompanionBuilder,
      (PayoutApprovalRow, $$PayoutApprovalsTableReferences),
      PayoutApprovalRow,
      PrefetchHooks Function({bool shomitiId, bool ruleSetVersionId})
    >;
typedef $$PayoutRecordsTableCreateCompanionBuilder =
    PayoutRecordsCompanion Function({
      required String shomitiId,
      required String monthKey,
      required String drawId,
      required String ruleSetVersionId,
      required String winnerMemberId,
      required int winnerShareIndex,
      required int amountBdt,
      Value<String?> proofReference,
      Value<String?> markedPaidByMemberId,
      Value<DateTime?> paidAt,
      required DateTime recordedAt,
      Value<int> rowid,
    });
typedef $$PayoutRecordsTableUpdateCompanionBuilder =
    PayoutRecordsCompanion Function({
      Value<String> shomitiId,
      Value<String> monthKey,
      Value<String> drawId,
      Value<String> ruleSetVersionId,
      Value<String> winnerMemberId,
      Value<int> winnerShareIndex,
      Value<int> amountBdt,
      Value<String?> proofReference,
      Value<String?> markedPaidByMemberId,
      Value<DateTime?> paidAt,
      Value<DateTime> recordedAt,
      Value<int> rowid,
    });

final class $$PayoutRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PayoutRecordsTable, PayoutRecordRow> {
  $$PayoutRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ShomitisTable _shomitiIdTable(_$AppDatabase db) =>
      db.shomitis.createAlias(
        $_aliasNameGenerator(db.payoutRecords.shomitiId, db.shomitis.id),
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

  static $DrawRecordsTable _drawIdTable(_$AppDatabase db) =>
      db.drawRecords.createAlias(
        $_aliasNameGenerator(db.payoutRecords.drawId, db.drawRecords.id),
      );

  $$DrawRecordsTableProcessedTableManager get drawId {
    final $_column = $_itemColumn<String>('draw_id')!;

    final manager = $$DrawRecordsTableTableManager(
      $_db,
      $_db.drawRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_drawIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RuleSetVersionsTable _ruleSetVersionIdTable(_$AppDatabase db) =>
      db.ruleSetVersions.createAlias(
        $_aliasNameGenerator(
          db.payoutRecords.ruleSetVersionId,
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
}

class $$PayoutRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PayoutRecordsTable> {
  $$PayoutRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get winnerMemberId => $composableBuilder(
    column: $table.winnerMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get winnerShareIndex => $composableBuilder(
    column: $table.winnerShareIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markedPaidByMemberId => $composableBuilder(
    column: $table.markedPaidByMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
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

  $$DrawRecordsTableFilterComposer get drawId {
    final $$DrawRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drawId,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableFilterComposer(
            $db: $db,
            $table: $db.drawRecords,
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
}

class $$PayoutRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PayoutRecordsTable> {
  $$PayoutRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get winnerMemberId => $composableBuilder(
    column: $table.winnerMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get winnerShareIndex => $composableBuilder(
    column: $table.winnerShareIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBdt => $composableBuilder(
    column: $table.amountBdt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markedPaidByMemberId => $composableBuilder(
    column: $table.markedPaidByMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
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

  $$DrawRecordsTableOrderingComposer get drawId {
    final $$DrawRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drawId,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.drawRecords,
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
}

class $$PayoutRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayoutRecordsTable> {
  $$PayoutRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get winnerMemberId => $composableBuilder(
    column: $table.winnerMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get winnerShareIndex => $composableBuilder(
    column: $table.winnerShareIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountBdt =>
      $composableBuilder(column: $table.amountBdt, builder: (column) => column);

  GeneratedColumn<String> get proofReference => $composableBuilder(
    column: $table.proofReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get markedPaidByMemberId => $composableBuilder(
    column: $table.markedPaidByMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
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

  $$DrawRecordsTableAnnotationComposer get drawId {
    final $$DrawRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.drawId,
      referencedTable: $db.drawRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrawRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.drawRecords,
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
}

class $$PayoutRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayoutRecordsTable,
          PayoutRecordRow,
          $$PayoutRecordsTableFilterComposer,
          $$PayoutRecordsTableOrderingComposer,
          $$PayoutRecordsTableAnnotationComposer,
          $$PayoutRecordsTableCreateCompanionBuilder,
          $$PayoutRecordsTableUpdateCompanionBuilder,
          (PayoutRecordRow, $$PayoutRecordsTableReferences),
          PayoutRecordRow,
          PrefetchHooks Function({
            bool shomitiId,
            bool drawId,
            bool ruleSetVersionId,
          })
        > {
  $$PayoutRecordsTableTableManager(_$AppDatabase db, $PayoutRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayoutRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayoutRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayoutRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> shomitiId = const Value.absent(),
                Value<String> monthKey = const Value.absent(),
                Value<String> drawId = const Value.absent(),
                Value<String> ruleSetVersionId = const Value.absent(),
                Value<String> winnerMemberId = const Value.absent(),
                Value<int> winnerShareIndex = const Value.absent(),
                Value<int> amountBdt = const Value.absent(),
                Value<String?> proofReference = const Value.absent(),
                Value<String?> markedPaidByMemberId = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayoutRecordsCompanion(
                shomitiId: shomitiId,
                monthKey: monthKey,
                drawId: drawId,
                ruleSetVersionId: ruleSetVersionId,
                winnerMemberId: winnerMemberId,
                winnerShareIndex: winnerShareIndex,
                amountBdt: amountBdt,
                proofReference: proofReference,
                markedPaidByMemberId: markedPaidByMemberId,
                paidAt: paidAt,
                recordedAt: recordedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shomitiId,
                required String monthKey,
                required String drawId,
                required String ruleSetVersionId,
                required String winnerMemberId,
                required int winnerShareIndex,
                required int amountBdt,
                Value<String?> proofReference = const Value.absent(),
                Value<String?> markedPaidByMemberId = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
                required DateTime recordedAt,
                Value<int> rowid = const Value.absent(),
              }) => PayoutRecordsCompanion.insert(
                shomitiId: shomitiId,
                monthKey: monthKey,
                drawId: drawId,
                ruleSetVersionId: ruleSetVersionId,
                winnerMemberId: winnerMemberId,
                winnerShareIndex: winnerShareIndex,
                amountBdt: amountBdt,
                proofReference: proofReference,
                markedPaidByMemberId: markedPaidByMemberId,
                paidAt: paidAt,
                recordedAt: recordedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PayoutRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shomitiId = false, drawId = false, ruleSetVersionId = false}) {
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
                                        $$PayoutRecordsTableReferences
                                            ._shomitiIdTable(db),
                                    referencedColumn:
                                        $$PayoutRecordsTableReferences
                                            ._shomitiIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (drawId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.drawId,
                                    referencedTable:
                                        $$PayoutRecordsTableReferences
                                            ._drawIdTable(db),
                                    referencedColumn:
                                        $$PayoutRecordsTableReferences
                                            ._drawIdTable(db)
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
                                        $$PayoutRecordsTableReferences
                                            ._ruleSetVersionIdTable(db),
                                    referencedColumn:
                                        $$PayoutRecordsTableReferences
                                            ._ruleSetVersionIdTable(db)
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

typedef $$PayoutRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayoutRecordsTable,
      PayoutRecordRow,
      $$PayoutRecordsTableFilterComposer,
      $$PayoutRecordsTableOrderingComposer,
      $$PayoutRecordsTableAnnotationComposer,
      $$PayoutRecordsTableCreateCompanionBuilder,
      $$PayoutRecordsTableUpdateCompanionBuilder,
      (PayoutRecordRow, $$PayoutRecordsTableReferences),
      PayoutRecordRow,
      PrefetchHooks Function({
        bool shomitiId,
        bool drawId,
        bool ruleSetVersionId,
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
  $$MemberSharesTableTableManager get memberShares =>
      $$MemberSharesTableTableManager(_db, _db.memberShares);
  $$GuarantorsTableTableManager get guarantors =>
      $$GuarantorsTableTableManager(_db, _db.guarantors);
  $$SecurityDepositsTableTableManager get securityDeposits =>
      $$SecurityDepositsTableTableManager(_db, _db.securityDeposits);
  $$RoleAssignmentsTableTableManager get roleAssignments =>
      $$RoleAssignmentsTableTableManager(_db, _db.roleAssignments);
  $$RuleSetVersionsTableTableManager get ruleSetVersions =>
      $$RuleSetVersionsTableTableManager(_db, _db.ruleSetVersions);
  $$MemberConsentsTableTableManager get memberConsents =>
      $$MemberConsentsTableTableManager(_db, _db.memberConsents);
  $$RuleAmendmentsTableTableManager get ruleAmendments =>
      $$RuleAmendmentsTableTableManager(_db, _db.ruleAmendments);
  $$MembershipChangeRequestsTableTableManager get membershipChangeRequests =>
      $$MembershipChangeRequestsTableTableManager(
        _db,
        _db.membershipChangeRequests,
      );
  $$MembershipChangeApprovalsTableTableManager get membershipChangeApprovals =>
      $$MembershipChangeApprovalsTableTableManager(
        _db,
        _db.membershipChangeApprovals,
      );
  $$DueMonthsTableTableManager get dueMonths =>
      $$DueMonthsTableTableManager(_db, _db.dueMonths);
  $$MonthlyDuesTableTableManager get monthlyDues =>
      $$MonthlyDuesTableTableManager(_db, _db.monthlyDues);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$CollectionResolutionsTableTableManager get collectionResolutions =>
      $$CollectionResolutionsTableTableManager(_db, _db.collectionResolutions);
  $$DefaultEnforcementStepsTableTableManager get defaultEnforcementSteps =>
      $$DefaultEnforcementStepsTableTableManager(
        _db,
        _db.defaultEnforcementSteps,
      );
  $$DrawRecordsTableTableManager get drawRecords =>
      $$DrawRecordsTableTableManager(_db, _db.drawRecords);
  $$DrawWitnessApprovalsTableTableManager get drawWitnessApprovals =>
      $$DrawWitnessApprovalsTableTableManager(_db, _db.drawWitnessApprovals);
  $$MonthlyStatementsTableTableManager get monthlyStatements =>
      $$MonthlyStatementsTableTableManager(_db, _db.monthlyStatements);
  $$StatementSignoffsTableTableManager get statementSignoffs =>
      $$StatementSignoffsTableTableManager(_db, _db.statementSignoffs);
  $$PayoutCollectionVerificationsTableTableManager
  get payoutCollectionVerifications =>
      $$PayoutCollectionVerificationsTableTableManager(
        _db,
        _db.payoutCollectionVerifications,
      );
  $$PayoutApprovalsTableTableManager get payoutApprovals =>
      $$PayoutApprovalsTableTableManager(_db, _db.payoutApprovals);
  $$PayoutRecordsTableTableManager get payoutRecords =>
      $$PayoutRecordsTableTableManager(_db, _db.payoutRecords);
}
