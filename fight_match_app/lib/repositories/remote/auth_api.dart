import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import 'package:fight_match_app/repositories/base_url.dart';

class ApiResponse {
  final String message;
  final Map<String, dynamic>? data;
  final String? jwt;
  final String? rwt;
  ApiResponse({required this.message, this.data, this.jwt, this.rwt});

  @override
  String toString() {
    return 'ApiResponse(message: $message, data: $data,  jwt: $jwt, rwt: $rwt)';
  }
}

class AuthApi {
  Future<Either<String, ApiResponse>> createUser({
    required String userName,
    required String email,
    required String password,
    required String fullName,
    required String dob,
    required String profession,
    required String gender,
    required String country,
    required String state,
    required String city,
    required File avatar,
    File? cover,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/user/create-user');

      final request = http.MultipartRequest('POST', uri);

      // Add form fields
      request.fields['userName'] = userName;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['fullName'] = fullName;
      request.fields['dob'] = dob;
      request.fields['profession'] = profession;
      request.fields['gender'] = gender;
      request.fields['country'] = country;
      request.fields['state'] = state;
      request.fields['city'] = city;

      // Add avatar file
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar.path));

      // Add cover file if provided
      if (cover != null) {
        request.files
            .add(await http.MultipartFile.fromPath('cover', cover.path));
      }

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final decodedResponse = jsonDecode(responseBody);
        return Right(ApiResponse(
          message: decodedResponse['message'],
          data: decodedResponse['user'],
        ));
      } else {
        final decodedResponse = jsonDecode(responseBody);
        return Left(decodedResponse['message'] ?? 'Error occurred.');
      }
    } catch (error) {
      if (error is SocketException) {
        return const Left("No internet connection.");
      } else if (error is TimeoutException) {
        return const Left("Request timed out.");
      } else {
        return Left(error.toString());
      }
    }
  }

  Future<Either<String, ApiResponse>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/user/login');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return Right(ApiResponse(
          message: decodedResponse['message'],
          data: decodedResponse['user'],
          // profile: decodedResponse['profile'],
          jwt: decodedResponse['jwt'],
          rwt: decodedResponse['rwt'],
        ));
      } else {
        final decodedResponse = jsonDecode(response.body);
        return Left(decodedResponse['message'] ?? 'Error occurred.');
      }
    } catch (error) {
      if (error is SocketException) {
        return const Left("No internet connection.");
      } else if (error is TimeoutException) {
        return const Left("Request timed out.");
      } else {
        return Left(error.toString());
      }
    }
  }
}
// -----------------------------------------------------------------------------

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});
