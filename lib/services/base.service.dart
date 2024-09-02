import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DioMethod { post, get, put, delete }

class APIService {

  APIService._singleton();

  static final APIService instance = APIService._singleton();

  String get baseUrl {
    return 'https://parkingold.test';
  }

  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  Future<Response> request(
      String endpoint,
      DioMethod method, {
        Map<String, dynamic>? param,
        String? contentType,
        formData,
        requireToken,
      }) async {
    try {
      Map<String, dynamic> headers = {};

      if (requireToken == true) {
        String? token = await asyncPrefs.getString('login_token');
        headers = {
          HttpHeaders.authorizationHeader: 'Basic $token',
        };
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: contentType ?? Headers.formUrlEncodedContentType,
          headers: headers,
        ),
      );
      switch (method) {
        case DioMethod.post:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.get:
          return dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.put:
          return dio.put(
            endpoint,
            data: param ?? formData,
          );
        case DioMethod.delete:
          return dio.delete(
            endpoint,
            data: param ?? formData,
          );
        default:
          return dio.post(
            endpoint,
            data: param ?? formData,
          );
      }
    } catch (e) {
      throw Exception('Network error');
    }
  }
}