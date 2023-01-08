import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    //authentication user
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        dynamic user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          // The user is not signed in, display an error message
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You must be signed in to add a user'),
            ),
          );
        } else {
          // The user is signed in, proceed with adding the user to the Firestore collection
          addUser(
            firstNameController.text.trim(),
            secondNameController.text.trim(),
            emailController.text.trim(),
            int.parse(ageController.text.trim()),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The account already exists for that email.'),
            ),
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  // add user details to firestore
  //   addUser(
  //     firstNameController.text.trim(),
  //     secondNameController.text.trim(),
  //     emailController.text.trim(),
  //     int.parse(ageController.text.trim()),
  //   );
  // }

//   FirebaseUser user = await FirebaseAuth.instance.currentUser;
// if (user == null) {
//   // The user is not signed in, display an error message
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('You must be signed in to add a user'),
//     ),
//   );
// } else {
//   // The user is signed in, proceed with adding the user to the Firestore collection
//   addUser(
//     firstNameController.text.trim(),
//     secondNameController.text.trim(),
//     emailController.text.trim(),
//     int.parse(ageController.text.trim()),
//   );
// }

  // Future<void> addUser(
  //     String firstName, String secondName, String email, int age) async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return users
  //       .add({
  //         'first_name': firstName,
  //         'second_name': secondName,
  //         'email': email,
  //         'age': age,
  //       })
  //       // ignore: avoid_print
  //       .then((value) => print('User Added'))
  //       // ignore: avoid_print
  //       .catchError((error) => print('Failed to add user: $error'));
  // }

  Future<void> addUser(
      String firstName, String secondName, String email, int age) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.add({
        'first_name': firstName,
        'second_name': secondName,
        'email': email,
        'age': age,
      });
    } catch (e) {
      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add user: $e'),
        ),
      );
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text == confirmPasswordController.text) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 170),
                  Text('Hello there!',
                      style: GoogleFonts.greatVibes(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text('Please register here'),
                  const SizedBox(height: 25),
                  //First Name TextField
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  //Second Name TextField
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: secondNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Last Name',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  //Age TextField
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: ageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Age',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  //Email TextField
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email address',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  //Password TextField
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      )),
                  const SizedBox(height: 15),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      )),
                  const SizedBox(height: 25),

                  //Sign In Button
                  GestureDetector(
                    onTap: signUp,
                    child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                            child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
