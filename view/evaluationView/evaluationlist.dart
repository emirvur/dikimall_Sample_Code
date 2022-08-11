import 'dart:ui';

import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/enums/userType.dart';

import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dikimall/models/User.dart';
import 'package:koukicons/star.dart';

class EvaluationList extends StatefulWidget {
  final bool istailor;
  final bool issearch;
  final UserData user;
  const EvaluationList(this.istailor, this.issearch, this.user);

  @override
  _EvaluationListState createState() => _EvaluationListState();
}

class _EvaluationListState extends State<EvaluationList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool _isLastStep = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 1, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        print("sonda");
        setState(() {
          _isLastStep = true;
        });
      } else {
        setState(() {
          _isLastStep = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: new Text(
            "Değerlendirmeleri Gör",
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 10),
                    child: TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: kPrimaryColor,
                      tabs: [
                        Tab(
                          text: widget.istailor == true ? 'Terzi' : 'Tasarım',
                        ),
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: kPrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cirtlaksari,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  KoukiconsStar(
                                    color: Colors.white,
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    widget.istailor == true
                                        ? "Dikim"
                                        : "Tasarım",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  Text(
                                    widget.issearch
                                        ? widget.user.role ==
                                                UserTypeHelper.getValue(
                                                    UserType.TAILOR)
                                            ? widget.user.ratingterzi.toString()
                                            : widget.user.ratingtasarimci
                                                .toString()
                                        : widget.istailor == true
                                            ? Sabit.user.ratingterzi.toString()
                                            : Sabit.user.ratingtasarimci
                                                .toString()
                                                .substring(0, 3),
                                    style: TextStyle(
                                        fontSize: AppSize.smallsize,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              alignment: Alignment.center,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 3,
                                            color:
                                                miracgolge, // shadow direction: bottom right
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          KoukiconsStar(
                                            color: cirtlaksari,
                                            height: 12,
                                            width: 12,
                                          ),
                                          Text(
                                            widget.istailor
                                                ? widget.user.ratingdikis
                                                    .toString()
                                                : widget.user.ratingcizim
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: AppSize.smallsize,
                                            ),
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: widget.istailor
                                          ? Column(
                                              children: [
                                                Text("Dikiş",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                                Text("Yeteneği",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Text("Yaratıcılık",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                                Text("",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              color:
                                                  miracgolge // shadow direction: bottom right
                                              )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          KoukiconsStar(
                                            color: cirtlaksari,
                                            height: 12,
                                            width: 12,
                                          ),
                                          Text(
                                            widget.istailor
                                                ? widget.user.ratingmalzeme
                                                    .toString()
                                                : widget.user.ratingmalzeme
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: widget.istailor
                                          ? Column(
                                              children: [
                                                Text("Malzeme",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                                Text("Kalitesi",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Text("Çizim",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                                Text("",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.smallsize,
                                                    )),
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              color:
                                                  miracgolge // shadow direction: bottom right
                                              )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          KoukiconsStar(
                                            color: cirtlaksari,
                                            height: 12,
                                            width: 12,
                                          ),
                                          Text(
                                            widget.istailor
                                                ? widget.user.ratingterzihiz
                                                    .toString()
                                                : widget.user.ratingtasarimcihiz
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          Text("Hız",
                                              style: TextStyle(
                                                fontSize: AppSize.smallsize,
                                              )),
                                          Text("",
                                              style: TextStyle(
                                                fontSize: AppSize.smallsize,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,

                                        // borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              color:
                                                  miracgolge // shadow direction: bottom right
                                              )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          KoukiconsStar(
                                            color: cirtlaksari,
                                            height: 12,
                                            width: 12,
                                          ),
                                          Text(
                                            widget.istailor
                                                ? widget
                                                    .user.ratingterziiletisim
                                                    .toString()
                                                : widget.user
                                                    .ratingtasarimciiletisim
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: AppSize.smallsize,
                                            ),
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          Text("İletişim",
                                              style: TextStyle(
                                                fontSize: AppSize.smallsize,
                                              )),
                                          Text("",
                                              style: TextStyle(
                                                fontSize: AppSize.smallsize,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: widget.issearch
                                    ? widget.user.role == "Terzi"
                                        ? ListView(
                                            children: widget
                                                .user.degerlendirmeTerzi
                                                .map((DegerlendirmeTerzi key) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 8, 8),
                                                  child: BoxShadowContainer(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 120,
                                                      //        color: Colors.blue,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            15.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      key.ad,
                                                                      style: TextStyle(
                                                                          fontSize: AppSize
                                                                              .normalsize,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        24,
                                                                        12,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "${key.dikim}/10",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              AppSize.normalsize,
                                                                          color: key.dikim > 8
                                                                              ? tasarimbilgiyesil
                                                                              : key.dikim < 4
                                                                                  ? Colors.red
                                                                                  : kPrimaryColor,
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  key
                                                                      .aciklama, // key.aciklama,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          anayazi)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    12.0,
                                                                    12),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    tarihconvert(key
                                                                        .tarih),
                                                                    /*     key.tarih.substring(
                                                                            0,
                                                                            10),*/
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey))
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                            }).toList(),
                                          )
                                        : ListView(
                                            children: widget
                                                .user.degerlendirmeTasarimci
                                                .map((DegerlendirmeTasarimci
                                                    key) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 8, 8),
                                                  child: BoxShadowContainer(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 120,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            15.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      key.ad,
                                                                      style: TextStyle(
                                                                          fontSize: AppSize
                                                                              .normalsize,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        24,
                                                                        12,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "${key.cizim}/10",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              AppSize.normalsize,
                                                                          color: key.cizim > 8
                                                                              ? tasarimbilgiyesil
                                                                              : key.cizim < 4
                                                                                  ? Colors.red
                                                                                  : kPrimaryColor,
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  key
                                                                      .aciklama, 
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          anayazi)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    12.0,
                                                                    12),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    tarihconvert(key
                                                                        .tarih),
                                                                    /*     key.tarih.substring(
                                                                            0,
                                                                            10),*/
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey))
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                            }).toList(),
                                          )
                                    : widget.istailor == true
                                        ? ListView(
                                            children: Sabit
                                                .user.degerlendirmeTerzi
                                                .map((DegerlendirmeTerzi key) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 8, 8),
                                                  child: BoxShadowContainer(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 120,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            15.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      key.ad,
                                                                      style: TextStyle(
                                                                          fontSize: AppSize
                                                                              .normalsize,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        24,
                                                                        12,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "${key.dikim}/10",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              AppSize.normalsize,
                                                                          color: key.dikim > 8
                                                                              ? tasarimbilgiyesil
                                                                              : key.dikim < 4
                                                                                  ? Colors.red
                                                                                  : kPrimaryColor,
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  key
                                                                      .aciklama, 
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          anayazi)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    12.0,
                                                                    12),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    tarihconvert(key
                                                                        .tarih),
                                                                    /*     key.tarih.substring(
                                                                            0,
                                                                            10),*/
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey))
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                            }).toList(),
                                          )
                                        : ListView(
                                            children: Sabit
                                                .user.degerlendirmeTasarimci
                                                .map((DegerlendirmeTasarimci
                                                    key) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 8, 8),
                                                  child: BoxShadowContainer(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 120,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            15.0,
                                                                            24.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      key.ad,
                                                                      style: TextStyle(
                                                                          fontSize: AppSize
                                                                              .normalsize,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        24,
                                                                        12,
                                                                        0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "${key.cizim}/10",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              AppSize.normalsize,
                                                                          color: key.cizim > 8
                                                                              ? tasarimbilgiyesil
                                                                              : key.cizim < 4
                                                                                  ? Colors.red
                                                                                  : kPrimaryColor,
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                  key
                                                                      .aciklama, 
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          anayazi)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    12.0,
                                                                    12),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    tarihconvert(key
                                                                        .tarih),
                                                                    /*     key.tarih.substring(
                                                                            0,
                                                                            10),*/
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .grey))
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                            }).toList(),
                                          )),
                          ],
                        ),
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
