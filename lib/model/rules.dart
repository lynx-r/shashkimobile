import 'package:quiver/iterables.dart';

class Rules {
  final _value;

  get dimension => _value;

  const Rules._internal(this._value);

  toString() => 'Rules.$_value';

//  static final RUSSIAN = new Rules(8);
//  static final RUSSIAN_GIVEAWAY = new Rules(8);
//  static final INTERNATIONAL = new Rules(10);
//  static final INTERNATIONAL_GIVEAWAY = new Rules(10);

  static const RUSSIAN = const Rules._internal(8);
  static const RUSSIAN_GIVEAWAY = const Rules._internal(8);
  static const INTERNATIONAL = const Rules._internal(10);
  static const INTERNATIONAL_GIVEAWAY = const Rules._internal(10);

  static getAllBoardLength(int dimesnion) {
    return range(dimesnion * dimesnion);
  }

  static Rules fromString(string) {
    switch (string) {
      case 'RUSSIAN':
        return RUSSIAN;
      case 'RUSSIAN_GIVEAWAY':
        return RUSSIAN_GIVEAWAY;
      case 'INTERNATIONAL':
        return INTERNATIONAL;
      case 'INTERNATIONAL_GIVEAWAY':
        return INTERNATIONAL_GIVEAWAY;
      default:
        throw new Exception('Indefined rules $string');
    }
  }
}
