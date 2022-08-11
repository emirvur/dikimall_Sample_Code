import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:dikimall/enums/userType.dart';

import 'ProfilePhotoAdd.dart';

class ProfileType extends StatefulWidget {
  final UserData user;
  final String password;
  const ProfileType(this.user, this.password);

  @override
  _ProfileTypeState createState() => _ProfileTypeState();
}

class _ProfileTypeState extends State<ProfileType> {
  var _height;
  var _width;
  int _selected = -1;
  @override
  Widget build(BuildContext context) {
    _height = (MediaQuery.of(context).size.height) * 35 / 100;
    _width = (MediaQuery.of(context).size.width) * 45 / 100;
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            color: Colors.white,
          ),
          new AppBar(
            centerTitle: true,
            title: new Text(
              "Profil Çeşidini Seçiniz",
              style: TextStyle(
                  //   fontSize: 12,
                  ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          new Positioned(
            top: 80.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            //here the body
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      widget.user.role =
                                          UserTypeHelper.getValue(
                                              UserType.USER);
                                      setState(() {
                                        _selected = 1;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ), // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          width: 2,
                                          color: _selected == 1
                                              ? kPrimaryColor
                                              : Colors.white,
                                        ),
                                      ),
                                      child: Container(
                                          height: _height,
                                          width: _width,
                                          //        color: Colors.blue,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ClipRRect(
                                                    child: Image.asset(
                                                      "assets/kullanicinet.jpeg",
                                                      // 'https://picsum.photos/250?image=12',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "KULLANICIYIM",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Terzi veya tasarımcı değilim\n",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  )))
                                            ],
                                          )),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                    onTap: () {
                                      widget.user.role =
                                          UserTypeHelper.getValue(
                                              UserType.DESIGNER);
                                      setState(() {
                                        _selected = 2;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ), // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                            width: 2,
                                            color: _selected == 2
                                                ? kPrimaryColor
                                                : Colors.white),
                                      ),
                                      child: Container(
                                        height: _height,
                                        width: _width,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                                  /*borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),*/
                                                  child: Image.asset(
                                                    "assets/tasarimnet.jpeg",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "TASARIMCIYIM",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Bana ne istediğini anlat ben tasarımını çizerim",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )))
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                    onTap: () {
                                      widget.user.role =
                                          UserTypeHelper.getValue(
                                              UserType.TAILOR);
                                      setState(() {
                                        _selected = 3;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ), // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                            width: 2,
                                            color: _selected == 3
                                                ? kPrimaryColor
                                                : Colors.white),
                                      ),
                                      child: Container(
                                        height: _height,
                                        width: _width,
                                        //        color: Colors.blue,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                            
                                                  child: Image.asset(
                                                    "assets/terzinet.jpeg",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "TERZİYİM\n",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      "Ölçüleri ve tasarımı ver ben kıyafetini dikerim",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )))
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                    onTap: () {
                                      widget.user.role =
                                          UserTypeHelper.getValue(
                                              UserType.BOTH);
                                      setState(() {
                                        _selected = 4;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ), // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                            width: 2,
                                            color: _selected == 4
                                                ? kPrimaryColor
                                                : Colors.white),       
                                      ),
                                      child: Container(
                                        height: _height,
                                        width: _width,
                                        //        color: Colors.blue,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                                  child: Image.asset(
                                                    "assets/hemterzihemtasarimci.jpeg",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Center(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "HEM TASARIMCIYIM \nHEM TERZİYİM",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Ben hem tasarımını çizerim \nhem de çizdiğimi dikerim",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )))
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                                width: (MediaQuery.of(context).size.width) *
                                    90 /
                                    100,
                                child: FlatButton(
                                    child: Text(
                                      'Tamamla',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    color: kPrimaryColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (_selected == -1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Profil Tipi Seçmelisiniz")),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePhotoAdd(widget.user,
                                                      widget.password)),
                                        );
                                      }
                                    })),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
