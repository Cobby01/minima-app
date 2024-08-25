import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_button.dart';
import 'package:minimal_social_app/components/my_textfield.dart';

import '../helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  // Register method
  void registerUser() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Make sure passwords match
    if (passwordController.text != confirmPwController.text) {
      // Pop the loading circle
      Navigator.pop(context);

      // Show error message to user
      displayMessageToUser("Passwords don't match!", context);
      return;
    }

    try {
      // Create the user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // create a user document and to firestore 
      createUseerDocument(userCredential);


      // Pop the loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle
      Navigator.pop(context);

      // Display error message to user
      displayMessageToUser(e.message ?? "An error occurred", context);
    }
  }

    Future<void> createUseerDocument(UserCredential? userCredential) async{
      if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
      .collection("Users")
      .doc(userCredential.user!.uid)
      .set({
        'username': usernameController.text,
        'email': userCredential.user!.email,
        'bio': 'Empty bio...',
      });
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              // App name
              const Text(
                "T R A C K I T",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),

              // Username textfield
              MyTextfield(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),

              // Email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),

              // Password textfield
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // Confirm Password textfield
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPwController,
              ),
              const SizedBox(height: 10),

              // Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Register button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),
              const SizedBox(height: 10),

              // Already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

