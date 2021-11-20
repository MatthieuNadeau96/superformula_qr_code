import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

main() {
  test("getSeed should return 200", () async {
    // Arrange
    var expected = 200;
    // Act
    final response =
        await http.get(Uri.parse('http://192.168.1.242:8080/seed'));
    var matcher = response.statusCode;
    // Assert
    expect(expected, matcher);
  });
}
