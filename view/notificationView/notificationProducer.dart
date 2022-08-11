import 'dart:async';

import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/notification.dart';
import 'package:dikimall/models/ureticiIlan.dart';
import 'package:dikimall/provider/languageprovider.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/utils/locator.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/view/approveView/approvePage.dart';
import 'package:dikimall/view/ilanView/ilanDetail.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dikimall/services/IAPIServices.dart';

class NotificationProducer extends StatefulWidget {
  const NotificationProducer({Key key}) : super(key: key);

  @override
  _NotificationProducerState createState() => _NotificationProducerState();
}

class _NotificationProducerState extends State<NotificationProducer>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  List<Notifications> _list = [];
  List<ureticiIlanData> _ilanlist = [];
  bool _isloading = true;
  Timer _debounce;
  bool _issearch = false;
  List<Notifications> _searchlist = [];
  TextEditingController _cont = TextEditingController();
  IAPIService _apiservice = locator<APIServices>();
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // do something with query
      _searchlist =
          await _apiservice.notificationSearch(Sabit.user.username, query);
      _issearch = true;
      setState(() {
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    print("111");
    _tabController = new TabController(length: 2, vsync: this);
    print("111");
    _apiservice.getureticilan(Sabit.user.id).then((value) {
      _ilanlist = value;
      _apiservice.getNotificationList(Sabit.user.id).then((value) {
        _list = value;
      });
    });
    _apiservice.getNotificationList(Sabit.user.id).then((value) {
      _list = value;
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _cont.dispose();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _apiservice.getNotificationList(Sabit.user.id).then((value) {
      _list = value;
      setState(() {
        _isloading = false;
      });
    });
  }

  Future<void> _pullRefreshIlan() async {
    await Future.delayed(Duration(seconds: 1));
    _apiservice.getureticilan(Sabit.user.id).then((value) {

      _ilanlist = value;
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Consumer<LanguageProvider>(builder: (_, prov, child) {
          return new Text(
            "bildirimler".tr(),
      
          );
        }),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isloading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSize.verticalPadding,
                    horizontal: AppSize.horizontalPadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 34,
                      child: TextField(
                        controller: _cont,
                        onChanged: _onSearchChanged,
                        //_onSearchChanged,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(2),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusColor: kPrimaryColor,
                            //    prefixIconConstraints: BoxConstraints(minWidth: 36),
                            prefixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _issearch = false;
                                  _cont.clear();
                                });
                              },
                              child: Icon(
                                _issearch ? Icons.close : Icons.search,
                                size: AppSize.iconsize,
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            focusedBorder: new OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: aragrisi // Colors.grey.shade200
                                  ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            hintText: 'ara'.tr(),
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSize.verticalPadding),
                      child: Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
 
                    PreferredSize(
                      preferredSize:
                          Size(MediaQuery.of(context).size.width, 10),
                      child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        labelColor: kPrimaryColor,
                        tabs: [
                          Consumer<LanguageProvider>(builder: (_, prov, child) {
                            return Tab(
                              text: "genelakis".tr(),
                            );
                          }),
                          /*    Tab(
                            text: 'Genel Akış',
                          ),*/
                          Consumer<LanguageProvider>(builder: (_, prov, child) {
                            return Tab(
                              text: "ilanlar".tr(),
                            );
                          }),
                        ],
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: kPrimaryColor,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 2 / 3,
                      child: TabBarView(controller: _tabController, children: [
                        RefreshIndicator(
                          onRefresh: _pullRefresh,
                          child: ListView.builder(
                            itemCount:
                                _issearch ? _searchlist.length : _list.length,
                            itemBuilder: (context, index) {
                              Notifications bild =
                                  _issearch ? _searchlist[index] : _list[index];

                              return _list.length == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 48.0),
                                      child: Center(
                                        child: Text("Henüz bildiriminiz yok"),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: bild.type == "6" ? 0 : 40,
                                          child: ListTile(
                                              dense: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 0.0, right: 0.0),
                                              title: Text(
                                                bild.content,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: anayazi),
                                              ),
                                              trailing: FlatButton(
                                                  color: kPrimaryColor,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    bild.type == "5"
                                                        ? _apiservice
                                                            .getOrderId(
                                                                bild.typeId)
                                                            .then((value) {
                                                            print(value);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ApprovePage(
                                                                          value)),
                                                            );
                                                          })
                                                        : () {};
                                                  },
                                                  child: bild.type == "5"
                                                      ? Text(
                                                          //bild.type == "5"
                                                          // ?
                                                          "Siparişe Git",
                                                          //   : " ",
                                                          style: TextStyle(
                                                              fontSize: AppSize
                                                                  .smallsize),
                                                        )
                                                      : Icon(bild.type == "1"
                                                          ? FontAwesomeIcons
                                                              .user
                                                          : FontAwesomeIcons
                                                              .user))),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                      ],
                                    );
                            },
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: _pullRefreshIlan,
                          child: ListView.builder(
                            itemCount: _ilanlist.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: ListTile(
                                        onTap: () {
                                        },
                                        dense: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        title: Text(
                                          _ilanlist[index].ilansahibi.username +
                                              " " +
                                              _ilanlist[index].urun +
                                              " " +
                                              "${_ilanlist[index].tur == 1 ? "diktirmek" : "tasarlatmak"}" +
                                              " istiyor",
                                          style: TextStyle(
                                              fontSize: AppSize.smallsize,
                                              color: anayazi),
                                        ),
                                        trailing: FlatButton(
                                            color: kPrimaryColor,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        IlanDetail(
                                                            _ilanlist[index])),
                                              );
                                            },
                                            child: Text(
                                              "İlanı Gör",
                                              style: TextStyle(
                                                  fontSize: AppSize.smallsize),
                                            ))),
                                  ),
                                  Divider(
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
