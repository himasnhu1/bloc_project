import 'dart:async';
import 'dart:convert';
import 'package:bloc_project/data/network/base_api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../exceptions/app_exceptions.dart';

class NetworkApiService extends BaseApiServices {
  Dio dio = Dio();
  // "Content-Type": "application/json",
  NetworkApiService()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 100),
            receiveTimeout: const Duration(seconds: 100),
            headers: {
              'Content-Type': 'application/json',
              'x-api-key': 'reqres-free-v1'
            },
          ),
        ) {
    // Add Interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // var userdata = GetStorage();
          // Modify or log requests here
          // debugPrint("Request: ${options.method} ${options.uri}");
          // 1. Modify the request to add the Authorization header (JWT)
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // String? accessToken = prefs.getString("accessToken");
          // String? accessToken =
          //     SharedPrefHelper.instance.getString('accessToken');
          // debugPrint("AccessToken in Interceptor: $accessToken");
          // print('Request: ${options.method} ${options.uri}');
          // if (accessToken != null && accessToken.isNotEmpty) {

          // options.headers['x-api-key'] = 'reqres-free-v1';

          // print("Bearer    ${userdata.read("_Token")}");
          // } else {
          //   debugPrint("AccessToken is null or empty!");
          // }
          handler.next(options); // Proceed with the request
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Log or modify the response
          debugPrint("Response: ${response.statusCode}");
          handler.next(response); // Proceed with the response
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // Handle errors globally
          // debugPrint("Error occurred: ${e.message}");
          if (e.response?.statusCode == 401) {
            _showAuthorizationErrorDialog();
          } else {
            return handler
                .reject(e); // Token refresh failed, reject the request
          }

          handleDioError(e); // Call your centralized error handling logic

          handler.next(e); // Pass the error to be handled downstream
        },
      ),
    );
  }

  // Keep a reference to the cancel token
  CancelToken? cancelToken;

  // For POST APIs
  @override
  Future<dynamic> postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    cancelToken = CancelToken();
    try {
      debugPrint("Request URL: $url");
      debugPrint("Request Headers: ${dio.options.headers}");
      debugPrint("Request Payload:-- ${data.toString()}");

      Response response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      debugPrint("response:$response");

      responseJson = returnResponse(response);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint("Request canceled: ${e.message}");
      } else {
        handleDioError(e);
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> postMultipartApiResponse(
      String url, Map<String, dynamic> data) async {
    dynamic responseJson;
    cancelToken = CancelToken();
    try {
      debugPrint("Request URL: $url");
      debugPrint("Request Headers: ${dio.options.headers}");
      debugPrint("Request Payload: ${data.toString()}");

      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        url,
        data: formData,
        // options: Options(
        //   contentType: "multipart/form-data",
        // ),
        cancelToken: cancelToken,
      );

      responseJson = returnResponse(response);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint("Request canceled: ${e.message}");
      } else {
        handleDioError(e);
      }
    }
    return responseJson;
  }

  // Cancel the request
  void cancelRequest() {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("Request canceled by user");
    }
  }

  // For GET APIs
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      Response response = await dio.get(url);
      // debugPrint(response.toString());
      responseJson = returnResponse(response);
    } on DioException catch (e) {
      handleDioError(e);
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data; // Dio automatically decodes JSON
    }
  }

  void handleDioError(DioException e) {
    if (e.response != null) {
      debugPrint("StatusCode:${e.response!.statusCode.toString()}");
      // Parse the error response
      // Handle HTTP status codes centrally
      switch (e.response!.statusCode) {
        case 400:
          throw FetchDataException(message: "Bad request (400)");
        case 401:
          throw FetchDataException(message: "Unauthorized (401)");
        case 404:
          throw FetchDataException(message: "Unauthorized (404)");
        case 500:
        case 502:
        case 503:
          throw FetchDataException(
              message: "Server error (${e.response!.statusCode})");
        default:
          throw FetchDataException(message: "F");
        // "Unexpected error: ${e.response!.statusCode}, ${e.response!.data}");
      }
    }

    // Handle non-response errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw FetchDataException(message: "Request timed out");
    } else if (e.type == DioExceptionType.badCertificate) {
      throw FetchDataException(message: "Invalid SSL Certificate");
    } else if (e.type == DioExceptionType.connectionError) {
      throw FetchDataException(message: "No Internet Connection");
    } else if (e.type == DioExceptionType.unknown) {
      print(e.message);
      // Likely a malformed URL or DNS issue
      throw FetchDataException(
          message: "Unknown error - Possible invalid URL or server issue");
    } else if (CancelToken.isCancel(e)) {
      // debugPrint("Request canceled: ${e.message}");
    } else {
      // throw FetchDataException(message: "Unexpected error: ${e.message}");
      throw FetchDataException(message: "Unexpected error:");
    }
  }

  void _showAuthorizationErrorDialog() async {
    // Retrieve SharedPreferences and clear them before using the context.
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();

    // SharedPrefHelper.instance.clearAllData();

    // final BuildContext context = navigatorKey.currentContext!;
    // Access the context safely via the navigatorKey.
    // final navigatorState = navigatorKey.currentState;
    // if (navigatorState != null && navigatorState.mounted) {
    //   showDialog(
    //     context: navigatorState.context,
    //     builder: (BuildContext dialogContext) {
    //       return AlertDialog(
    //         title: const Text('Session Expired'),
    //         content:
    //             const Text('Your session has expired. Please log in again.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(dialogContext).pop(); // Close the dialog
    //               navigatorState.context
    //                   .go('/login'); //; // Navigate to the login page
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  @override
  Future<dynamic> getWithParams(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioError(e);
    }
  }
}
