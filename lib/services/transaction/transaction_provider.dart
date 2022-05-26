import 'dart:convert';

import 'package:food_market/models/transaction.dart';
import 'package:food_market/models/user.dart';
import 'package:food_market/services/services.dart';
import 'package:http/http.dart' as http;

// class TransactionProvider extends GetConnect {
//   Future<Response> submitTransaction(Transaction transaction) async {
//     String data = jsonEncode({
//       'product_id': transaction.food!.id,
//       'qty': transaction.qty,
//       'driver': transaction.driver,
//       'total': transaction.total,
//     });

//     String token = await User.getToken() ?? '';

//     Response res = await post(
//       "$BASE_URL/transactions",
//       data,
//       contentType: "application/json",
//       headers: {
//         "Authorization": "Bearer $token",
//       },
//     );

//     return res;
//   }

//   Future<Response> updateCanceledStatus(id) async {
//     String token = await User.getToken() ?? "";

//     Response res = await patch(
//         '$BASE_URL/transactions/$id', jsonEncode({"status": "canceled"}),
//         headers: {"Authorization": "Bearer $token"});

//     return res;
//   }

//   Future<Response> getTransactions() async {
//     String token = await User.getToken() ?? "";

//     Response res = await get('$BASE_URL/transactions', headers: {
//       "Authorization": "Bearer $token",
//     });
//     return res;
//   }
// }

class TransactionProvider {
  Future<http.Response> submitTransaction(Transaction transaction) async {
    String data = jsonEncode({
      'product_id': transaction.food!.id,
      'qty': transaction.qty,
      'driver': transaction.driver,
      'total': transaction.total,
    });

    http.Client client = http.Client();

    String token = await User.getToken() ?? '';

    http.Response res = await client.post(
      Uri.parse("$BASE_URL/transactions"),
      body: data,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return res;
  }

  Future<http.Response> updateCanceledStatus(id) async {
    String token = await User.getToken() ?? "";

    http.Client client = http.Client();

    http.Response res = await client.patch(
      Uri.parse('$BASE_URL/transactions/$id'),
      body: jsonEncode({"status": "canceled"}),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    return res;
  }

  Future<http.Response> getTransactions() async {
    String token = await User.getToken() ?? "";

    http.Client client = http.Client();

    http.Response res = await client.get(
      Uri.parse('$BASE_URL/transactions'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return res;
  }
}
