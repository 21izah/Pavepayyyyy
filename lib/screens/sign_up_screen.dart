import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/sign_up_provider.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 1;

  bool isChecked = false;

  bool passwordObscured = true;

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _comfirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  final _nameController = TextEditingController();

  final _referralController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _comfirmpasswordController = TextEditingController();

  // final firebaseUser = FirebaseAuth.instance.currentUser;

  // final docUser = FirebaseFirestore.instance.collection('users').doc();

  @override
  void dispose() {
    _nameController.dispose();
    _referralController.dispose();

    _emailController.dispose();

    _passwordController.dispose();
    _comfirmpasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: screenSize.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      // bottomRight: Radius.circular(70),
                      ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: screenSize.height * 0.020,
                          ),
                          child: Text(
                            'Welcome',
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 0.3,
                      // ),
                      Center(
                        child: Container(
                          child: Text(
                            "Let's Know you better",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
              ),
              Container(
                height: screenSize.height * 0.75,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        padding: const EdgeInsets.all(1.0),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          cursorHeight: 20,
                          // cursorRadius: Radius.circular(100),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          cursorColor: Colors.blue,
                          style: TextStyle(color: Colors.blue),
                          controller: _nameController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.blue),
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.blue),
                          cursorColor: Colors.blue,
                          controller: _passwordController,
                          obscureText: passwordObscured,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              suffixIcon: IconButton(
                                onPressed: (() => setState(() {
                                      passwordObscured = !passwordObscured;
                                    })),
                                icon: Icon(
                                  passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.blue,
                                ),
                              ),
                              hintText: 'Choose Password',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Comfirm Password is required';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.blue),
                          controller: _comfirmpasswordController,
                          obscureText: passwordObscured,
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              suffixIcon: IconButton(
                                onPressed: (() => setState(() {
                                      passwordObscured = !passwordObscured;
                                    })),
                                icon: Icon(
                                  passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.blue,
                                ),
                              ),
                              hintText: 'Comfirm Password',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          style: TextStyle(color: Colors.blue),
                          cursorColor: Colors.blue,
                          controller: _referralController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: 'Referral Code',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox.adaptive(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = !isChecked;
                                      });
                                    },
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Click to accept PavePay's ",
                                              style: TextStyle(
                                                fontSize:
                                                    screenSize.height * 0.015,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  Navigator.of(context).push(
                                                PageTransition(
                                                  child: LoginScreen(),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                ),
                                              ),
                                              child: Text(
                                                "Terms and Service",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenSize.height *
                                                            0.015,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.005,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Consumer<SignUpProvider>(
                        builder: (context, SignUpProvider, child) =>
                            GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // _login();
                              SignUpProvider.isLoading
                                  ? null
                                  : SignUpProvider.simulateSignUp(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      comfirmPassword:
                                          _comfirmpasswordController.text
                                              .trim(),
                                      name: _nameController.text.trim(),
                                      referralcode:
                                          _referralController.text.trim(),
                                    );
                            }
                          },
                          child: Container(
                            height: screenSize.height * 0.06,
                            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // height: 50,
                            // margin: const EdgeInsets.fromLTRB(80, 0, 90, 0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SignUpProvider.isLoading
                                      ? Container(
                                          height: 10,
                                          width: 10,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                            backgroundColor: Colors.black,
                                            strokeWidth: 5,
                                            color: Colors.black,
                                          ),
                                        )
                                      : Text(
                                          SignUpProvider.isLoading ? '' : '',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      SignUpProvider.isLoading
                                          ? 'Please wait'
                                          : 'SIGN UP',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   top: screenSize.height * 0.27,
          //   right: screenSize.width * 0.0585,
          //   child: Container(
          //     // color: Colors.amber,
          //     child: Center(
          //       child: Container(
          //         // width: 150,
          //         decoration: BoxDecoration(
          //             color: Colors.deepOrange,
          //             borderRadius: BorderRadius.circular(10)),
          //         padding: EdgeInsets.all(10),
          //         child: Row(children: [
          //           GestureDetector(
          //             onTap: () {
          //               Navigator.of(context).pushReplacement(
          //                 PageTransition(
          //                   child: LoginScreen(),
          //                   type: PageTransitionType.fade,
          //                 ),
          //               );
          //             },
          //             child: Container(
          //               padding: EdgeInsets.all(15),
          //               decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.horizontal(
          //                       left: Radius.circular(10))),
          //               child: Text(
          //                 'SIGN IN',
          //                 style: TextStyle(
          //                   color: Colors.deepOrange,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             padding: EdgeInsets.all(15),
          //             decoration: BoxDecoration(
          //                 color: Colors.black,
          //                 borderRadius: BorderRadius.horizontal(
          //                     right: Radius.circular(10))),
          //             child: Text(
          //               'SIGN UP',
          //               style: TextStyle(
          //                 color: Colors.deepOrange,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ]),
          //       ),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
