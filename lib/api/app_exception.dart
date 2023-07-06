import 'package:equatable/equatable.dart';
import 'package:water_pressure_iot/api/api_response.dart';

typedef RetryHandler = Future<dynamic> Function();

abstract class AppException extends Equatable implements Exception {
  final String? message;
  final String prefix;
  final ApiResponse? response;
  final RetryHandler? retryHandler;

  AppException(
    this.message,
    this.prefix,
    this.response, {
    this.retryHandler,
  });

  String toString() {
    return "$prefix${message != null ? message : '發生未預期的錯誤，請稍後重試'}";
  }

  String get errorMessage {
    if (this.message != null) return this.toString();
    if (this.response == null && this.message == null)
      return prefix + '發生未預期的錯誤，請稍後重試';
    final message = this.response!.message;
    return message ?? prefix + '發生未預期的錯誤，請稍後重試';
  }

  @override
  List<Object> get props => [];
}

class UnHandleBusinessLogic extends AppException {
  UnHandleBusinessLogic(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          'UnHandle Business Logic: ',
          response,
        );
}

class IAPPlatformException extends AppException {
  IAPPlatformException(String? message)
      : super(
          message,
          'PlatformException: ',
          ApiResponse(message: message),
        );
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException(
    String? message, {
    required RetryHandler? retryHandler,
  }) : super(
          message,
          'Request Time Out: ',
          null,
          retryHandler: retryHandler,
        );
}

class NetworkConnectException extends AppException {
  NetworkConnectException(
    String? message, {
    ApiResponse? response,
    RetryHandler? retryHandler,
  }) : super(
          message,
          "Error During Communication: ",
          response,
          retryHandler: retryHandler,
        );
}

class RequestNotTakenException extends AppException {
  RequestNotTakenException(
    String? message, {
    ApiResponse? response,
    RetryHandler? retryHandler,
  }) : super(
          message,
          "Invalid Request: ",
          response,
          retryHandler: retryHandler,
        );
}

class BadRequestException extends AppException {
  BadRequestException(
    String? message, {
    ApiResponse? response,
    RetryHandler? retryHandler,
  }) : super(
          message,
          "Invalid Request: ",
          response,
          retryHandler: retryHandler,
        );
}

class ValidateException extends AppException {
  ValidateException(String message)
      : super(
          message,
          "Validate Failed: ",
          null,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          "Unauthorised: ",
          response,
        );
}

class TooManyRequest extends AppException {
  TooManyRequest(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          "Too Many Requests: ",
          response,
        );
}

class MethodNotAllowedException extends AppException {
  MethodNotAllowedException(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          "Method Not Allowed: ",
          response,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(
    String? message,
  ) : super(
          message,
          "Invalid Input: ",
          null,
        );
}

class PageNotFountException extends AppException {
  PageNotFountException(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          "Page Not Found: ",
          response,
        );
}

class TokenExpiredException extends AppException {
  TokenExpiredException(String? message, {ApiResponse? response})
      : super(
          message,
          "Token Expired: ",
          response,
        );
}

class InAppPurchaseException extends AppException {
  InAppPurchaseException(
    String? message, {
    ApiResponse? response,
  }) : super(message, "In-App Purchase Error: ", response);
}

class RemoteNotifyError extends AppException {
  RemoteNotifyError(String? message, {ApiResponse? response})
      : super(
          message,
          "Remote notify Unavailable: ",
          response,
        );
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          "Service Unavailable: ",
          response,
        );
}

class InternalServerException extends AppException {
  InternalServerException(
    String? message, {
    ApiResponse? response,
    required RetryHandler? retryHandler,
  }) : super(
          message,
          "Internal Server Error: ",
          response,
          retryHandler: retryHandler,
        );
}

class GeoLocationPermissionNotAllowed extends AppException {
  GeoLocationPermissionNotAllowed(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          'Geo Location Permission Not Allowed',
          response,
        );
}

class GeoLocationPermissionNotDetermined extends AppException {
  GeoLocationPermissionNotDetermined(
    String? message, {
    ApiResponse? response,
  }) : super(
          message,
          'Geo Location Permission Not Determined',
          response,
        );
}

class GenericException extends AppException {
  GenericException(
    String? message, {
    ApiResponse? response,
    RetryHandler? retryHandler,
  }) : super(
          message,
          'Generic Exception occurred',
          response,
          retryHandler: retryHandler,
        );
}
