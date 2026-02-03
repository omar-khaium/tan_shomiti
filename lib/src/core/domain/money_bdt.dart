/// Money value object for Bangladeshi Taka (BDT) represented in minor units
/// (poisha).
///
/// Keep arithmetic and serialization within this type to avoid primitive
/// obsession.
class MoneyBdt {
  const MoneyBdt._(this.minorUnits);

  final int minorUnits;

  factory MoneyBdt.fromMinorUnits(int minorUnits) {
    return MoneyBdt._(minorUnits);
  }

  factory MoneyBdt.fromTaka(int taka) {
    return MoneyBdt._(taka * 100);
  }

  int get takaFloor => minorUnits ~/ 100;
}

