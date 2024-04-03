import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/change_password_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordComfirnController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _passwordComfirnController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(

              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 250,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Can't remember your password? That's alright. Kindly provide the email you used un signing up",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Old Password is required';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.emailAddress,
                    controller: _oldPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Old Password',
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Comfirm is required';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordComfirnController,
                    decoration: InputDecoration(
                        hintText: 'Password Comfirm',
                        hintStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<ChangePasswordProvider>(
                  builder: (context, gh, child) => GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // _login();
                        gh.isLoading
                            ? null
                            : gh.simulateForgotPassword(
                                old_password:
                                    _oldPasswordController.text.trim(),
                                password: _passwordController.text.trim(),
                                password_confirmation:
                                    _passwordComfirnController.text.trim(),
                              );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            gh.isLoading
                                ? Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                      backgroundColor: Colors.black,
                                      strokeWidth: 5,
                                      color: Colors.black,
                                    ),
                                  )
                                : Text(
                                    gh.isLoading ? '' : '',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                gh.isLoading
                                    ? 'Please wait'
                                    : 'Recover Password',
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
              ]),
        ),
      ),
    );
  }
}
