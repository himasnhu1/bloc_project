import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc_project/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../exceptions/app_exceptions.dart';

class NetworkApiServiceHttp implements BaseApiServices {
  
  /// For GET APIs
  @override
  Future getApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));

      jsonResponse = returnResponse(response);
    } catch (e) {
      handleHttpError(
          e is HttpException ? e : Exception(e), jsonResponse.statusCode);
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> postApiResponse(String url, var data) async {
    dynamic jsonResponse;
  if (kDebugMode) {
        print("url==>$url");
        print("data==>$data");
      }
    try {
      final response = await http
          .post(Uri.parse(url), body: data,headers:{'Content-Type': 'application/json', 'x-api-key:' : 'reqres-free-v1'} )
          .timeout(const Duration(seconds: 30));
      if (kDebugMode) {
        print("bodyPP==>${response.body}");
      }
      if (kDebugMode) {
        print("bodyPP==>$jsonResponse");
      }
      jsonResponse = returnResponse(response);
    } catch (e) {
      handleHttpError(
          e is HttpException ? e : Exception(e), jsonResponse.statusCode);
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> postMultipartApiResponse(String url, Map<String, dynamic> data) {
    // TODO: implement postMultipartApiResponse
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getWithParams(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {}

  void handleHttpError(Exception e, [int? statusCode]) {
    if (e is TimeoutException) {
      throw FetchDataException(message: "Request timed out");
    } else if (e is SocketException) {
      throw FetchDataException(message: "No Internet Connection");
    } else if (e is HttpException) {
      // Handle manually passed status code from HTTP response
      switch (statusCode) {
        case 400:
          throw FetchDataException(message: "Bad request (400)");
        case 401:
          throw FetchDataException(message: "Unauthorized (401)");
        case 404:
          throw FetchDataException(message: "Not found (404)");
        case 500:
        case 502:
        case 503:
          throw FetchDataException(message: "Server error ($statusCode)");
        default:
          throw FetchDataException(
              message: "Unexpected HTTP error ($statusCode)");
      }
    } else {
      throw FetchDataException(message: "Unexpected error: $e");
    }
  }

  dynamic returnResponse(http.Response response) {
    // if (kDebugMode) {
    //   print("body==>${response.body}");
    // }
    // if (kDebugMode) {
    //   print("statusCode==>${response.statusCode}");
    // }
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 201:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      default:
        throw FetchDataException(
            message: "Unexpected HTTP error (${response.statusCode})");
    }
  }
}
