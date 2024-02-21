import 'package:flutter/material.dart';
import 'package:major_vcare/screen/selection.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              // Negative velocity indicates an upward swipe
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const SelectionScreen(); // Replace 'SecondScreen' with your next screen.
                  },
                ),
              );
            }
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/p.jpeg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 40, bottom: 300),
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Column(
                        children: [
                          Text(
                            "Feel The "
                            "Heal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontFamily: "Itim",
                            ),
                          ),
                          Text(
                            """Medical Support Wherever You Are,
              Whenever You Need""",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Itim",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -30,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Image(
                    image: const AssetImage("assets/doc.png"),
                    fit: BoxFit.cover,
                    // width: MediaQuery.of(context).size.width*.8,
                    // height: MediaQuery.of(context).size.height*.5,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.deepPurple,
                                blurRadius: 12.0,
                                offset: Offset(3.0, 3.0))
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(80)),
                          color: Colors.white),
                      child: Text("Swipe Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Itim",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center),
                      padding: EdgeInsets.all(5),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
