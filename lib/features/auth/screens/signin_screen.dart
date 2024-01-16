import 'package:expense_tracker/features/auth/services/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constants/global_variables.dart';
import '../services/google_sign_in.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class SigninScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isLoading = false;
  final _signinFormKey = GlobalKey<FormState>();
  TextEditingController rePassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          toolbarHeight: 85,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Sign In',
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Form(
              key: _signinFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    hidden: true,
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                    hidden: true,
                    controller: rePassController,
                    hintText: 'Retype Password',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FormField(
                    builder: (state) {
                      return Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).errorColor,
                        ),
                      );
                    },
                    validator: (value) {
                      if (passwordController.text != rePassController.text) {
                        return 'Password doesn\'t Match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  CustomButton(
                    onPressed: () async {
                      if (_signinFormKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await login(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    text: "Log In",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    '-OR-',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black38)),
                    child: TextButton.icon(
                        onPressed: () {
                          signUpWithGoogle(context: context);
                        },
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 25,
                          width: 25,
                        ),
                        label: const Text(
                          '  Sign In with Google',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                  ),

                  //
                ],
              ),
            ),
          ),
        ),
      ),
      isLoading
          ? Container(
              alignment: Alignment.center,
              color: GlobalVariables.load,
              child: LoadingAnimationWidget.flickr(
                  size: 50,
                  leftDotColor: Colors.blue,
                  rightDotColor: Color.fromARGB(255, 177, 206, 252)))
          : SizedBox()
    ]);
  }
}
