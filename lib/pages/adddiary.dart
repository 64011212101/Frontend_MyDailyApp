import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mydiary/models/types.dart';
import 'package:mydiary/pages/mydiary.dart';

class AddDiary extends StatefulWidget {
  final String id;
  const AddDiary({super.key, required this.id});

  @override
  State<AddDiary> createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  bool isLoading = false;
  var dedCtl = TextEditingController();
  var describeCtl = TextEditingController();
  var image = TextEditingController();
  final List<String> items = [
    'งาน',
    'การเรียน',
    'กีฬา',
    'ส่วนตัว',
    'บรรเทิง',
    'เศร้า',
  ];
  String? selectedValue;
  Types? types;
  List<DropdownMenuItem>? menuItemList;
  PlatformFile? pickedImg;

  @override
  Widget build(BuildContext context) {
    if (types == null) {
      (context as Element).reassemble();
      isLoading = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('วันนี้เป็นไงบ้าง'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: isLoading
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
                    DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.redAccent,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.yellow,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.redAccent,
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 214, 114, 114),
                          ),
                          onPressed: () {
                            String ded = dedCtl.text;
                            String describe = describeCtl.text;
                            String type = selectedValue.toString();

                            adddiary();

                            Get.to(() => MyDiaryPage(
                                  id: widget.id,
                                ));
                          },
                          child: const Text('บันทึก')),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Future selectImg() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) {
      return;
    }
    String partimage = result.files.first.toString();
    print("\n\n\n=======$partimage");
    partimage = partimage.split(',')[0];
    print("\n\n\n=======$partimage");

    setState(() {
      pickedImg = result.files.first;

      // pickedImg =pickedImg.toString.s
    });
  }

  void adddiary() async {
    final data = {
      "uid": widget.id,
      "tid": items.indexOf(selectedValue.toString()),
      "story": describeCtl.text,
      "shortstory": dedCtl.text
    };
    const url = 'https://diary.comsciproject.net/testservice/activity/insert';
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(data));

    if (200 == response.statusCode) {
      final userData = jsonDecode(response.body);
      // print("11111 ${response.body}");
      // print(userData['check']);
      if (userData['check'] == '0') {
        // print(userData['uid']);
      }
    } else {
      throw Exception('Login failed');
    }
    // return "response.body";
  }
}
