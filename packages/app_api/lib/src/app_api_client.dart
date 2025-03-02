import 'dart:convert';
import 'dart:io';

import 'package:app_api/app_api.dart';
import 'package:http/http.dart' as http;

/// Available api paths for fetching data.
const List<String> availablePaths = [
  'sapk01222019186652.json',
  'nzin01312019187360.json',
];

/// {@template app_api_request_failure}
/// Exception thrown when an error occurs while fetching data.
/// {@endtemplate}
class AppApiRequestFailure implements Exception {
  /// {@macro app_api_request_failure}
  AppApiRequestFailure(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'AppApiRequestFailure: $message';
}

extension on http.Response {
  /// Converts the response body to a json object.
  Map<String, dynamic> get json => jsonDecode(body) as Map<String, dynamic>;
}

/// {@template app_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AppApiClient {
  /// {@macro app_api}
  AppApiClient({
    http.Client? client,
  }) : _client = client ?? http.Client();

  final http.Client _client;

  /// Fetches data from the api endpoint.
  Future<ResponseModel> getData({
    required String path,
  }) async {
    final url = Uri.https(
      'demo.sportz.io',
      path,
    );

    final response = await _client.get(
      url,
      headers: _getHeaders(),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw AppApiRequestFailure('Success');
    }

    final json = response.json;

    return ResponseModel.fromJson(json);
  }

  /// Closes the client
  void close() {
    _client.close();
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }
}
