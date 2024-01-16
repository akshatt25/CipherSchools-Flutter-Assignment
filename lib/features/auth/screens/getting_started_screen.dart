import 'package:expense_tracker/constants/global_variables.dart';
import 'package:expense_tracker/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({super.key});

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    // Create a Tween that varies from 0.0 to 1.0
    Tween<double> _tween = Tween<double>(begin: 5.0, end: 2.5);

    // Apply the tween to the controller
    _animation = _tween.animate(_controller);

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: GlobalVariables.purple,
      body: panel(),
    );
  }

  Widget panel() {
    return Stack(
      children: [
        Positioned(
          top: 55,
          left: 20,
          child: Image.asset(
            'assets/images/logo.png',
            height: 85,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            'assets/images/rounds.png',
            height: 230,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          child: Transform.rotate(
            angle: 180 * 3.1415926535 / 180,
            child: Image.asset(
              'assets/images/rounds.png',
              height: 230,
              color: Color.fromARGB(137, 255, 255, 255),
            ),
          ),
        ),
        Positioned(
            bottom: 190,
            left: 30,
            child: Text(
              'Welcome to',
              style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(color: Colors.white, fontSize: 40)),
            )),
        Positioned(
            bottom: 135,
            left: 50,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'C',
                      style: GoogleFonts.brunoAceSc(
                          textStyle: TextStyle(fontSize: 38)) // First word
                      ),
                  // Space between words
                  TextSpan(
                      text: 'IPHER',
                      style: GoogleFonts.brunoAceSc(
                          textStyle:
                              TextStyle(fontSize: 30)) // Rest of the text
                      ),
                  // Space between words
                  TextSpan(
                      text: 'X.',
                      style: GoogleFonts.brunoAceSc(
                          textStyle: TextStyle(fontSize: 38)) // Last word
                      ),
                ],
              ),
            )),
        Positioned(
            bottom: 160,
            right: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, SignupScreen.routeName);
              },
              child: SizedBox(
                width: 70,
                height: 40,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(248, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(3.5 * _animation.value, 0.0),
                        child: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )),
        Positioned(
            bottom: 40,
            left: 30,
            child: Text(
              "The best way to track you expenses.",
              style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
            ))
      ],
    );
  }
}
