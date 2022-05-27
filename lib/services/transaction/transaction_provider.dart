import 'dart:convert';

import 'package:food_market/models/transaction.dart';
import 'package:food_market/models/user.dart';
import 'package:food_market/services/services.dart';
import 'package:http/http.dart' as http;

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
      Uri.parse("$baseUrl/transactions"),
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
      Uri.parse('$baseUrl/transactions/$id'),
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
      Uri.parse('$baseUrl/transactions'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    return res;
  }
}
