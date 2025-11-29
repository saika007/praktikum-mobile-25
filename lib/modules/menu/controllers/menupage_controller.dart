import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coffee.dart';

class MenuPageController extends GetxController {
  final coffees = <Coffee>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoffees();
  }

  void fetchCoffees() {
    FirebaseFirestore.instance
        .collection('menu')
        .doc('beverages')
        .collection('coffees')
        .snapshots()
        .listen(
          (snapshot) {
            coffees.value = snapshot.docs
                .map((doc) => Coffee.fromMap(doc.data()))
                .toList();
          },
          onError: (e) {
            debugPrint('Firestore Error: $e');
          },
        );
  }
}
