import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_province_summary.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_summary.dart';
import 'package:kawal_covid/core/entity/api_response.dart';

class KawalCovidClientImpl extends KawalCovidClient {
  static const String baseUrl = "https://api.kawalcorona.com";
  final http.Client _client;

  KawalCovidClientImpl(this._client);

  @override
  Future<ApiResponse<CovidSummary>> getIndonesiaSummary() async {
    var endpoint = Uri.parse("$baseUrl/indonesia");
    var response = await _client.get(endpoint);

    if (response.statusCode != 200 || response.body.isEmpty) {
      return ApiResponse.createErrorResponse();
    }

    var decodedJson = jsonDecode(response.body);
    var summary = CovidSummary.fromJson(decodedJson[0]);
    return ApiResponse.createSuccessResponse(summary);
  }

  @override
  Future<ApiResponse<List<CovidProvinceSummary>>> getProvinceSummaries() async {
    var endpoint = Uri.parse("$baseUrl/indonesia/provinsi");
    var response = await _client.get(endpoint);

    if (response.statusCode != 200 || response.body.isEmpty) {
      return ApiResponse.createErrorResponse();
    }

    var decodedJson = jsonDecode(response.body);
    var summaries = (decodedJson as List<dynamic>).map((e) => CovidProvinceSummary.fromJson(e["attributes"])).toList();
    return ApiResponse.createSuccessResponse(summaries);
  }
}
