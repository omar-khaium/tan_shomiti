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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AuditEventsTable auditEvents = $AuditEventsTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final $RuleSetVersionsTable ruleSetVersions = $RuleSetVersionsTable(
    this,
  );
  late final $ShomitisTable shomitis = $ShomitisTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    auditEvents,
    ledgerEntries,
    ruleSetVersions,
    shomitis,
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
          (
            RuleSetVersionRow,
            BaseReferences<
              _$AppDatabase,
              $RuleSetVersionsTable,
              RuleSetVersionRow
            >,
          ),
          RuleSetVersionRow,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        RuleSetVersionRow,
        BaseReferences<_$AppDatabase, $RuleSetVersionsTable, RuleSetVersionRow>,
      ),
      RuleSetVersionRow,
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
          (
            ShomitiRow,
            BaseReferences<_$AppDatabase, $ShomitisTable, ShomitiRow>,
          ),
          ShomitiRow,
          PrefetchHooks Function()
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (ShomitiRow, BaseReferences<_$AppDatabase, $ShomitisTable, ShomitiRow>),
      ShomitiRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AuditEventsTableTableManager get auditEvents =>
      $$AuditEventsTableTableManager(_db, _db.auditEvents);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
  $$RuleSetVersionsTableTableManager get ruleSetVersions =>
      $$RuleSetVersionsTableTableManager(_db, _db.ruleSetVersions);
  $$ShomitisTableTableManager get shomitis =>
      $$ShomitisTableTableManager(_db, _db.shomitis);
}
