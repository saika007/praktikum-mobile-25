import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.snackbar("Success", "Login Successful!");

      Get.offAllNamed('/home'); // navigate to Home module
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message ?? "Failed to login");
    }

    isLoading.value = false;
  }
}
