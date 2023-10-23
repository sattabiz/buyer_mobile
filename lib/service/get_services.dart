import 'dart:convert';
import 'package:dio/dio.dart';
import '../storage/jwt_storage.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> get({required String url}) async {
    try {
      final _jwt = await jwtStorageService().getJwtData();
      var response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );
      Map<String, dynamic> responseData = json.decode(response.toString());
      int status = responseData['status'];      
      if (status != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return response;
    } catch (e) {
      throw e;
    }
  }
}
