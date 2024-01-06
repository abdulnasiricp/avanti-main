// import 'dart:convert';
// import 'package:http/http.dart' as http;



// void initiateSTKPush() async {
//   var consumerKey = 'LFG5ouv6iYC0WMbsJ8vA5WiAsG4DaFm2';
//   var consumerSecret = 'XIPl2ChNSjACkcXK';
//   var businessShortCode = '174379';
//   var passkey =
//       'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';

//   var partyA = 'partyA';
//   var accountReference = 'phone';
//   var transactionDesc = 'DISCOUNTED AIRTIME';
//   var amount = 'amount';
//   var timestamp = DateTime.now()
//       .toString()
//       .split('.')
//       .first
//       .replaceAll(RegExp(r'[^0-9]'), '');

//   var password =
//       base64Encode(utf8.encode('$businessShortCode$passkey$timestamp'));

//   var headers = {
//     'Content-Type': 'application/json',
//     'Authorization':
//         'Basic ${base64Encode(utf8.encode("$consumerKey:$consumerSecret"))}',
//   };

//   var accessTokenUrl =
//       'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
//   var initiateUrl =
//       'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest';
//   var callBackUrl =
//       'https://morning-basin-87523.herokuapp.com/callback_url.php';

//   var accessTokenResponse =
//       await http.post(Uri.parse(accessTokenUrl), headers: headers);
//   var accessToken = json.decode(accessTokenResponse.body)['access_token'];

//   var stkHeaders = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };

//   var stkRequest = {
//     'BusinessShortCode': businessShortCode,
//     'Password': password,
//     'Timestamp': timestamp,
//     'TransactionType': 'CustomerPayBillOnline',
//     'Amount': amount,
//     'PartyA': partyA,
//     'PartyB': businessShortCode,
//     'PhoneNumber': partyA,
//     'CallBackURL': callBackUrl,
//     'AccountReference': accountReference,
//     'TransactionDesc': transactionDesc,
//   };

//   var stkResponse = await http.post(
//     Uri.parse(initiateUrl),
//     headers: stkHeaders,
//     body: json.encode(stkRequest),
//   );

//   print(stkResponse.body);
// }



library flutter_mpesa_stk;

import 'dart:convert';

import 'package:avanti/mpesa.dart';
import 'package:avanti/widgets/models/mpesaResponse.dart';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class FlutterMpesaSTK {
  final String _consumerKey;
  final String _consumerSecret;
  final String _stkPassword;
  final String _shortCode;
  final String _callbackURL;

  /// this is the testing environment used for testing implementation
  // String baseUrl = "https://sandbox.safaricom.co.ke/";
  String baseUrl = "https://api.safaricom.co.ke/mpesa/";
  final String defaultMessage;
  String? env;

  /// the env defaults to testing if not defined as production

  /// This is the constructor that allows one to define the environment variables
  FlutterMpesaSTK(this._consumerKey, this._consumerSecret, this._stkPassword,
      this._shortCode, this._callbackURL, this.defaultMessage,
      {this.env}) {
    env ??= "testing";
    if (env == "sandbox") {
      baseUrl = "https://sandbox.safaricom.co.ke/";
    }
  }

  ///this function allows a call to be made to safaricom for stk push
  /// the response is an Mpesa Response Model that includes details on whether the push was successful
  /// or failed, using boolean, as well as the response body
  /// if an error occurs it returns the default message.
  Future<MpesaResponse> stkPush(Mpesa mpesa) async {
    String timestamp = getTodayValidTimeStamp();
    var body = {
      "AccountReference": mpesa.accountReference,
      "BusinessShortCode": _shortCode,
      "PartyB": _shortCode,
      "Timestamp": timestamp,
      "PartyA": mpesa.phoneNumber,
      "TransactionType": "CustomerPayBillOnline",
      "Amount": mpesa.amount,
      "PhoneNumber": mpesa.phoneNumber,
      "Password": generatePasswordForStk(timestamp),
      "CallBackURL": _callbackURL,
      "TransactionDesc": mpesa.transactionDesc,
    };
    try {
      Response response = await postCall("mpesa/stkpush/v1/processrequest",
          {"Authorization": "Bearer ${await getAccessToken()}"}, body);
      if (response.statusCode != 200) {
        return MpesaResponse(false, json.decode(response.body));
      }
      return MpesaResponse(true, json.decode(response.body));
    } catch (e) {
      return MpesaResponse(false, defaultMessage);
    }
  }

  /// this function generates the password for getting the access token

  String generatePassword() {
    final bytes = utf8.encode("$_consumerKey:$_consumerSecret");
    return base64.encode(bytes);
  }

  /// this generates the password for the stk push request
  String generatePasswordForStk(String timestamp) {
    final bytes = utf8.encode("$_shortCode$_stkPassword$timestamp");
    return base64.encode(bytes);
  }

  /// this provides the valid date stamp to be used in password generation for stk
  String getTodayValidTimeStamp() {
    var datedefinedstamp = DateTime.now();
    return "${datedefinedstamp.year.toString()}${datedefinedstamp.month.toString().padLeft(2, '0')}${datedefinedstamp.day.toString().padLeft(2, '0')}${datedefinedstamp.hour.toString().padLeft(2, '0')}${datedefinedstamp.minute.toString().padLeft(2, '0')}${datedefinedstamp.second.toString().padLeft(2, '0')}";
  }

  /// this generates the accesstoken for the usage in the api call to saf
  Future<String> getAccessToken() async {
    Response response = await getCall(
        "oauth/v1/generate?grant_type=client_credentials",
        {"Authorization": "Basic ${generatePassword()}"});
    return json.decode(response.body)['access_token'];
  }

  /// this is a way of doing a GET call to saf
  Future<Response> getCall(String url, Map<String, String> headers) async {
    return await networkCall("GET", url, headers);
  }

  /// this handles the post call for saf
  Future<Response> postCall(
      String url, Map<String, String> headers, body) async {
    return await networkCall("POST", url, headers, body: body);
  }

  /// this is an easy way to do network calls in the package
  Future<Response> networkCall(
      String method, String url, Map<String, String> headers,
      {body}) async {
    var client = Client();
    // preferably a response that can be handled;
    Response response = Response(defaultMessage, 500);
    Uri uri = Uri.parse(baseUrl + url);
    headers.addEntries({"Content-Type": "application/json"}.entries);

    try {
      if (method == 'GET') {
        response = await client.get(uri, headers: headers);
      }
      if (method == 'POST') {
        response =
            await client.post(uri, headers: headers, body: json.encode(body));
      }
    } catch (e) {
      var logger = Logger();
      logger.e(e);
    }
    return response;
  }
}