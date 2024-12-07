import 'dart:convert';
import 'dart:io';
import 'package:fight_match_app/repositories/base_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../../models/post.dart';

class PostApi {
  Future<Either<String, Map<String, dynamic>>> createPost({
    required String token,
    required String title,
    required String privacy,
    required String description,
    required String type,
    List<File>? images,
    List<File>? videos,
  }) async {
    String url = "$baseUrl/post/create-post";

    try {
      // Create a multipart request
      var request = http.MultipartRequest("POST", Uri.parse(url));

      // Add headers
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add text fields
      request.fields['privacy'] = privacy;
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['type'] = type;

      // Helper function to add files to the request
      Future<void> addFiles(List<File>? files, String fieldName) async {
        if (files != null && files.isNotEmpty) {
          for (var file in files) {
            var stream = http.ByteStream(file.openRead());
            var length = await file.length();

            var multipartFile = http.MultipartFile(
              fieldName,
              stream.cast(),
              length,
              filename: file.path.split('/').last,
            );
            request.files.add(multipartFile);
          }
        }
      }

      // Add image files
      await addFiles(images, 'image');
      // Add video files
      await addFiles(videos, 'video');
      // Send the request
      var response = await request.send();
      // Parse the response
      if (response.statusCode == 201) {
        var responseBody = await http.Response.fromStream(response);
        var data = json.decode(responseBody.body);
        return Right(data); // Success
      } else {
        var responseBody = await http.Response.fromStream(response);
        var errorMessage = json.decode(responseBody.body)['message'];
        return Left(errorMessage); // Failure
      }
    } catch (error) {
      return Left("An unexpected error occurred: $error"); // Failure
    }
  }

  Future<Either<String, List<Post>>> getPostsByProfileId({
    required String token,
    required String userId,
  }) async {
    String url = "$baseUrl/post/user/$userId";
    try {
      // Send the GET request
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;

        // Parse the list of posts into Post objects
        List<Post> posts = data.map((e) => Post.fromJson(e)).toList();

        return Right(posts); // Return list of posts
      } else {
        var errorMessage =
            json.decode(response.body)['message'] ?? 'Error fetching posts';
        return Left(errorMessage); // Failure
      }
    } catch (error) {
      return Left("An unexpected error occurred: $error"); // Failure
    }
  }

  // Future<Either<String, List<Map<String, dynamic>>>> getPostsByProfileId({
  //   required String token,
  //   required String profileId,
  // }) async {
  //   String url = "$baseUrl/post/user/$profileId";

  //   try {
  //     // Send the GET request
  //     var response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     // Handle the response
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body) as List;

  //       return Right(data
  //           .map((e) => e as Map<String, dynamic>)
  //           .toList()); // Return posts
  //     } else {
  //       var errorMessage =
  //           json.decode(response.body)['message'] ?? 'Error fetching posts';
  //       return Left(errorMessage); // Failure
  //     }
  //   } catch (error) {
  //     return Left("An unexpected error occurred: $error"); // Failure
  //   }
  // }
}
// -----------------------------------------------------------------------------

final postApiProvider = Provider<PostApi>((ref) {
  return PostApi();
});
