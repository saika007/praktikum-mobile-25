import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // -------------------------------
              // Email Input
              // -------------------------------
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 10),

              // -------------------------------
              // Password Input
              // -------------------------------
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 20),

              // -------------------------------
              // Login Button
              // -------------------------------
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.login,
                        child: const Text("Login"),
                      ),
              ),

              const SizedBox(height: 20),

              // -------------------------------
              // Login as Guest
              // -------------------------------
              TextButton(
                onPressed: controller.loginAsGuest,
                child: const Text("Login as Guest"),
              ),

              const SizedBox(height: 10),

              // -------------------------------
              // Debug Button
              // -------------------------------
              OutlinedButton(
                onPressed: controller.debug,
                child: const Text("Debug Mode"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
