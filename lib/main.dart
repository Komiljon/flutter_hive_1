import 'package:flutter/material.dart';
import 'package:test_project/hive_service.dart';
import 'package:test_project/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  void addcat() {
    HiveService.addProduct(ProductModel(
        id: 4,
        title: _controller2.text,
        description: _controller3.text,
        image: 'src',
        price: 56.90));
    listProduct = HiveService.getAllProducts();
  }

  List<ProductModel> listProduct = <ProductModel>[];

  @override
  void initState() {
    listProduct = HiveService.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Введите text1",
                fillColor: Colors.black12,
                filled: true),
            controller: _controller1,
          ),
          TextField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Введите text2",
                fillColor: Colors.grey,
                filled: true),
            controller: _controller2,
          ),
          TextField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Введите text3",
                fillColor: Colors.black12,
                filled: true),
            controller: _controller3,
          ),
          TextField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Введите text4",
                fillColor: Colors.grey,
                filled: true),
            controller: _controller4,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: listProduct.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                HiveService.deleteProduct(index);
                                listProduct = HiveService.getAllProducts();
                              });
                            },
                            child: Text(
                              '${listProduct[index].id}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16.0),
                            )),
                        const Divider(
                          height: 2.0,
                        ),
                        Text(
                          listProduct[index].title,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 16.0),
                        ),
                        const Divider(
                          height: 2.0,
                        ),
                        Text(
                          listProduct[index].description,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 16.0),
                        ),
                        const Divider(
                          height: 2.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                HiveService.deleteAllProducts();
                              });
                            },
                            child: Text(
                              '${listProduct[index].price}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16.0),
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addcat();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
