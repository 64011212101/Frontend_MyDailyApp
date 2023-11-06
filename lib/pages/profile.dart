import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({super.key, required this.id});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic data;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (data == null) {
      isLoading = true;
      getUserdata("1");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('รู้มั้ยฉันเป็นใคร'),
        backgroundColor: const Color.fromARGB(255, 214, 114, 114),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: ClipOval(
                        child: Image.network(
                          'https://kawtung.com/images/2022/09/kawtung.com_92daf8cdb22ee4974053b477d8685496.jpeg',
                        ),
                      ),
                    ),
                  ),
                  Text(data[0]['username'],
                      style: const TextStyle(
                          color: Color.fromRGBO(221, 29, 29, 0.557),
                          fontSize: 30)),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, right: 227),
                    child: Text('Email',
                        style: TextStyle(
                            color: Color.fromARGB(255, 7, 7, 7), fontSize: 20)),
                  ),
                  SizedBox(
                    width: 500,
                    height: 40,
                    child: SizedBox(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 40,
                        color: const Color.fromARGB(255, 214, 114, 114),
                        child: Center(
                            child: Text(data[0]['email'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 238, 234, 234),
                                    fontSize: 22))),
                      ),
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, right: 210),
                    child: Text('Birthday',
                        style: TextStyle(
                            color: Color.fromARGB(255, 7, 7, 7), fontSize: 20)),
                  ),
                  SizedBox(
                    width: 500,
                    height: 40,
                    child: SizedBox(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 40,
                        color: const Color.fromARGB(255, 214, 114, 114),
                        child: Center(
                            child: Text(data[0]['birthday'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 238, 234, 234),
                                    fontSize: 22))),
                      ),
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, right: 220),
                    child: Text('Phone',
                        style: TextStyle(
                            color: Color.fromARGB(255, 7, 7, 7), fontSize: 20)),
                  ),
                  SizedBox(
                    width: 500,
                    height: 40,
                    child: SizedBox(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 40,
                        color: const Color.fromARGB(255, 214, 114, 114),
                        child: Center(
                            child: Text(data[0]['phone'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 238, 234, 234),
                                    fontSize: 22))),
                      ),
                    )),
                  ),
                ],
              ),
            ),
    );
  }

  void getUserdata(String id) async {
    print(id);
    final url = 'https://diary.comsciproject.net/testservice/user/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);
    if (200 == response.statusCode) {
      final acData = jsonDecode(response.body);

      print(acData);
      setState(() {
        isLoading = false;
        data = acData;
      });
    } else {
      throw Exception('Login failed');
    }
  }
}
