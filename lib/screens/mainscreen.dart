import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 300),
                height: 54,
                width: 165,
                child: const Text(
                  'Taurist',
                  style: TextStyle(fontSize: 46, fontFamily: 'Inter'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 250),
                decoration: BoxDecoration(
                  // gradient: const LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   stops: [0.0, 1.0],
                  //   colors: [
                  //     Color(0xff01cd8d),
                  //     Color(0xff93edc7),
                  //   ],
                  // ),
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
                    minimumSize: MaterialStateProperty.all(const Size(260, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    //Navigator.popUntil(context, ModalRoute.withName('/login'));
                    Navigator.pushNamed(
                      context,
                      '/login',
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
              // Container(
              //   margin: const EdgeInsets.only(top: 10),
              //   decoration: BoxDecoration(
              //     /*gradient: const LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       stops: [0.0, 1.0],
              //       colors: [
              //         Color(0xff01cd8d),
              //         Color(0xff93edc7),
              //       ],
              //     ),*/
              //     color: Color.fromRGBO(44, 83, 72, 1),
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //         RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20.0),
              //         ),
              //       ),
              //       minimumSize: MaterialStateProperty.all(const Size(260, 40)),
              //       backgroundColor:
              //           MaterialStateProperty.all(Colors.transparent),
              //       shadowColor: MaterialStateProperty.all(Colors.transparent),
              //     ),
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/signin');
              //     },
              //     child: const Padding(
              //       padding: EdgeInsets.only(
              //         top: 10,
              //         bottom: 10,
              //       ),
              //       child: Text(
              //         'Sign Up',
              //         style: TextStyle(
              //           fontFamily: 'Inter',
              //           fontSize: 16,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
