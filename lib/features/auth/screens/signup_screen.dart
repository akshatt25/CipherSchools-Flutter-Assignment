import 'package:expense_tracker/constants/global_variables.dart';
import 'package:expense_tracker/features/auth/screens/signin_screen.dart';
import 'package:expense_tracker/features/auth/services/google_sign_in.dart';
import 'package:expense_tracker/features/auth/services/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  final _signinFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Sign Up',
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
                    height: 30,
                  ),
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(
                    height: 25,
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
                    height: 20,
                  ),
                  FormField<bool>(
                    builder: (state) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              activeColor: GlobalVariables.voilet,
                              fillColor: const MaterialStatePropertyAll(
                                  GlobalVariables.purple),
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  state.didChange(value);
                                });
                              },
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: const EdgeInsets.all(0),
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              title: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: 'By signing up, you agree to the',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.5),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' Terms of Service and Privacy Policy',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: GlobalVariables.voilet,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.5),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                state.errorText ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).errorColor,
                                ),
                              ),
                            )
                          ]);
                    },
                    validator: (value) {
                      if (!isChecked) {
                        return 'Accept Terms to Continue';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      if (_signinFormKey.currentState!.validate() &&
                          isChecked) {
                        await signUp(
                            context: context,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
                    text: "Sign Up",
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
                          '  Sign Up with Google',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SigninScreen.routeName,
                      );
                    },
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Already have an account? ',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 122, 122, 122),
                                  fontSize: 17))),
                      TextSpan(
                          text: 'Login',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: GlobalVariables.voilet,
                                  fontSize: 18))),
                    ])),
                  )

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
