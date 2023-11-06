import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mydiary/pages/adddiary.dart';
import 'package:mydiary/pages/editdiary.dart';
import 'package:mydiary/pages/profile.dart';

class MyDiaryPage extends StatefulWidget {
  final String id;
  const MyDiaryPage({super.key, required this.id});

  @override
  State<MyDiaryPage> createState() => _MyDiaryPageState();
}

class _MyDiaryPageState extends State<MyDiaryPage> {
  dynamic data;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (data == null) {
      isLoading = true;
      getMyactivity(widget.id.toString());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Diary'),
          backgroundColor: const Color.fromARGB(255, 214, 114, 114),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => ProfilePage(
                          id: widget.id,
                        ));
                  },
                  icon: const FaIcon(FontAwesomeIcons.addressCard)),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddDiary(
                  id: widget.id,
                ));
          },
          child: const FaIcon(FontAwesomeIcons.plus),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : list());
  }

  Widget list() {
    return ListView.builder(
      itemCount: data!.isEmpty ? 0 : data!.length,
      itemBuilder: (BuildContext context, int index) {
        return row(index);
      },
    );
  }

  Widget row(int index) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: (contexts) {
            Get.to(() => EditDiary(
                  id: data[index]['aid'].toString(),
                  uid: widget.id,
                ));
          },
          backgroundColor: Theme.of(context).colorScheme.error,
          icon: FontAwesomeIcons.penToSquare,
          label: 'edit',
        ),
        SlidableAction(
          onPressed: (contexts) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.confirm,
              text: 'Do you want to logout',
              confirmBtnText: 'Yes',
              cancelBtnText: 'No',
              confirmBtnColor: Colors.green,
              onConfirmBtnTap: () =>
                  deleteActivity(data[index]['aid'].toString()),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.error,
          icon: Icons.delete,
          label: 'Delete',
        )
      ]),
      child: InkWell(
        onTap: () {},
        child: Card(
          color: const Color.fromARGB(255, 214, 114, 114),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(data[index]['date'].toString().split(" ")[0],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 238, 238, 237),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(data[index]['shortstory'],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 238, 238, 237),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getMyactivity(String id) async {
    final url = 'https://diary.comsciproject.net/testservice/activity/user/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode);
    if (200 == response.statusCode) {
      final acData = jsonDecode(response.body);
      print(acData);
      setState(() {
        data = acData;
        isLoading = false;
      });
    } else {
      throw Exception('Login failed');
    }
  }

  void deleteActivity(String id) async {
    print(id);
    final url =
        'https://diary.comsciproject.net/testservice/activity/delete/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    print(response.statusCode);
    if (200 == response.statusCode) {
      final acData = jsonDecode(response.body);
      print(acData);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Login failed');
    }
  }
}
