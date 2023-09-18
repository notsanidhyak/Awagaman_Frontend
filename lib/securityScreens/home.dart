import 'dart:convert';

import 'package:avagaman/models/students_out.dart';
import 'package:avagaman/securityScreens/camera_view.dart';
import 'package:avagaman/securityScreens/detect.dart';
import 'package:avagaman/securityScreens/encode.dart';

import 'package:avagaman/securityScreens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' as rootBundle;

class SecurityHomePage extends StatefulWidget {
  const SecurityHomePage({super.key});

  @override
  State<SecurityHomePage> createState() => _SecurityHomePageState();
}

class _SecurityHomePageState extends State<SecurityHomePage> {
  Future<List<Students>> ReadJsonData() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('data/out.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => Students.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Students Outside ",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.book_rounded, color: Colors.greenAccent),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                IconButton(
                    iconSize: 25,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const SecurityProfile()));
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white60,
                    )),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 20,
            bottom: MediaQuery.of(context).size.height * .26,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .9,
              child: FutureBuilder(
                future: ReadJsonData(),
                builder: (context, data) {
                  if (data.hasError) {
                    //in case if error found
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    //once data is ready this else block will execute
                    // items will hold all the data of DataModel
                    //items[index].name can be used to fetch name of product as done below
                    var items = data.data as List<Students>;
                    return ListView.builder(
                        // ignore: unnecessary_null_comparison
                        itemCount: items == null ? 0 : items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            color: const Color(0xff121a25),
                            child: Container(
                              height: 70,
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${items[index].name}\n${items[index].id}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.white54),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                  ),
                                  Text(
                                    items[index].time.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Colors.white54),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff121a25),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                      height: 5,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Color(0xFFff725e),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      )),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (c) => Report()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFff725e),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      "Mark Entry",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
