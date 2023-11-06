import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mydiary/pages/home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var username = TextEditingController();
  var email = TextEditingController();
  var birthday = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สมัครสมาชิก'),
        backgroundColor: const Color.fromARGB(255, 214, 114, 114),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    color: Colors.amber,
                    child: const Center(
                        child: Text(
                      'Sign up My Dairy',
                      style: TextStyle(fontSize: 25),
                    ))),
              ),
            ),
            const Text('Username'),
            SizedBox(
                width: 250,
                child: TextField(
                  controller: username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: 'Password',
                  ),
                )),
            const Text('Email'),
            SizedBox(
                width: 250,
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: 'Password',
                  ),
                )),
            const Text('Birthday'),
            SizedBox(
                width: 250,
                child: TextField(
                  controller: birthday,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    //labelText: 'Password',
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                )),
            const Text('Phone numder'),
            SizedBox(
                width: 250,
                child: TextField(
                  controller: phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: 'Password',
                  ),
                )),
            const Text('Password'),
            SizedBox(
                width: 250,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: 'Password',
                  ),
                )),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: SizedBox(
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                      onPressed: () async {
                        backgroundColor:
                        String data = await signupUesr();
                        if (data == "success") {
                          // print(data);
                          Get.to(() => const HomePage());
                        } else {
                          // print(data);
                        }
                      },
                      child: const Text('ลงทะเบียน')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> signupUesr() async {
    final data = {
      "username": username.text,
      "password": password.text,
      "email": email.text,
      "birthday": birthday.text,
      "phone": phone.text
    };
    print(data);
    const url = 'https://diary.comsciproject.net/testservice/user/regester';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(data));
    print(response.statusCode);
    // print(DateTime.parse(birthday.text));
    // var date = DateTime.parse(birthday.text).day.toString();
    print(DateTime.now());

    if (200 == response.statusCode) {
      final userData = jsonDecode(response.body);
      // print("11111 ${response.body}");
      // print(userData['result']);
      if (userData['status'] == '0') {
        // print("status :" + userData['result']);
        return userData['result'];
      } else {
        // print("status :" + userData['result']);
        return userData['result'];
      }
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        birthday.text = picked.toString().split(" ")[0];
      });
    }
  }
}
