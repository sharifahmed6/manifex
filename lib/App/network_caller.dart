import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String,dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;
  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
     this.responseData,
    this.errorMessage = "Something went wrong",
});
}
class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? extraHeaders,
    bool removeAuthorization = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(
          queryParameters:
          queryParams.map((k, v) => MapEntry(k, v.toString())),
        );
      }

      final headers = <String, String>{
        'content-type': 'application/json',
         'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4OGJmZTRmLWYwNjMtNGQyYy04NGY0LTIzM2RkNmNkOTlhYyIsImZpcnN0TmFtZSI6IlNoYXJpZiIsImxhc3ROYW1lIjoiQWhtZWQiLCJlbWFpbCI6InNoYXJpZmFobWVkMTQxM0BnbWFpbC5jb20iLCJwcm9maWxlUGljIjoiL2F2YXRhci0wMS5wbmciLCJyb2xlIjoiVVNFUiIsImlzVmVyaWZpZWQiOnRydWUsImlzU3Vic2NyaWJlZCI6dHJ1ZSwiaXNTdWJzY3JpcHRpb25GcmVlIjpmYWxzZSwibGFuZ3VhZ2UiOiJFbmdsaXNoIiwidXNlclR5cGUiOiJzdHVkZW50IiwiaWF0IjoxNzcwMjgwODE3LCJleHAiOjE3NzIwMDg4MTd9.gWHnZ8MLOXigDbsHNrh-vKhMq5SFkncrB_fh2SS8oEM'
      };
      if (removeAuthorization) {
        headers.removeWhere((k, _) => k.toLowerCase() == 'authorization');
      }

      if (extraHeaders != null && extraHeaders.isNotEmpty) {
        headers.addAll(extraHeaders); // same key হলে override হবে
      }
      _logRequest(uri.toString(), headers);

      final Response response = await get(uri, headers: headers);

      _logResponse(uri.toString(), response);

      dynamic decodedBody;

      if (response.body.isNotEmpty) {
        try {
          decodedBody = jsonDecode(response.body);
        } catch (e) {
          print("Decode Error: $e");
          decodedBody = null;
        }
      }


      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      }

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: _extractErrorMessage(
          decodedBody,
          response.statusCode,
        ),
      );
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: 'No internet connection or server unreachable',
      );
    }
  }
  Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? extraHeaders,
    bool removeAuthorization = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      final headers = <String, String>{
        'content-type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4OGJmZTRmLWYwNjMtNGQyYy04NGY0LTIzM2RkNmNkOTlhYyIsImZpcnN0TmFtZSI6IlNoYXJpZiIsImxhc3ROYW1lIjoiQWhtZWQiLCJlbWFpbCI6InNoYXJpZmFobWVkMTQxM0BnbWFpbC5jb20iLCJwcm9maWxlUGljIjoiL2F2YXRhci0wMS5wbmciLCJyb2xlIjoiVVNFUiIsImlzVmVyaWZpZWQiOnRydWUsImlzU3Vic2NyaWJlZCI6dHJ1ZSwiaXNTdWJzY3JpcHRpb25GcmVlIjpmYWxzZSwibGFuZ3VhZ2UiOiJFbmdsaXNoIiwidXNlclR5cGUiOiJzdHVkZW50IiwiaWF0IjoxNzcwMjgwODE3LCJleHAiOjE3NzIwMDg4MTd9.gWHnZ8MLOXigDbsHNrh-vKhMq5SFkncrB_fh2SS8oEM'
      };
      if (removeAuthorization) {
        headers.removeWhere((k, _) => k.toLowerCase() == 'authorization');
      }

      if (extraHeaders != null && extraHeaders.isNotEmpty) {
        headers.addAll(extraHeaders);
      }
      _logRequest(
        url,
        headers,
        requestBody: body,
      );

      Response response =
      await post(uri, headers: headers, body: jsonEncode(body));

      _logResponse(url, response);

      Map<String, dynamic>? decodedBody;
      if (response.body.isNotEmpty) {
        try {
          decodedBody = jsonDecode(response.body);
        } catch (_) {
          decodedBody = null;
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      }

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: _extractErrorMessage(
          decodedBody,
          response.statusCode,
        ),
      );
    } catch (e) {
      print("Error: $e");
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: 'No internet connection or server unreachable',
      );
    }
  }
  Future<NetworkResponse> patchRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer token'
      };

      _logRequest(
        url,
        headers,
        requestBody: body,
      );

      Response response =
      await patch(uri, headers: headers, body: jsonEncode(body));

      _logResponse(url, response);

      Map<String, dynamic>? decodedBody;
      if (response.body.isNotEmpty) {
        try {
          decodedBody = jsonDecode(response.body);
        } catch (_) {
          decodedBody = null;
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      }

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: _extractErrorMessage(
          decodedBody,
          response.statusCode,
        ),
      );
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: 'No internet connection or server unreachable',
      );
    }
  }
  Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer token'
      };

      _logRequest(
        url,
        headers,
        requestBody: body,
      );

      Response response = await delete(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logResponse(url, response);

      Map<String, dynamic>? decodedBody;
      if (response.body.isNotEmpty) {
        try {
          decodedBody = jsonDecode(response.body);
        } catch (_) {
          decodedBody = null;
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedBody,
        );
      }

      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: _extractErrorMessage(
          decodedBody,
          response.statusCode,
        ),
      );
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: 'No internet connection or server unreachable',
      );
    }
  }

  String _extractErrorMessage(
      Map<String, dynamic>? body,
      int statusCode,
      ) {
    if (body != null) {
      return body['message'] ??
          body['error'] ??
          body['detail'] ??
          _defaultErrorByStatus(statusCode);
    }
    return _defaultErrorByStatus(statusCode);
  }

  String _defaultErrorByStatus(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized access';
      case 403:
        return 'Permission denied';
      case 404:
        return 'Data not found';
      case 500:
        return 'Server error, please try again';
      default:
        return 'Something went wrong';
    }
  }

  void _logRequest(
      String url,
      Map<String, dynamic>? headers, {
        Map<String, dynamic>? requestBody,
      }) {
    _logger.i(
      'URL => $url\nHeaders => $headers\nRequest Body => $requestBody',
    );
  }

  void _logResponse(String url, Response response) {
    _logger.i(
      'URL => $url\n'
          'Status Code => ${response.statusCode}\n'
          'Headers => ${response.headers}\n'
          'Body => ${response.body}',
    );
  }

  /*Future<void> updateProfileInfo() async {
  try {
    isLoading.value = true;

    final token = await SharedPreferencesHelper.getAccessToken() ?? '';

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };

    final Map<String, dynamic> data = {
      if (fullNameController.text.isNotEmpty)
        "name": fullNameController.text,
      if (emailController.text.isNotEmpty)
        "email": emailController.text,
      if (selectedDate.value.isNotEmpty)
        "dateOfBirth": selectedDate.value,
      if (gender.value.isNotEmpty)
        "gender": gender.value,
      if (countryList.value.isNotEmpty)
        "country": countryList.value,
      if (languageController.text.isNotEmpty)
        "language": languageController.text,
      if (skills.isNotEmpty)
        "skills": skills.toList(),
      if (aboutController.text.isNotEmpty)
        "about": aboutController.text,
    };

    FormData formData = FormData.fromMap(data);

    if (selectedImage.value != null) {
      final file = selectedImage.value!;
      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
      final typeSplit = mimeType.split('/');

      formData.files.add(
        MapEntry(
          'profileImage',
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: MediaType(typeSplit[0], typeSplit[1]),
          ),
        ),
      );
    }

    final response =
        await dio.patch(Urls.userUpdateProfile, data: formData);

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      Get.snackbar(
        "Success",
        "Profile updated successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed(Routes.PROFILE);
    } else {
      Get.snackbar(
        "Error",
        "Profile update failed",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } on DioException catch (e) {
    final errorMsg = e.response?.data is Map
        ? e.response?.data['message'] ?? 'Profile update failed'
        : e.message ?? 'Something went wrong';

    Get.snackbar(
      "Error",
      errorMsg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isLoading.value = false;
  }
}
*/
}
