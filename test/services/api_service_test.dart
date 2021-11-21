import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:superformula_qr_code/models/seed_model.dart';
import 'package:superformula_qr_code/services/api_service.dart';

import 'api_service_test.mocks.dart';

// Generate a MockClient using the Mockito package
@GenerateMocks([http.Client])
void main() {
  group('getSeed', () {
    test('returns a SeedModel if the http call completes successfully',
        () async {
      final client = MockClient();
      // return a successful response when we call the provided http.Client
      when(client.get(Uri.parse('http://192.168.1.242:8080/seed'))).thenAnswer(
          (_) async => http.Response('{"description": "seed generated"}', 200));

      expect(await ApiService().getSeed(client), isA<SeedModel>());
    });

    test('throw an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      // return unsuccessful response when we call the provided http.Client
      when(client.get(Uri.parse('http://192.168.1.242:8080/seed')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService().getSeed(client), throwsException);
    });
  });
}
