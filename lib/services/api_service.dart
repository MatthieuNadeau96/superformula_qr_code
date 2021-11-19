import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:superformula_qr_code/models/seed_model.dart';

class ApiService {
  Future<SeedModel> getSeed() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.242:8080/seed'),
    );

    if (response.statusCode == 200) {
      return SeedModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Faled to create seed');
    }
  }
}
