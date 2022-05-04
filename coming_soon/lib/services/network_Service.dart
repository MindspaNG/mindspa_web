import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'package:coming_soon/app/app.logger.dart';
import 'package:coming_soon/services/i_network_service.dart';
import 'package:coming_soon/utilities/network/api_constants.dart';
import 'package:coming_soon/utilities/network/api_credentials.dart';

import '../utilities/network/failure.dart';

class NetworkService implements INetworkService {
  final _log = getLogger('NetworkService');
  final _dio = Dio();
  NetworkService() {
    _dio.options.baseUrl = ApiConstants.baseUri.toString();
    _dio.options.sendTimeout = ApiConstants.sendTimeout;
    _dio.options.receiveTimeout = ApiConstants.receiveTimeout;
    _log.i('Network Service constructed and DIO setup register');
  }

  Future<dynamic> _get(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    _log.i('Making request to $uri');
    try {
      final response = await _dio.get(
        uri.toString(),
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Authorization": "Basic ${ApiCredentials.apiKeyBase64}",
          },
          method: 'GET',
          contentType: 'application/json; charset=utf-8',
        ),
      );
      _log.i('Response from $uri \n${response.data}');
      return response.statusCode == 200;
    } on DioError catch (error) {
      if (error.error is SocketException) {
        throw const Failure(
          'You are not connected to the internet.',
        );
      }
      _log.e(error.message);
    } catch (error) {
      _log.e(error.toString());
      throw Failure(error.toString());
    }
  }

  Future<dynamic> _post(
    Uri uri, {
    required Map<String, dynamic> body,
  }) async {
    _log.i('Making request to $uri');
    try {
      final response = await _dio.post(
        uri.toString(),
        data: body,
        options: Options(
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Authorization": "Basic ${ApiCredentials.apiKeyBase64}",
          },
          contentType: 'application/json; charset=utf-8',
        ),
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        _log.i('Response from $uri \n${response.data}');
      }

      return response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204;
    } on DioError catch (error) {
      if (error.error is SocketException) {
        throw const Failure(
          'You are not connected to the internet.',
        );
      }
      String errorMessage = error.response!.data['errors'][0]['message'] ??
          error.response!.data['detail'];
      customErrorMessage(errorMessage);
      _log.e(error.response!.data['detail']);
      _log.e('${error.response!.data['errors'][0]['message']}');
    }
  }

  @override
  Future openlinkInNewTab({required String url}) async {
    try {
      html.window.open(url, '_blank');
    } catch (e) {
      _log.e(e);
      throw const Failure('Something went wrong');
    }
  }

  @override
  Future openLinkInSameTab({required String url}) async {
    try {
      html.window.open(url, '_self');
    } catch (e) {
      _log.e(e);
      throw const Failure('Something went wrong');
    }
  }

  @override
  Future<bool> subscribeToMailingList({required String email}) async {
    bool isUserSubscribed = await _post(
      ApiConstants.addSubscriberToWaitlistUri,
      body: {"email_address": email, "status": "subscribed"},
    );
    _log.i('isUserSubscribed: $isUserSubscribed');
    if (isUserSubscribed) {
      _log.i('Adding user to beta testers tags');
      bool userAddedToBetaWaitingList =
          await addToBetaTesterMailingList(subscribedUserEmail: email);
      _log.i('userAddedToBetaWaitingList: $userAddedToBetaWaitingList');
      return userAddedToBetaWaitingList;
    } else {
      return false;
    }
  }

  @override
  Future<bool> addToBetaTesterMailingList(
      {required String subscribedUserEmail}) async {
    var emailHash = md5.convert(utf8.encode(subscribedUserEmail));
    bool isUserAddedToBetaTesterEmail = await _post(
      ApiConstants.addSubscroberToBetaTesters(
        subscribedUserEmailHash: emailHash,
      ),
      body: {
        "tags": [
          {"name": "Beta Testers", "status": "active"}
        ]
      },
    );
    _log.i('isUserAddedToBetaTesterEmail: $isUserAddedToBetaTesterEmail');
    return isUserAddedToBetaTesterEmail;
  }

  @override
  Future<bool> pingServer() async {
    bool isWorking = await _get(
      ApiConstants.pingserverUris,
    );
    return isWorking;
  }

  void customErrorMessage(String message) {
    if (message.contains('blank')) {
      throw const Failure(
          'Input field is blank, pls input your email address and try again');
    }
    if (message.contains('is already a list member')) {
      throw const Failure(
        'Your email already exists, try again with another email',
      );
    }
    if (message.contains('please enter a real email address')) {
      throw const Failure(
        'Sorry we can\'t use this email, try again with another email',
      );
    } else {
      throw const Failure('Something went wrong, pls try again');
    }
  }
}
