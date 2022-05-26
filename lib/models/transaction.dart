import 'package:food_market/models/food.dart';
import 'package:food_market/models/user.dart';

class Transaction {
  final int? id;
  final int? qty;
  final User? user;
  final Food? food;
  final int? total;
  final int? driver;
  final int? tax;
  final String? orderId;
  final String? status;
  final String? paymentUrl;
  final String? paymentToken;

  Transaction(
      {this.id,
      this.qty,
      this.user,
      this.food,
      this.driver,
      this.total,
      this.tax,
      this.orderId,
      this.status,
      this.paymentToken,
      this.paymentUrl});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    Food food = Food.fromJson(json['product']);
    User user = User.fromJson(json['user']);

    return Transaction(
      id: json['id'],
      qty: json['qty'],
      driver: json['driver'],
      tax: int.tryParse(((json['total'] - json['driver']) * 0.1).toString()) ??
          0,
      paymentToken: json['payment_token'],
      paymentUrl: json['payment_url'],
      food: food,
      total: json['total'],
      user: user,
      status: json['status'],
    );
  }

  Transaction copyWith({
    int? id,
    int? qty,
    User? user,
    Food? food,
    int? total,
    int? driver,
    int? tax,
    String? orderId,
    String? status,
    String? paymentUrl,
    String? paymentToken,
  }) {
    return Transaction(
      id: id ?? this.id,
      user: user ?? this.user,
      food: food ?? this.food,
      driver: driver ?? this.driver,
      orderId: orderId ?? this.orderId,
      paymentToken: paymentToken ?? this.paymentToken,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      qty: qty ?? this.qty,
      status: status ?? this.status,
      tax: tax ?? this.tax,
      total: total ?? this.total,
    );
  }

  static Transaction mock = Transaction(
    driver: 90000,
    qty: 1,
    food: Food.mock[0],
    id: 1,
    tax: 20000,
    total: 90000 + 20000 + Food.mock[0].price!.toInt(),
    user: User.mock,
    status: "completed",
  );

  static List<Transaction> mocks = [
    mock,
    Transaction(
      driver: 90000,
      qty: 1,
      food: Food.mock[1],
      id: 1,
      tax: 20000,
      total: 90000 + 20000 + Food.mock[0].price!.toInt(),
      user: User.mock,
    ),
    Transaction(
        driver: 90000,
        qty: 1,
        food: Food.mock[2],
        id: 1,
        tax: 20000,
        total: 90000 + 20000 + Food.mock[0].price!.toInt(),
        user: User.mock,
        status: "completed"),
    Transaction(
      driver: 90000,
      qty: 1,
      food: Food.mock[3],
      id: 1,
      tax: 20000,
      total: 90000 + 20000 + Food.mock[0].price!.toInt(),
      user: User.mock,
      status: "completed",
    )
  ];
}
