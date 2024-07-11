import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkUtils {
  static final NetworkUtils _instance = NetworkUtils._internal();
  late Dio _dio;
  
  bool fetchingData = false;

  factory NetworkUtils() {
    return _instance;
  }

  NetworkUtils._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.npoint.io',
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        return handler.next(error); 
      },
    ));
  }

  Future<Response> get(String url, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(
        url,
        options: Options(headers: headers),
        queryParameters: queryParams,
      );
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load data');
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? headers, Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to post data');
    }
  }
}
