import 'package:expense_tracker/constants/global_variables.dart';
import 'package:expense_tracker/features/auth/screens/getting_started_screen.dart';
import 'package:expense_tracker/features/auth/services/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../auth/services/get_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  void getUsername() async {
    final userData = await getFirestoreData(widget.uid);
    username = userData['name'];
    print(username);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 40),
            child: Column(
              children: [
                // Profile picture

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.purple, width: 3),
                          color: Colors.transparent),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/images/user_dp.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    username == null
                        ? Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 100),
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(19, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 50),
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(19, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 160,
                                  height: 50,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '$username',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    SvgPicture.asset(
                      'assets/images/img.svg',
                      height: 35,
                      width: 35,
                    ),
                  ],
                ),
                // ListTile(

                //   leading: Container(
                //     child:
                //   ),
                //   title: Text('User Name'),
                // ),

                // Username

                // Account settings
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      height: 95,
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: GlobalVariables.lightbg,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: GlobalVariables.voilet,
                              size: 32,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Account',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      height: 95,
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: GlobalVariables.lightbg,
                                borderRadius: BorderRadius.circular(15)),
                            child:
                                SvgPicture.asset('assets/images/settings.svg'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Settings',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      height: 95,
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: GlobalVariables.lightbg,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                'assets/images/export.png',
                                color: GlobalVariables.voilet,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Export Data',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    GestureDetector(
                      onTap: () {
                        showMyDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                        ),
                        height: 95,
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 251, 221, 221),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.logout,
                                color: Colors.red.shade400,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Logout',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                signOutAndClearPrefs();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GettingStarted()),
                    (route) => false);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
