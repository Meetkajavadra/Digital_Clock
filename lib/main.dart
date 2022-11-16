import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? timer;

  final TextEditingController myThoughtscontroller = TextEditingController();

  String myThoughts = '';
  String SaveTime = '';

  updateSeconds() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {},
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateSeconds();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Digital Clock"),
              centerTitle: true,
            ),
            backgroundColor: Colors.black,
            body: Column(
              children: [
                SizedBox(height: 200),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 15,
                            color: Colors.white,
                          ),
                        ],
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        SaveTime =
                            "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second} ",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  color: Colors.grey,
                  child: SizedBox(
                    width: 150,
                    height: 30,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: myThoughtscontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Thoughts",
                        hintText: "Your Thoughts",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text(
                    "Save Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    setData() async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      await pref.setString('mythoughts', myThoughtscontroller.text) ?? '';
                      await pref.setString('currenttime',"${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : ${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second}");
                    }
                    SharedPreferences pref =
                    await SharedPreferences.getInstance();

                    print(pref.getString('mythoughts'));
                    print(pref.getString('currenttime'));

                    setState(() {
                      setData();
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
