import 'package:equatable/equatable.dart';

enum FoodType { newTaste, popular, recommended, none }

class Food extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final double? rating;
  final String? ingredients;
  final int? stock;
  final String? imageUrl;
  final String? type;

  const Food({
    this.name,
    this.description,
    this.price,
    this.rating,
    this.ingredients,
    this.stock,
    this.imageUrl,
    this.id,
    this.type,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: int.parse(json['id'].toString()),
      description: json['description'],
      imageUrl: json['picture'],
      ingredients: json['ingredients'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      rating: double.parse(json['rating'].toString()),
      stock: int.parse(json['stock'].toString()),
      type: json['type'],
    );
  }

  static List<Food> mock = const [
    Food(
      name: 'Soup Bumil',
      description:
          "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
      ingredients: "Seledri, telur, blueberry, madu.",
      price: 19000,
      stock: 100,
      imageUrl:
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTmj0H1jg6YTK-lHxBHytdZk3Fb8mk3e4sJV8suy52MMEBjAlEbNRw5gCLRcV3QUA6osGdw_kjz4AVEguSg51zr_vR5N2g47QRqQtyizVOOkQejmOoVSxtE0Q&usqp=CAE",
      rating: 4.2,
    ),
    Food(
      name: 'Soup Bumil',
      description:
          "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
      ingredients: "Seledri, telur, blueberry, madu.",
      price: 19000,
      stock: 100,
      imageUrl:
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTmj0H1jg6YTK-lHxBHytdZk3Fb8mk3e4sJV8suy52MMEBjAlEbNRw5gCLRcV3QUA6osGdw_kjz4AVEguSg51zr_vR5N2g47QRqQtyizVOOkQejmOoVSxtE0Q&usqp=CAE",
      rating: 4.5,
    ),
    Food(
      name: 'Soup Bumil',
      description:
          "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
      ingredients: "Seledri, telur, blueberry, madu.",
      price: 19000,
      stock: 100,
      imageUrl:
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTmj0H1jg6YTK-lHxBHytdZk3Fb8mk3e4sJV8suy52MMEBjAlEbNRw5gCLRcV3QUA6osGdw_kjz4AVEguSg51zr_vR5N2g47QRqQtyizVOOkQejmOoVSxtE0Q&usqp=CAE",
      rating: 4.5,
    ),
    Food(
      name: 'Soup Bumil',
      description:
          "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
      ingredients: "Seledri, telur, blueberry, madu.",
      price: 19000,
      stock: 100,
      imageUrl:
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTmj0H1jg6YTK-lHxBHytdZk3Fb8mk3e4sJV8suy52MMEBjAlEbNRw5gCLRcV3QUA6osGdw_kjz4AVEguSg51zr_vR5N2g47QRqQtyizVOOkQejmOoVSxtE0Q&usqp=CAE",
      rating: 4.5,
    ),
  ];

  @override
  List<Object?> get props =>
      [id, name, description, ingredients, price, stock, imageUrl, rating];
}
