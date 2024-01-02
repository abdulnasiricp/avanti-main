import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> initiateSTKPush(String phoneNumber, String amount) async {
  final response = await http.post(
    Uri.parse('https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest'),
    headers: {
      // 'Authorization': 'Bearer YOUR_API_KEY_AND_SECRET',
      'Content-Type': 'application/json',
      'Authorization': 'Basic Q2RtTmJkdDBpQk4xb3FEZkthc200ZGFiZHBLbXRhTm46RExLRzdQQnVuNzIwR1ppbQ=='
    },
    body: jsonEncode({
      "BusinessShortCode": "YOUR_SHORTCODE",
      "Password": "YOUR_PASSWORD",
      "Timestamp": "20231005120000", // Replace with a valid timestamp
      "TransactionType": "CustomerPayBillOnline",
      "Amount": amount.toString(),
      "PartyA": phoneNumber,
      "PartyB": "YOUR_SHORTCODE",
      "PhoneNumber": phoneNumber,
      "CallBackURL": "https://ip_address:port/callback",
      "AccountReference": "YOUR_ACCOUNT_REFERENCE",
      "TransactionDesc": "BUY DISCOUNTED AIRTIME",
    }),
  );

  if (response.statusCode == 200) {
    // Process the response, which will contain details about the STK push request.
  } else {
    // Handle the error
  }
}
