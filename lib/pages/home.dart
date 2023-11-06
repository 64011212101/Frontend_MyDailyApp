import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mydiary/pages/showactivities.dart';
import 'package:mydiary/pages/signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'My Diary',
            style: GoogleFonts.ibmPlexSansThai(),
          ),
          backgroundColor: const Color.fromARGB(255, 214, 114, 114)),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SizedBox(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 40,
                    color: const Color.fromARGB(255, 214, 114, 114),
                    child: const Center(
                        child: Text('Login to My Diary',
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 7, 7),
                                fontSize: 25))),
                  ),
                ),
              )),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Email'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                  child: TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              )),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Password'),
            ),
            SizedBox(
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Get.to(() => const SignUpPage());
                    },
                    child: const Text('Sign Up',
                        style: TextStyle(
                            color: Color.fromARGB(255, 214, 114, 114),
                            fontSize: 16))), //255, 214, 114, 114
              ],
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 214, 114, 114),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      int uid = await loginUser();
                      log("aaaa $uid");

                      if (uid > 0) {
                        Get.to(() => ShowActivitiesPage(
                              id: '$uid',
                            ));
                      }
                    },
                    child: const SizedBox(
                      width: 100,
                      child: Center(
                        child: Text('Login',
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 7, 7),
                                fontSize: 16)),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  Future<int> loginUser() async {
    final data = {"email": email.text, "password": password.text};
    const url = 'https://diary.comsciproject.net/testservice/user/login';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(data));

    if (200 == response.statusCode) {
      final userData = jsonDecode(response.body);
      // print("11111 ${response.body}");
      // print(userData['check']);
      if (userData['check'] == '0') {
        // print(userData['uid']);
        return userData['uid'];
      } else {
        return 0;
      }
    } else {
      throw Exception('Login failed');
    }
    // return "response.body";
  }
}
