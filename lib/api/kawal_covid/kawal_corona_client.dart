import 'package:kawal_covid/api/kawal_covid/model/covid_summary.dart';
import 'package:kawal_covid/core/entity/api_response.dart';

abstract class KawalCovidClient {
  Future<ApiResponse<CovidSummary>> getIndonesiaSummary();
}
