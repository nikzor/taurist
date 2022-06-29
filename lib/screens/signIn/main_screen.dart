import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/routes.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({Key? key}) : super(key: key);
//
//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SignInWidget();
//       // StreamBuilder<User?>(
//       //   stream: FirebaseAuth.instance.authStateChanges(),
//       //   builder: (context, snapshot) {
//       //     if (snapshot.hasData) {
//       //       return const RoutesPage();
//       //     } else {
//       //       return const SignInWidget();
//       //     }
//       //   },
//       // ),
//     );
//   }
// }

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isVisible = true;
  bool pass = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  // Future signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Utils.showSnackBar('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       Utils.showSnackBar('Wrong password provided.');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80, left: 30),
                      height: 36,
                      width: 300,
                      child: const Text(
                        'Welcome Back',
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
                      width: 110,
                      child: const Text(
                        'New to the app?',
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
                            // Navigator.pushNamed(
                            //   context,
                            //   '/signin',
                            // );
                            Get.toNamed(Routes.signUpPage);
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(44, 83, 72, 1),
                                fontWeight: FontWeight.w900),
                          )),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 343,
                  child: TextField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontSize: 16),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                      suffixIcon: IconButton(
                        onPressed: emailController.clear,
                        icon: const Icon(
                          Icons.clear,
                          color: Color.fromRGBO(189, 189, 189, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 343,
                  child: TextField(
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
                                  color: const Color.fromRGBO(189, 189, 189, 1),
                                ),
                              )
                            : null),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/forgot',
                        // );
                        Get.toNamed(Routes.forgotPasswordPage);
                      },
                      style: TextButton.styleFrom(
                        primary: const Color.fromRGBO(189, 189, 189, 1),
                        textStyle:
                            const TextStyle(fontSize: 16, fontFamily: 'Inter'),
                      ),
                      child: const Text('Forgot password?'),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(44, 83, 72, 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    onPressed: (){
                      AuthorizationController.instance.signIn(
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
                        'Log in',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
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
    );
  }
}
