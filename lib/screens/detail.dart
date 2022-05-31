// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Colors.black, transitionBetweenRoutes: true),
        backgroundColor: Colors.black,
        child: SafeArea(
            child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontFamily: "Pretendard"),
          softWrap: true,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 22.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Hero(
                  tag: "__news_title",
                  child: Text(
                    "Varo, First Chartered Neobank, Could Run Out of Money by End of Year",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: "Pretendard"),
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
              Hero(
                tag: "__news_info",
                child: Text(
                  "by mooreds  |  +1 points  |  0 comments",
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 14.4,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 22.0),
                child: CupertinoButton(
                    onPressed: () {},
                    color: Colors.grey[900],
                    padding:
                        EdgeInsets.symmetric(vertical: 2.5, horizontal: 22.0),
                    child: Text(
                      "Visit the website",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    )),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "thathndude 3 hours ago",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15.6),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                                '''Arbitration consumer protection attorney here! Nice work, and nice write up.

If nothing else, I hope folks will run with your first point. Far too many people are scared of arbitration, and it can be a really powerful tool for situations like this. It’s fairly accessible and straightforward, especially for folks in the HN crowd.

One pointer for other folks in the future is to make sure you look into your state’s specific consumer protection law. (Sometimes called UDAP law or deceptive practices act.) Often times, these laws will allow you to recover more than just your out of pocket damages to punish companies that are deceptive.

One other way to “enlarge the pie” in situations like this is to hire an attorney. I know, it sounds like I’m shilling for my peers, but hear me out. This same UDAP consumer protection laws let you recover attorneys’ fees as part of a judgment/win. If you’re not an attorney, you simply can’t seek those.

So let’s say your claim is \$2,000. Under those laws, maybe you can “treble” (triple) your damages if you win. So now your best day is \$6,000. And the company knows it.

But if that same law says you can get attorneys’ fees too, the company knows that they could be facing a 50k+ judgment at the end (almost entirely comprising attorneys’ fees), and then that often incentivizes earlier, higher settlements. My involvement in cases, and the threat of attorneys’ fees often results in higher settlements than my client would get on their “best day,” and even after paying out my portion. (I typically do these on contingency — I don’t get paid unless you get paid).

Lastly, let’s just say I’ve done an arbitration or two with a home warranty company. They don’t make money by paying out claims! '''),
                          ),
                          CupertinoButton(
                              child: Text(
                                "View reply",
                                style: TextStyle(fontSize: 15.8),
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 18.0)),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        )));
  }
}
