// import 'dart:convert';

// import 'package:coming_soon/app/app.logger.dart';
// import 'package:coming_soon/services/i_network_service.dart';
// import 'package:coming_soon/utilities/network/api_constants.dart';
// import 'package:http/http.dart';

// import '../utilities/network/api_credentials.dart';
// import '../utilities/network/failure.dart';
// import 'package:requests/requests.dart';
// import 'package:universal_io/io.dart';

// class HttpNetworkService implements INetworkService {
//   final _log = getLogger('HttpNetworkService');
//   Client httpClient = Client();

//   Future _post(Uri uri,
//       {required Map<String, dynamic> body,
//       Map<String, String>? headers}) async {
//     try {
//       final response = await httpClient.post(
//         uri,
//         body: body,
//         headers: headers,
//       );
//       if (response.statusCode == 200) {
//         return response.body;
//       }
//     } catch (e) {
//       _log.e(e);
//     }
//   }

//   Future<dynamic> _get(
//     Uri uri, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, String>? headers,
//   }) async {
//     _log.i('Making request to $uri');
//     try {
//       final response = await httpClient.get(
//         uri,
//         headers: headers,
//       );
//       _log.i('Response from $uri \n${response.body}');
//       return response.body;
//     } catch (error) {
//       _log.e(error.toString());
//     }
//   }

//   @override
//   Future addToBetaTesterMailingList({required subscribedUserEmail}) {
//     // TODO: implement addToBetaTesterMailingList
//     throw UnimplementedError();
//   }

//   @override
//   Future openlink({required String url}) {
//     // TODO: implement openlink
//     throw UnimplementedError();
//   }

//   @override
//   Future subscribeToMailingList({required String email}) async {
//     String username = 'comingsoon';
//     String password = ApiKey.apiKey;
//     String basicAuth =
//         'Basic ' + base64Encode(utf8.encode('$username:$password'));
//     _log.i(basicAuth);
//     await _post(
//       ApiConstants.addSubscriberToWaitlistUri,
//       body: {"email_address": email, "status": "subscribed"},
//       headers: <String, String>{
//         "Authorization": "Bearer $ApiKey.apiKey",
//         'accept': 'application/json',
//         'Accept': '*/*',
//         'Connection': 'keep-alive'
//       },
//     );
//   }

//   @override
//   Future pingServer() async {
//     var result = await _get(
//         Uri.parse('https://us20.api.mailchimp.com/3.0/ping'),
//         headers: {
//           "Authorization":
//               "Basic YW55dGhpbmc6MDhmZTJiNWYyYzljNTMyZWFhMjM5MTE4Zjc4ZWFiMjQtdXMyMA=="
//         });
//     _log.i(result);
//   }
// }
