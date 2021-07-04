import 'package:kawal_covid/core/util/integer_parser.dart';

class CovidSummary {
  final int positiveCount;
  final int recoveredCount;
  final int deathCount;
  final int treatedCount;

  CovidSummary({this.positiveCount, this.recoveredCount, this.deathCount, this.treatedCount});

  factory CovidSummary.fromJson(Map<String, dynamic> json) {
    return CovidSummary(
        positiveCount: IntegerParser.parseToIntegerOrZero(json['positif']),
        recoveredCount: IntegerParser.parseToIntegerOrZero(json['sembuh']),
        deathCount: IntegerParser.parseToIntegerOrZero(json['meninggal']),
        treatedCount: IntegerParser.parseToIntegerOrZero(json['dirawat']));
  }

  @override
  String toString() {
    return 'CovidSummary{positiveCount: $positiveCount, recoveredCount: $recoveredCount, deathCount: $deathCount, treatedCount: $treatedCount}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CovidSummary &&
          positiveCount == other.positiveCount &&
          recoveredCount == other.recoveredCount &&
          deathCount == other.deathCount &&
          treatedCount == other.treatedCount);

  @override
  int get hashCode => positiveCount.hashCode ^ recoveredCount.hashCode ^ deathCount.hashCode ^ treatedCount.hashCode;
}
