import 'dart:io';

import 'package:dio/dio.dart';

class DioClient {
  final String baseUrl;

  Dio? dio;

  DioClient(this.baseUrl,
      Dio dioC) {
    dio = dioC;
    dio!
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
    //dio!.interceptors.add(loggingInterceptor);
  }

  Future<Response> get(String uri, {
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      var response = await dio!.get(
        baseUrl + uri,
        queryParameters: queryParameters,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

}