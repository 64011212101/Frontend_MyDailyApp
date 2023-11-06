import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mydiary/pages/homemydiary.dart';
import 'package:mydiary/pages/mydiary.dart';

class ShowActivitiesPage extends StatefulWidget {
  final String id;
  const ShowActivitiesPage({super.key, required this.id});

  @override
  State<ShowActivitiesPage> createState() => _ShowActivitiesPageState();
}

class _ShowActivitiesPageState extends State<ShowActivitiesPage> {
  dynamic data;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      isLoading = true;
      getActivityToday();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('กิจกรรมของชาวบ้าน'),
        backgroundColor: const Color.fromARGB(255, 214, 114, 114),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 214, 114, 114),
        onPressed: () {
          Get.to(() => MyDiaryPage(
                id: widget.id,
              ));
        },
        child: const FaIcon(FontAwesomeIcons.faceSmileBeam),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: list(),
            ),
    );
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        itemCount: data!.isEmpty ? 0 : data!.length,
        itemBuilder: (BuildContext context, int index) {
          return row(index);
        },
      ),
    );
  }

  Widget row(int index) {
    return SizedBox(
      width: Get.width,
      height: 210,
      child: InkWell(
        onTap: () {
          Get.to(() => const HomeMydairyPage());
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            child: Card(
              color: const Color.fromARGB(255, 214, 114, 114),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Container(
                      color: const Color.fromARGB(255, 220, 80, 80),
                      child: Center(
                        child: Text(
                          data[index]['shortstory'],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 7, 7, 7),
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        height: 140,
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                            border: Border.all(width: 2.0), // Blue border
                          ),
                          child: Image.network(
                              'http://202.28.34.197:8888/contents/bb1a8850-e6c6-4be0-9ab8-62a379e35ac8.jpg'),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getActivityToday() async {
    const url = 'https://diary.comsciproject.net/testservice/activity/today';
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
