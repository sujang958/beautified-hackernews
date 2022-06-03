import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _itemSliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 42.0, bottom: 24.0),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 34.0),
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[900],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Opensource licenses",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                                GestureDetector(
                                  child: Text(
                                    "View licenses >",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.blue[700]),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Initial loading items",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => Theme(
                                            data: ThemeData.dark(),
                                            child: CupertinoAlertDialog(
                                              title: const Text(
                                                  "Change initial loading items"),
                                              content: const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: CupertinoTextField(
                                                    placeholder:
                                                        "Input with range 1~500",
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              actions: <CupertinoDialogAction>[
                                                CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.red[400]),
                                                  ),
                                                ),
                                                CupertinoDialogAction(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Change"),
                                                ),
                                              ],
                                            )));
                                  },
                                  child: Text(
                                    "50 >",
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.blue[700]),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
