import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:test_project/product_model.dart';
class HiveService{
  static initHive() async{
    final applicationDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(ProductModelAdapter());

    await Hive.openBox<ProductModel>('product');
  }

  static void addProduct(ProductModel product){
    Hive.box<ProductModel>('product').add(product);
  }

  static List<ProductModel> getAllProducts(){
    final result = Hive.box<ProductModel>('product').values.toList();
    return result;
  }

  static void putProduct(int index, ProductModel product){
    Hive.box<ProductModel>('product').putAt(index, product);
  }

  static void deleteProduct(int index){
    Hive.box<ProductModel>('product').deleteAt(index);
  }

  static void deleteAllProducts(){
    Hive.box<ProductModel>('product').clear();
  }
}