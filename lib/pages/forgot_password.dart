// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final emailController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     super.dispose();
//   }

//   void passwordReset() async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(
//         email: emailController.text.trim(),
//       );
//       showDialog(context: context, builder: (context) {
//         return AlertDialog(
//           title: const Text('Password Reset Email Sent'),
//           content: const Text('A password reset email has been sent to the specified email address.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         showDialog(context: context, builder: (context) {
//           return AlertDialog(
//             title: const Text('User not found'),
//             content: const Text('No user found for the specified email address.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
//       ),
//       body: Container(
//         alignment: Alignment.topCenter,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             const Text('Enter your email and we will send you a password reset link:'),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: 350,
//               child: TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter your email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: 350,
//               child: ElevatedButton(
//                 onPressed: () {
//                   passwordReset;
//                 },
//                 child: const Text('Reset Passwod'),
//               ),
//             ),
//             ],
//         ),
//       ),
//     );
//   }
// }


