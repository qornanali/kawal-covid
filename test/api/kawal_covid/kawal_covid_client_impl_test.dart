import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client.dart';
import 'package:kawal_covid/api/kawal_covid/kawal_corona_client_impl.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_province_summary.dart';
import 'package:kawal_covid/api/kawal_covid/model/covid_summary.dart';
import 'package:kawal_covid/core/entity/api_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures.dart';
import 'kawal_covid_client_impl_test.mocks.dart' as mockHttpClient;

@GenerateMocks([http.Client])
main() {
  group("#getIndonesiaSummary", () {
    final http.Client mockedClient = mockHttpClient.MockClient();
    final KawalCovidClient subjectClass = KawalCovidClientImpl(mockedClient);

    group("with API is returning 404 not found", () {
      test("returns error response", () async {
        var expectedResult = ApiResponse.createErrorResponse();

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia")))
            .thenAnswer((_) async => http.Response("", 404));

        var actualResult = await subjectClass.getIndonesiaSummary();

        expect(actualResult, equals(expectedResult));
      });
    });

    group("with API is returning 503 service unavailable", () {
      test("returns error response", () async {
        var expectedResult = ApiResponse.createErrorResponse();

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia")))
            .thenAnswer((_) async => http.Response("", 503));

        var actualResult = await subjectClass.getIndonesiaSummary();

        expect(actualResult, equals(expectedResult));
      });
    });

    group("with API is returning 200 ok", () {
      test("when the returned body is empty, it returns error response", () async {
        var expectedResult = ApiResponse.createErrorResponse();

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia")))
            .thenAnswer((_) async => http.Response("", 200));

        var actualResult = await subjectClass.getIndonesiaSummary();

        expect(actualResult, equals(expectedResult));
      });

      test("when the returned body has a correct format, it returns success response", () async {
        var stubbedSummary =
            CovidSummary(positiveCount: 2256851, recoveredCount: 1915147, deathCount: 60027, treatedCount: 281677);
        var expectedResult = ApiResponse.createSuccessResponse(stubbedSummary);

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia")))
            .thenAnswer((_) async => http.Response(Fixtures.getIndonesiaSummaryJson(), 200));

        var actualResult = await subjectClass.getIndonesiaSummary();

        expect(actualResult, equals(expectedResult));
      });
    });
  });

  group("#getProvinceSummaries", () {
    final http.Client mockedClient = mockHttpClient.MockClient();
    final KawalCovidClient subjectClass = KawalCovidClientImpl(mockedClient);

    group("with API is returning 404 not found", () {
      test("returns error response", () async {
        var expectedResult = ApiResponse.createErrorResponse();

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia/provinsi")))
            .thenAnswer((_) async => http.Response("", 404));

        var actualResult = await subjectClass.getProvinceSummaries();

        expect(actualResult, equals(expectedResult));
      });
    });

    group("with API is returning 503 service unavailable", () {
      test("returns error response", () async {
        var expectedResult = ApiResponse.createErrorResponse();

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/provinsi")))
            .thenAnswer((_) async => http.Response("", 503));

        var actualResult = await subjectClass.getProvinceSummaries();

        expect(actualResult, equals(expectedResult));
      });
    });

    group("with API is returning 200 ok", () {
      test("when the returned body is empty, it returns error response", () async {
        var expectedResult = ApiResponse.createErrorResponse();

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia/provinsi")))
            .thenAnswer((_) async => http.Response("", 200));

        var actualResult = await subjectClass.getProvinceSummaries();

        expect(actualResult, equals(expectedResult));
      });

      test("when the returned body has a correct format, it returns success response", () async {
        var stubbedSummaries = [
          CovidProvinceSummary(
              provinceName: "DKI Jakarta", positiveCount: 406205, recoveredCount: 393166, deathCount: 6625),
          CovidProvinceSummary(
              provinceName: "Jawa Barat", positiveCount: 277553, recoveredCount: 243650, deathCount: 3678)
        ];
        var expectedResult = ApiResponse.createSuccessResponse(stubbedSummaries);

        when(mockedClient.get(Uri.parse("https://api.kawalcorona.com/indonesia/provinsi")))
            .thenAnswer((_) async => http.Response(Fixtures.getProvinceSummariesJson(), 200));

        var actualResult = await subjectClass.getProvinceSummaries();

        expect(actualResult, equals(expectedResult));
      });
    });
  });
}
