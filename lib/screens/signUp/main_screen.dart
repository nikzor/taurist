import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isVisible = true;
  bool pass = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future singUp() async {
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //     Utils.navigatorKey.currentState!
  //         .pushNamedAndRemoveUntil('/routes', (Route<dynamic> route) => false);
  //   } on FirebaseAuthException {
  //     Utils.showSnackBar('this email is already used');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 80, left: 30),
                        height: 36,
                        width: 300,
                        child: const Text(
                          'Welcome To Taurist',
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'Inter',
                              color: Color.fromRGBO(44, 83, 72, 1),
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3, left: 30),
                        height: 34,
                        width: 180,
                        child: const Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Inter',
                              color: Color.fromRGBO(44, 83, 72, 1),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3, left: 1),
                        height: 34,
                        width: 80,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName('/login'),
                            );
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(44, 83, 72, 1),
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 343,
                    child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          //label: Text('Email'),
                          hintText: "Email",
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1),
                              fontSize: 16),
                          border: const OutlineInputBorder(
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color.fromRGBO(44, 83, 72, 1)),
                          ),
                          suffixIcon: IconButton(
                            onPressed: emailController.clear,
                            icon: const Icon(
                              Icons.clear,
                              color: Color.fromRGBO(189, 189, 189, 1),
                            ),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: 343,
                      child: TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          obscureText: pass ? _isVisible : false,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                  color: Color.fromRGBO(189, 189, 189, 1),
                                  fontSize: 16),
                              border: const OutlineInputBorder(),
                              suffixIcon: pass
                                  ? IconButton(
                                      onPressed: /*passwordController.clear,*/ () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _isVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: const Color.fromRGBO(
                                            189, 189, 189, 1),
                                      ),
                                    )
                                  : null),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min 6 characters'
                                  : null),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(44, 83, 72, 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all(const Size(130, 30)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          AuthorizationController.instance.signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
