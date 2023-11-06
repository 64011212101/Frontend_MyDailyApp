import 'package:flutter/material.dart';

class HomeMydairyPage extends StatefulWidget {
  const HomeMydairyPage({super.key});

  @override
  State<HomeMydairyPage> createState() => _HomeMydairyState();
}

class _HomeMydairyState extends State<HomeMydairyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('กิจกรรม'),
          backgroundColor: const Color.fromARGB(255, 214, 114, 114)),
      backgroundColor: const Color.fromARGB(255, 214, 114, 114),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 18, top: 18),
            child: SizedBox(
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: const Color.fromARGB(255, 220, 80, 80),
                  child: const Center(
                      child: Text(
                    'xxx xxx',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 18, top: 8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    color: const Color.fromARGB(255, 214, 114, 114),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(right: 10.0, top: 10, left: 10),
                          child: Text(
                            'ประโยคเด็ดวันนี้',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(right: 10.0, top: 10, left: 10),
                          child: Text(
                            'SSSSSS',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: SizedBox(
                                width: 300,
                                height: 200,
                                child: ClipOval(
                                  child: Image.asset(
                                    'https://www.youngciety.com/assets/images/article/arts-for-kids/arts-for-kids-2.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 10.0, right: 10, left: 10),
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                Text(
                                  'เรื่องราววันนี้',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
