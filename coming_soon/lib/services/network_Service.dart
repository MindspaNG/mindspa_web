import 'dart:io';
import 'dart:convert';
import 'package:coming_soon/app/app.logger.dart';
import 'package:coming_soon/services/i_network_service.dart';
import 'package:coming_soon/utilities/network/api_constants.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

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
            "Authorization":
                "Basic YW55dGhpbmc6MDhmZTJiNWYyYzljNTMyZWFhMjM5MTE4Zjc4ZWFiMjQtdXMyMA==",
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
            "Authorization":
                "Basic YW55dGhpbmc6MDhmZTJiNWYyYzljNTMyZWFhMjM5MTE4Zjc4ZWFiMjQtdXMyMA==",
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
      // _log.e(error.response!.data['detail']);
      _log.e('${error.response!.data['errors'][0]['message']}');

      throw Failure(error.response!.data['errors'][0]['message']);
    } catch (error) {
      _log.e(error);
      throw Failure(error.toString());
    }
  }

  @override
  Future openlink({required String url}) {
    // TODO: implement openlink
    throw UnimplementedError();
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
}
