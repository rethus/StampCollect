import 'dart:convert';

import 'package:code/assets/myIcons.dart';
import 'package:code/chat/chatCard.dart';
import 'package:code/chat/models/userModel.dart';
import 'package:code/mainPages/communityPage/personatlas.dart';
import 'package:code/common/api.dart';
import 'package:code/mainPages/communityPage/myCommunityPart.dart';
import 'package:code/mainPages/minePage/fixmineInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'mineTitleAll.dart';

String type = 'lib/assets/titleImages/bronze.jpg';
Map aList;

class othersInfoPage extends StatefulWidget {
  // minePage({Key key}) : super(key: key);
  final int id;
  othersInfoPage({Key key, this.id}) : super(key: key);

  @override
  _othersInfoState createState() => _othersInfoState();
}

// ignore: camel_case_types
class _othersInfoState extends State<othersInfoPage> {
  @override
  void initState() {
    //初始化函数、带监听滑动功能
    super.initState();
    setState(() {
      aList = {
        'name': 'loading',
        'title': {'title_type': '1', 'title_name': 'loading'},
        'avatar_url': 'loading',
        'fans_num': '0',
        'subscribe_num': '0',
        'post_num': '0'
      };
      initThisPage();
    });
  }

  Future<void> initThisPage() async {
    await getAllTitle();
  }

  getAllTitle() async {
    var url = Uri.parse(Api.url + '/cs1902/user/info/' + widget.id.toString());
    var response =
        await http.get(url, headers: {"content-type": "application/json"});
    setState(() {
      aList = jsonDecode(Utf8Codec().decode(response.bodyBytes));
      if (aList['title']['title_type'] == 1) {
        type = 'lib/assets/titleImages/bronze.jpg';
      } else {
        type = 'lib/assets/titleImages/blue.jpg';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
       User sender=User(
    id: widget.id,
    name: aList['name'],
    imageUrl: aList['avatar_url'].toString()
  );
 
    return Container(
        decoration:
            new BoxDecoration(color: Color.fromARGB(255, 176, 210, 176)),
        child: Container(
            decoration: new BoxDecoration(),
            margin: const EdgeInsets.only(
                left: 30.0, right: 20, top: 17, bottom: 9),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => fixmineInfoPage()));
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2.0, 2.0), //阴影xy轴偏移量
                                  blurRadius: 5.0, //阴影模糊程度
                                  spreadRadius: 1.0 //阴影扩散程度
                                  )
                            ],
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(150),
                            image: DecorationImage(
                                image: NetworkImage(
                                    aList['avatar_url'].toString()),
                                fit: BoxFit.cover
                                // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                                )),
                      )),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, bottom: 9, top: 10),
                            child: Text(aList['name'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20))),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mineTitleAllPage()));
                          },
                          child: Container(
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                      width: 3, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(type),
                                      fit: BoxFit.cover)),
                              margin: const EdgeInsets.only(
                                  left: 20, bottom: 9, top: 10),
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 2, top: 2, right: 10),
                              child: Row(children: [
                                Text(
                                  aList['title']['title_name'],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: Colors.black, size: 24),
                              ])),
                        )
                      ]),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 65,
                width: double.infinity,
                decoration: new BoxDecoration(
                    border: new Border.all(width: 2, color: Colors.black12),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: new Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                          user: sender,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(MyIcons.message1Font))),
                          Text('私信',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                decorationStyle: TextDecorationStyle.double,
                                fontWeight: FontWeight.w500,
                                textBaseline: TextBaseline.alphabetic,
                                fontSize: 14,
                                letterSpacing: 2,
                                wordSpacing: 10,
                                height: 1.2,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 70,
                        child: InkWell(
                            onTap: () {},
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              new MaterialPageRoute(builder: (
                                            BuildContext context,
                                          ) {
                                            return new myCommunityPage(id: widget.id);
                                          }));
                                        },
                                        icon: Icon(MyIcons.communityFont)),
                                  ),
                                  Text('圈子',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                ]))),
                    SizedBox(
                        height: 70,
                        child: InkWell(
                            onTap: () {},
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Personatlas(
                                                          uid: widget.id
                                                              .toString())));
                                        },
                                        icon: Icon(MyIcons.bookFont)),
                                  ),
                                  Text('图鉴',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        decorationStyle:
                                            TextDecorationStyle.double,
                                        fontWeight: FontWeight.w500,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        wordSpacing: 10,
                                        height: 1.2,
                                      )),
                                ]))),
                  ],
                ),
              )
            ])));
  }
}
