import 'dart:convert';

import 'package:http/http.dart';
import '../model/login_response.dart';
import 'api/api_path.dart';

class AuthenticationService {

  //Get all authentication
  Future<LoginResponse> authenticationLogin({
    required String username,
    required String password,
  }) async {
    final response = await post(
      Uri.parse(ApiPath.loginPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    ).catchError((onError) {
      throw Exception('Failed to create User.');
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create User.');
    }
  }
}
