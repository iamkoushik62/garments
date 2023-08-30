


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_3/Garments.dart';

class FirebaseFirestoreHelp {
  static FirebaseFirestoreHelp instance = FirebaseFirestoreHelp();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  

  Future<List<Product>> getGarmentsList() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("Garments").get();

    List<Product> garmentsList = querySnapshot.docs
        .map((e) => Product.fromJson(e.data()))
        .toList();
    
    return garmentsList;
  } catch (e) {
    print("Error fetching garments: $e");
    return [];
  }
}
  Future<List<Product>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("Garments").get();

      List<Product> bestProduct = querySnapshot.docs
          .map((e) => Product.fromJson(e.data()))
          .toList();
      return bestProduct;
    } catch (e) {
      
      return [];
    }
  }
}