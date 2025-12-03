import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  // ----------------------------
  // Normal Login
  // ----------------------------
  Future<void> login() async {
    isLoading.value = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.snackbar("Success", "Login Successful!");
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message ?? "Failed to login");
    }

    isLoading.value = false;
  }

  // ----------------------------
  // Guest Login
  // ----------------------------
  void loginAsGuest() {
    Get.snackbar("Guest Mode", "You are now logged in as a guest!");
    Get.offAllNamed('/home'); // redirect to home
  }

  // ----------------------------
  // Debug Button Action
  // ----------------------------
  void debug() {
    Get.snackbar("Debug", "Debug mode activated!");
    Get.toNamed('/debug');
  }
}
