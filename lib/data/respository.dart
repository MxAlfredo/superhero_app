import 'dart:convert';

import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<SuperheroResponse?> fetchSuperhero(String name) async {
    final response = await http.get(
      Uri.parse(
        'https://superheroapi.com/api/eefa0d17a716764e5d017a906729f47f/search/$name',
      ),
    );

    if (response.statusCode == 200) {
      return SuperheroResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
