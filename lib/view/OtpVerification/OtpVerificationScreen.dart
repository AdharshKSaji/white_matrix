
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/view/splashscreen/splashscreen.dart';

class SignUpController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(BuildContext context, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully signed up!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }
}

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 233, 169, 72), Color.fromARGB(255, 235, 122, 114)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),
                _buildTextField("Email", _emailController),
                const SizedBox(height: 15),
                _buildTextField("Password", _passwordController, obscureText: true),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    final provider = Provider.of<SignUpController>(context, listen: false);
                    provider.signUp(context, _emailController.text, _passwordController.text);
                  },
                  child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
    );
  }
}

