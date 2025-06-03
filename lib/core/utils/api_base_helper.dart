import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mohammed_ashraf/core/errors/exception.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum DataFormat { formData, rawData }

class ApiBaseHelper {
  final Dio dio;

  ApiBaseHelper({required this.dio}) {
    dioInit();
  }

  // ================== Initialize DIO ======================
  void dioInit() {
    dio.options.baseUrl = "localhost:4000";
    dio.options.sendTimeout = const Duration(milliseconds: 30000);
    dio.options.connectTimeout = const Duration(milliseconds: 30000);
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    dio.interceptors.clear();
    dio.interceptors.addAll(
      [
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: true,
          request: true,
        ),
      ],
    );
  }

  // ================== GET Method ======================
  Future<dynamic> get({
    required String url,
    String? token,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        data: body,
        queryParameters: queryParameters,
      );
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: "No internet connection. Please try again.");
    } on DioException catch (e) {
      log(e.toString());

      String message = e.response?.data['message'] ?? "No Internet Connection";
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        message = "Please check your internet connection.";
      }
      throw ServerException(message: message);
    }
  }

  // ================== POST Method ======================
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
    DataFormat dataFormat = DataFormat.formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response;
      final dynamic responseJson;
      dynamic formattedBody;
      if (dataFormat == DataFormat.formData) {
        formattedBody = FormData.fromMap(body);
      } else {
        formattedBody = body;
      }
      response = await dio.post(
        url,
        data: formattedBody,
        queryParameters: queryParameters,
      );
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: "Please check your internet connection.");
    } on DioException catch (e) {
      log('DioException ----->$e');
      log('DioException ----->${e.response?.data}');
      return _returnResponse(e.response);
    }
  }

  // ================== PUT Method =========================
  Future<dynamic> put({
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Response response;
      if (body != null) {
        response = await dio.put(url, data: body);
      } else {
        response = await dio.put(url);
      }
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: "Please check your internet connection.");
    } on DioException catch (e) {
      log(e.toString());
      log(e.response?.toString() ?? 'No response');
      String message =
          e.response?.data['message'] ?? "Please try again.";
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        message = "No internet connection.";
      }
      throw ServerException(message: message);
    }
  }

  // ================== DELETE Method ======================
  Future<dynamic> delete({required String url, String? token}) async {
    try {
      final Response response = await dio.delete(url);
      final responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw ServerException(message: "Please check your internet connection.");
    } on DioException catch (e) {
      log(e.toString());
      String message =
          e.response?.data['message'] ?? "Please try again.";
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        message = "No internet connection.";
      }
      throw ServerException(message: message);
    }
  }

  // ================== Response Handling ======================
  dynamic _returnResponse(Response? response) {
    if (response == null) {
      throw ServerException(message: "Please check your internet connection.");
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
      case 422:
        throw ServerException(
          message: response.data['message'],
          errorMap: response.data['errors'],
        );
      case 401:
        throw ServerException(message: response.data['message'] ?? "Error");
      case 403:
        throw ServerException(message: response.data);
      case 500:
      default:
        throw ServerException(message: "Please check your internet connection.");
    }
  }
}

// ================== Exception Handling ======================
String handleException(Exception error) {
  if (error.toString().contains('SocketException')) {
    return 'Please check your internet connection and try again.';
  } else if (error.runtimeType == DioException) {
    DioException dioError = error as DioException;
    switch (dioError.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out, please check your internet speed and try again.';
      case DioExceptionType.badResponse:
        return dioError.response?.data['message'] ??
            'There was an error responding, please try again later.';
      case DioExceptionType.cancel:
        return 'The order has been cancelled, please try again.';
      case DioExceptionType.unknown:
      default:
        return 'Something went wrong, please try again later.';
    }
  } else {
    return 'Something went wrong, please try again later.';
  }
}

