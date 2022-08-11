import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'competenceUpdate.dart';

class CompetenceTailor extends StatefulWidget {
  final bool isother;
  final UserData otheruserinfo;
  const CompetenceTailor(this.isother, {this.otheruserinfo});

  @override
  _CompetenceTailorState createState() => _CompetenceTailorState();
}

class _CompetenceTailorState extends State<CompetenceTailor>
    with TickerProviderStateMixin {
  TabController _tabControllerbirli;
  List<String> _tiresizproducts = [];
  bool _editkumas = false;
  bool _editproduct = false;
  bool _editprice = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabControllerbirli = new TabController(length: 1, vsync: this);
    if (widget.isother == false) {
      print("digrermi false");
      for (var i in Sabit.user.urunlerterzi) {
        String x = i.split("-")[0];
        _tiresizproducts.add(x);
      }
    } else {
      print("digrermi truee" +
          widget.otheruserinfo.urunlerterzi.length.toString());
      for (var i in widget.otheruserinfo.urunlerterzi) {
        String x = i.split("-")[0];
        _tiresizproducts.add(x);
      }
    }

    setState(() {});
  }

  Map<String, bool> _valuesproducts = {
    'Elbise': false,
    'Pantalon': false,
    'Kazak': false,
    'Tişört': false,
    'Ceket': false,
    'Etek': false,
    'Gömlek': false,
    'Şal': false,
    'Şort': false,
    'Eşorfman': false,
  };
  String _selectedProduct = "";
  var _tmpArray = [];
  var _tmpArrayprice = [];
  List<String> _tmpArrayconcat = [];
  getCheckboxItemsproduct() {
    _tmpArray.clear();
    _valuesproducts.forEach((key, value) {
      if (value == true) {
        _tmpArray.add(key);
      }
    });
  }

  Map<String, bool> _valueskumas = {
    'Deri': false,
    'Triko': false,
    'Saten': false,
    'El Örgüsü': false,
    'Diğer': false,
  };
  List<String> _tmpArray1 = [];
  getCheckboxItemskumas() {
    _tmpArray1.clear();

    _valueskumas.forEach((key, value) {
      if (value == true) {
        _tmpArray1.add(key);
      }
    });

  }

  Map<String, bool> _valuessex = {
    'Kadınlar için': false,
    'Erkekler için': false,
  };
  var _tmpArraysex = [];
  getcheckboxsex() {
    _tmpArraysex.clear();
    _valuessex.forEach((key, value) {
      if (value == true) {
        _tmpArraysex.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /* onWillPop: () {
        return showDialog(
            context: context,
            builder: (_) {
              return uyaridia(); //kumasdia(); //KumasDialog();
            }).whenComplete(() {
          Navigator.of(context).pop();
        });
      },*/
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: new Text(
              "Yetkinlikler",
              style: TextStyle(color: anayazi),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingAll),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 12 / 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PreferredSize(
                      preferredSize:
                          Size(MediaQuery.of(context).size.width, 10),
                      child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        labelColor: kPrimaryColor,
                        tabs: [
                          Tab(
                            text: 'Dikim',
                          ),
                        ],
                        controller: _tabControllerbirli,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: kPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: BoxShadowContainer(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                // color: Colors.red,
                                                //   height: 70,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 8, 8, 8),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Diktiği Ürünler",
                                                            style: TextStyle(
                                                                color:
                                                                    yetkinliklergrisi,
                                                                fontSize: AppSize
                                                                    .smallsize),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            _editproduct
                                                                ? _tmpArray
                                                                    .join(" ")
                                                                : _tiresizproducts
                                                                    .join(" "),
                                                            style: TextStyle(
                                                                fontSize: AppSize
                                                                    .smallsize,
                                                                color:
                                                                    kPrimaryColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                            top: 8,
                                            right: 0,
                                            child: widget.isother
                                                ? SizedBox()
                                                : IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: kPrimaryColor,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CompetenceUpdate(
                                                                    Sabit.user
                                                                        .id,
                                                                    true)),
                                                      );
                                                    }),
                                          )
                                        ],
                                        //   alignment: Alignment.topRight,
                                      ),
                                      Stack(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: BoxShadowContainer(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                // color: Colors.red,
                                                //   height: 70,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 8, 8, 8),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Diktiği Kumaşlar",
                                                          style: TextStyle(
                                                              color:
                                                                  yetkinliklergrisi,
                                                              fontSize: AppSize
                                                                  .smallsize),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          _editkumas
                                                              ? _tmpArray1
                                                                  .join(" ")
                                                              : widget.isother
                                                                  ? widget
                                                                      .otheruserinfo
                                                                      .ayrintilarterzi
                                                                      .join(" ")
                                                                  : Sabit.user
                                                                      .ayrintilarterzi
                                                                      .join(
                                                                          " "),
                                                          style: TextStyle(
                                                              fontSize: AppSize
                                                                  .smallsize,
                                                              color:
                                                                  kPrimaryColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //    ),
                                                ),
                                              )),
                                          Positioned(
                                            top: 8,
                                            right: 0,
                                            child: widget.isother
                                                ? SizedBox()
                                                : IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: kPrimaryColor,
                                                    ),
                                                    onPressed: () {
                                                      print("dd");
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CompetenceUpdate(
                                                                    Sabit.user
                                                                        .id,
                                                                    true)),
                                                      );
                                                    }),
                                          )
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: BoxShadowContainer(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                // color: Colors.red,
                                                //   height: 70,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 8, 8, 8),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Ürünlerin minimum dikim fiyatları ",
                                                          style: TextStyle(
                                                              color:
                                                                  yetkinliklergrisi,
                                                              fontSize: AppSize
                                                                  .smallsize),
                                                        ),

                                                        SizedBox(
                                                          height: 100,
                                                          child: ListView.builder(
                                                              itemCount: _editprice
                                                                  ? _tmpArrayconcat.length
                                                                  : widget.isother
                                                                      ? widget.otheruserinfo.urunlerterzi.length
                                                                      : Sabit.user.urunlerterzi.length,
                                                              itemBuilder: (BuildContext context, int index) {
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          16.0),
                                                                  child: Text(
                                                                    _editprice
                                                                        ? _tmpArrayconcat[
                                                                            index]
                                                                        : widget.isother
                                                                            ? widget.otheruserinfo.urunlerterzi[index]
                                                                            : Sabit.user.urunlerterzi[index],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            AppSize
                                                                                .smallsize,
                                                                        color:
                                                                            kPrimaryColor),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                            top: 8,
                                            right: 0,
                                            child: widget.isother
                                                ? SizedBox()
                                                : IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: kPrimaryColor,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CompetenceUpdate(
                                                                    Sabit.user
                                                                        .id,
                                                                    true)),
                                                      );
                                                    }),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                        controller: _tabControllerbirli,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget dialogsex() {
    print("cins widgetddaa");
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            "Kimler için tasarlıyorsun",
            style: TextStyle(fontSize: 14),
          ),
        ),
        content: Container(
          //  color: _c,
          height: 120.0,
          width: 100.0,
          child: ListView(
            //   itemExtent: 60,
            children: _valuessex.keys.map((String key) {
              return Column(
                children: [
                  new CheckboxListTile(
                    title: new Text(
                      key,
                      style: TextStyle(fontSize: AppSize.smallsize),
                    ),
                    value: _valuessex[key],
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      _valuessex[key] = value;
                      getcheckboxsex();

                      setState(() {
                      });
                    },
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Tamamla'),
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget productdialog() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            "Neler tasarlayabiliyorsun",
            style: TextStyle(fontSize: 14),
          ),
        ),
        content: Container(
          //  color: _c,
          height: 320.0,
          width: 100.0,
          child: ListView(
            //   itemExtent: 60,
            children: _valuesproducts.keys.map((String key) {
              return Column(
                children: [
                  new CheckboxListTile(
                    title: new Text(
                      key,
                      style: TextStyle(fontSize: AppSize.smallsize),
                    ),
                    value: _valuesproducts[key],
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      _valuesproducts[key] = value;
                      getCheckboxItemsproduct();

                      setState(() {
                      });
                    },
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Tamamla'),
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _editproduct = true;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget kumasdialog() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            "Neler tasarlayabiliyorsunn",
            style: TextStyle(fontSize: 14),
          ),
        ),
        content: Container(
          //  color: _c,
          height: 320.0,
          width: 100.0,
          child: ListView(
            //   itemExtent: 60,
            children: _valueskumas.keys.map((String key) {
              return Column(
                children: [
                  new CheckboxListTile(
                    title: new Text(
                      key,
                      style: TextStyle(fontSize: AppSize.smallsize),
                    ),
                    value: _valueskumas[key],
                    activeColor: kPrimaryColor,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      _valueskumas[key] = value;
                      getCheckboxItemskumas();
                      setState(() {
                      });
                    },
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Tamamla'),
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _editkumas = true;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget pricedialog() {
    _tmpArrayprice.clear();
    _tmpArrayconcat.clear();
    _valuesproducts.forEach((key, value) {
      if (value == true) {
        _tmpArrayprice.add(key);
        _tmpArrayconcat.add(key);
      }
    });
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            "Yaptığın her bir dikim için Biçtiğin ortalama\nfiyatlar nedir?\n(Kumaş fiyatları dahil)",
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        content: Container(
          //  color: _c,
          height: 320.0,
          width: 100.0,

          child: ListView(
              //   itemExtent: 60,
              children: _tmpArrayprice.map((e) {
            print(e);
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: e, hintText: e),
                  onChanged: (s) {
                    int ind = _tmpArrayprice.indexOf(e);
                    if (int.tryParse(s) != null) {
                      String y = _tmpArrayconcat[ind].split("-")[0];
                      _tmpArrayconcat[ind] = y + "-" + s;
                    }
                  },
                ),
                Divider(
                  thickness: 1,
                )
              ],
            );
          }).toList()),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Tamamla'),
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _editprice = true;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget uyaridialognonprice() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Center(
          child: Text(
            "Uyarı",
            style: TextStyle(fontSize: 14),
          ),
        ),
        content: Container(
            //  color: _c,
            height: 140.0,
            width: 100.0,
            child: Text(
                "Yaptığın değişiklikleri kaydetmek için uygun ürüne uygun fiyat girmelisin")),
        actions: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Tamam'),
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
