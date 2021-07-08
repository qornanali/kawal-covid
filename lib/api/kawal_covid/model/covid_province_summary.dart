import 'package:kawal_covid/api/kawal_covid/model/covid_summary.dart';

class CovidProvinceSummary extends CovidSummary {
  final String provinceName;

  CovidProvinceSummary({this.provinceName, positiveCount, recoveredCount, deathCount})
      : super(positiveCount: positiveCount, recoveredCount: recoveredCount, deathCount: deathCount, treatedCount: 0);

  factory CovidProvinceSummary.fromJson(Map<String, dynamic> json) {
    return CovidProvinceSummary(
        provinceName: json['Provinsi'],
        positiveCount: json["Kasus_Posi"],
        recoveredCount: json['Kasus_Semb'],
        deathCount: json['Kasus_Meni']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || super == other && other is CovidProvinceSummary && provinceName == other.provinceName;

  @override
  int get hashCode => super.hashCode ^ provinceName.hashCode;

  @override
  String toString() {
    return 'CovidProvinceSummary{provinceName: $provinceName, positiveCount: $positiveCount, recoveredCount: '
        '$recoveredCount, deathCount: $deathCount, treatedCount: $treatedCount}';
  }
}
