import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/api/api_service.dart';

void main() {
  group('Massa API', () {
    test("Get status", () async {
      final api = ApiService();
      var resp = await api.getStatus();
      print("status response: $resp");
    });
  });
}
