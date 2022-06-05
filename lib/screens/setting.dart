import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 82.0, bottom: 42.0),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 34.0),
                          )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[900]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showLicensePage(context: context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 9.0, horizontal: 13.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('Opensource licenses'),
                                      Text(
                                        'View licenses >',
                                        style: TextStyle(
                                            color: CupertinoColors.systemBlue),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                            title: Text("hi"),
                                            actions: [
                                              CupertinoDialogAction(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 9.0, horizontal: 13.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('Initial loading items'),
                                      Text(
                                        '18 >',
                                        style: TextStyle(
                                            color: CupertinoColors.systemBlue),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ]))));
  }
}
