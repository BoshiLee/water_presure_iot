import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:water_pressure_iot/config.dart';
import 'package:water_pressure_iot/repository/user_repository.dart';

import 'api/api_response.dart';
import 'api/app_exception.dart';
import 'flavor.dart';

class ApiBaseHelper {
  get baseUrl {
    switch (Config.appFlavor) {
      case Flavor.LOCALHOST:
        return Uri.http(
          Config.host,
        ).toString();
      default:
        return Uri.https(
          Config.host,
        ).toString();
    }
  }

  Dio get _dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        baseUrl: baseUrl,
      ),
    )..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 130,
          // logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    // ..httpClientAdapter = client;

    return dio;
  }

  Map<String, dynamic> get _headers {
    Map<String, dynamic> map = {
      HttpHeaders.acceptHeader: ContentType.json.toString(),
      HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    };
    if (UserRepository.shared.jwt.isNotEmpty) {
      final String authToken = UserRepository.shared.jwt;
      map[HttpHeaders.authorizationHeader] = 'Bearer $authToken';
      // debugPrint('authorization: ${map[HttpHeaders.authorizationHeader]}');
    }
    return map;
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters = const {},
    ResponseType responseType = ResponseType.json,
  }) async {
    final Options requestOptions = Options(headers: _headers);
    requestOptions.responseType = responseType;
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: requestOptions,
      );
      return _returnResponse(response);
    } on SocketException {
      throw NetworkConnectException(
        'No Internet connection',
        retryHandler: () => get(
          url,
          queryParameters: queryParameters,
          responseType: responseType,
        ),
      );
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? contentType,
  }) async {
    Map<String, dynamic> headers = _headers;
    if (data == null) {
      headers[HttpHeaders.contentTypeHeader] = ContentType.text.toString();
    }
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      return _returnResponse(response);
    } on SocketException {
      throw NetworkConnectException(
        'No Internet connection',
        retryHandler: () => post(
          url,
          queryParameters: queryParameters,
          data: data,
          contentType: contentType,
        ),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler(
        e,
        () => post(
          url,
          queryParameters: queryParameters,
          data: data,
          contentType: contentType,
        ),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> put(
    String url, {
    Map<String, String>? queryParameters,
    dynamic data,
    dynamic contentType,
  }) async {
    Map<String, dynamic> headers = _headers;
    if (data == null) {
      headers[HttpHeaders.contentTypeHeader] = ContentType.text.toString();
    }
    try {
      final Response response = await _dio.put(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      return _returnResponse(response);
    } on SocketException {
      throw NetworkConnectException(
        'No Internet connection',
        retryHandler: () => put(
          url,
          queryParameters: queryParameters,
          data: data,
          contentType: contentType,
        ),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler(
        e,
        () => put(
          url,
          queryParameters: queryParameters,
          data: data,
          contentType: contentType,
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? contentType,
  }) async {
    Map<String, dynamic> headers = _headers;
    if (data == null) {
      headers[HttpHeaders.contentTypeHeader] = ContentType.text.toString();
    }
    try {
      final Response response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      return _returnResponse(response);
    } on SocketException {
      throw NetworkConnectException(
        'No Internet connection',
        retryHandler: () => delete(
          url,
          queryParameters: queryParameters,
          data: data,
          contentType: contentType,
        ),
      );
    } on DioException catch (e) {
      throw DioExceptionHandler(
        e,
        () => delete(
          url,
          queryParameters: queryParameters,
          data: data,
          contentType: contentType,
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  AppException DioExceptionHandler(DioException e, RetryHandler? retryHandler) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return RequestTimeOutException('請求逾時，請至網路穩定的環境中使用',
            retryHandler: retryHandler);
      case DioExceptionType.receiveTimeout:
        return RequestTimeOutException('請求逾時，請至網路穩定的環境中使用',
            retryHandler: retryHandler);
      case DioExceptionType.sendTimeout:
        return RequestTimeOutException('請求逾時，請至網路穩定的環境中使用',
            retryHandler: retryHandler);
      case DioExceptionType.cancel:
        return NetworkConnectException('請求取消', retryHandler: retryHandler);
      case DioExceptionType.badResponse:
        final response = e.response;
        if (response == null) {
          return BadRequestException(
            e.error.toString(),
            response: ApiResponse(message: e.error.toString()),
            retryHandler: retryHandler,
          );
        }
        final errorMessage = response.data != null
            ? ApiResponse.fromJson(response.data).message
            : 'Error occurred while Communication with Server with StatusCode'
                ' : ${response.statusCode}';
        switch (response.statusCode) {
          case 400:
            if (errorMessage == 'token_invalid') {
              return TokenExpiredException(
                errorMessage,
                response: ApiResponse(
                  statusCode: response.statusCode,
                  message: errorMessage,
                ),
              );
            }
            return BadRequestException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
              retryHandler: retryHandler,
            );
          case 401:
            return TokenExpiredException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
            );
          case 403:
            return UnauthorisedException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
            );
          case 404:
            return PageNotFountException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
            );
          case 405:
            return MethodNotAllowedException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
            );
          case 422:
            return BadRequestException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
              retryHandler: retryHandler,
            );
          case 429:
            return TooManyRequest(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
            );
          case 500:
            return InternalServerException(
              'Whoops, looks like something went wrong',
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
              retryHandler: retryHandler,
            );
          case 503:
            return ServiceUnavailableException(
              '系統維護中',
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
            );
          case 550:
            return RequestNotTakenException(
              errorMessage,
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
              retryHandler: retryHandler,
            );
          default:
            return NetworkConnectException(
              'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
              response: ApiResponse(
                statusCode: response.statusCode,
                message: errorMessage,
              ),
              retryHandler: retryHandler,
            );
        }
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return NetworkConnectException(
            'No Internet connection',
            retryHandler: retryHandler,
          );
        }
        if (e.response == null) {
          return BadRequestException(
            e.error.toString(),
            response: ApiResponse(
              message: e.error.toString(),
            ),
            retryHandler: retryHandler,
          );
        }
        return NetworkConnectException(
          '網路請求異常, ${e.message}',
          response: ApiResponse(
            statusCode: e.response!.statusCode,
            message: e.error.toString(),
          ),
          retryHandler: retryHandler,
        );
      default:
        if (e.response == null) {
          return BadRequestException(
            e.error.toString(),
            response: ApiResponse(
              message: e.error.toString(),
            ),
            retryHandler: retryHandler,
          );
        }
        return NetworkConnectException(
          'Error occurred while Communication with Server with StatusCode : ${e.response!.statusCode}',
          response: ApiResponse.fromJson(e.response!.data),
          retryHandler: retryHandler,
        );
    }
  }

  dynamic _returnResponse(Response response) {
    final dynamic responseJson = response.data;
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final ApiResponse apiResponse = ApiResponse.fromJson(responseJson);
      if (apiResponse.statusCode != null) {
        throw UnHandleBusinessLogic(apiResponse.message, response: apiResponse);
      }
    }
    return responseJson;
  }
}
