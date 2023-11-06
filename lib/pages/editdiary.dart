import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mydiary/pages/showactivities.dart';

class EditDiary extends StatefulWidget {
  final String id;
  final String uid;
  const EditDiary({super.key, required this.id, required this.uid});

  @override
  State<EditDiary> createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {
  dynamic data;
  bool isLoading = false;

  var dedCtl = TextEditingController();
  var describeCtl = TextEditingController();

  PlatformFile? pickedImg;

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('วันนี้เป็นไงบ้าง (แก้ไข)'),
        backgroundColor: const Color.fromARGB(255, 214, 114, 114),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (pickedImg != null) ...{
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          // shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(
                                File(pickedImg!.path!),
                              ),
                              fit: BoxFit.cover)),
                    ),
                  } else
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          //shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/29/c2/09/29c20910e6a300754e058c541ac1b3c9.jpg"),
                          )),
                    ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 114, 114),
                      ),
                      onPressed: () {
                        selectImg();
                      },
                      icon: const FaIcon(FontAwesomeIcons.camera),
                      label: const Text('ถ่ายรูป')),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      child: TextField(
                        controller: describeCtl,
                        decoration: InputDecoration(
                            labelText: 'ประโยคเด็ดวันนี้',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: TextField(
                        controller: dedCtl,
                        decoration: InputDecoration(
                            labelText: 'อธิบายสิ วันนี้เป็นไงบ้าง......',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 214, 114, 114),
                        ),
                        onPressed: () {
                          String ded = dedCtl.text;
                          String describe = describeCtl.text;
                          editdiary();
                          Get.to(() => ShowActivitiesPage(id: widget.uid));
                        },
                        child: const Text('บันทึก')),
                  )
                ],
              ),
            ),
    );
  }

  Future selectImg() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    setState(() {
      pickedImg = result.files.first;
    });
  }

  void editdiary() async {
    final datajson = {
      "aid": widget.id,
      "story": dedCtl.text,
      "shortstory": describeCtl.text
    };
    print(dedCtl.text);
    print(describeCtl.text);
    const url = 'https://diary.comsciproject.net/testservice/activity/update';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(datajson));
    print(response.statusCode);
    if (200 == response.statusCode) {
      final acData = jsonDecode(response.body);
      print(acData);
      setState(() {
        data = acData;
        isLoading = false;
      });
      setState(() {});
    } else {
      throw Exception('Login failed');
    }
  }
}
