import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Garments.dart';
import 'package:flutter_application_3/firestore.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> bestProduct = [];
  List<Product> product = [];

  bool isLoading = false;
  @override
  void initState() {
   
    getGarmentsList();
    super.initState();
  }

  void getGarmentsList() async {
    setState(() {
      isLoading = true;
    });
    bestProduct = await FirebaseFirestoreHelp.instance.getBestProducts();
    product = await FirebaseFirestoreHelp.instance.getGarmentsList();

    product.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<Product> searchList = [];
  void searchProducts(String value) {
    searchList = product
        .where((element) =>
            element.Name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(bottom:32 )),
                        const Text("E Commerce"),
                        TextFormField(
                          controller: search,
                          onChanged: (String value) {
                            searchProducts(value);
                          },
                          decoration:
                              const InputDecoration(hintText: "Search...."),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bestProduct.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: bestProduct
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(e.Image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                
                       const Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            "Best Products",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                       SizedBox.fromSize(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text("No Product Found"),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: searchList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 0.7,
                                          crossAxisCount: 2),
                                  itemBuilder: (ctx, index) {
                                    Product product = searchList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Image.network(
                                            product.Image,
                                            height: 100,
                                            width: 100,
                                          ),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Text(
                                            product.Name,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text("Price: \$${product.price}"),
                                          const SizedBox(
                                            height: 30.0,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: 140,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                
                                              },
                                              child: const Text(
                                                "Buy",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : product.isEmpty
                              ? const Center(
                                  child: Text("Best Product is empty"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GridView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 50),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: product.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 20,
                                              childAspectRatio: 0.7,
                                              crossAxisCount: 2),
                                      itemBuilder: (ctx, index) {
                                        Product productsModel = product[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Image.network(
                                                productsModel.Image,
                                                height: 100,
                                                width: 100,
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Text(
                                                productsModel.Name,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                  "Price: \$${productsModel.price}"),
                                              const SizedBox(
                                                height: 30.0,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 140,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    
                                                  },
                                                  child: const Text(
                                                    "Buy",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }
}