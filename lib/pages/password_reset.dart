import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();


  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }


// ...

final FirebaseAuth _auth = FirebaseAuth.instance;

// ...

Future<void> resetPassword(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: emailController.text.trim());
    // Password reset email sent successfully
  } catch (e) {
    // An error occurred while trying to send the password reset email
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
      const Text('Please enter your register email'),
      TextField(
        decoration: InputDecoration(
      hintText: 'Email',
      hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        controller: emailController,
      ),
      MaterialButton(
        onPressed: (() => resetPassword(emailController.text.trim())),
        color: Colors.deepPurple,
        child: Text("Reset Password")
      )
        ],
      ),
    );
  }
}
