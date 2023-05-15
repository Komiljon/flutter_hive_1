import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId:0)
class ProductModel{

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String image;

  @HiveField(4)
  double price;
}