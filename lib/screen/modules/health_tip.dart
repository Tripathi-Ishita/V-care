import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'healthtipdata.dart';

class Healthtip extends StatefulWidget {
  const Healthtip({super.key});

  @override
  State<Healthtip> createState() => _HealthtipState();
}

class _HealthtipState extends State<Healthtip> {
  List<MyData> dataList = [];

  Future<void> getData() async {
    String jsonString = await rootBundle.loadString('assets/Health tips.json');
    List<dynamic> jsonList = json.decode(jsonString);
    dataList = jsonList.map((json) => MyData.fromJson(json)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          "First -Aid Tips",
          style:
              TextStyle(color: Colors.white, fontFamily: "Itim", fontSize: 20),
        ),
        backgroundColor: Colors.purple[700],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/h.jpeg"),
          fit: BoxFit.cover,
        )),
        child: dataList.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Image(
                                image:
                                    AssetImage("${dataList[index].picture}")),
                            Text(
                              "${dataList[index].question}",
                              style:
                                  TextStyle(fontSize: 18, fontFamily: "Itim"),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
