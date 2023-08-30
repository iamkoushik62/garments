import 'dart:convert';



Product productModelFromJson(String str) =>
    Product.fromJson(json.decode(str));

String productModelToJson(Product data) => json.encode(data.toJson());



class Product {
  final String Name;
  final String Image;
  final int price;

  final String Id;



  Product({required this.Name, required this.price,required this.Id,required this.Image});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      Image: json["Image"] ?? "",
      Id: json["Id"],
      Name: json["Name"],
      price: json["price"],
   
      );
  
  Map<String, dynamic> toJson() {
    return {
      'Id':Id,
      'Image': Image,
      'Name': Name,
      'price': price,
      

    };

  }

}
