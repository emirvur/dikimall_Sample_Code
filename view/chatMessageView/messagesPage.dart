import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/notification.dart';
import 'package:dikimall/models/Chat.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/services/IAPIServices.dart';

import 'package:dikimall/utils/locator.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'chatPage.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Chat> _list = [];
  List<Chat> _searchlist = [];
  bool _isloading = true;
  bool _issearch = false;
  Timer _debounce;
  TextEditingController _cont = TextEditingController();
  IAPIService _apiservice = locator<APIServices>();
  _onSearchChanged(String query) {
    print("onearchdee");
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // do something with query
      //  aralist = list.where((e) => e.ad.startsWith(query)).toList();
      _issearch = true;
      _searchlist = await _apiservice.chatSearch(query, 1, Sabit.user.id);
      setState(() {
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiservice.chatGetList(Sabit.user.id, 1).then((value) {
      print(value.toString());
      _list = value;
      _isloading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    _apiservice.chatGetList(Sabit.user.id, 1).then((value) {
      _list = value;
      _isloading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: new Text(
          "mesajlarim".tr(),
          style: TextStyle(
            //  fontSize: 18,
            color: kPrimaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.envelopeOpen,
              color: kPrimaryColor,
              size: AppSize.grandeIconsize,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isloading == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          focusedBorder: new OutlineInputBorder(
                            //   borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: aragrisi // Colors.grey.shade200
                                ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: 'ara'.tr(),
                          hintStyle: TextStyle(
                              fontSize: AppSize.hintsize, color: Colors.grey)),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                        itemCount:
                            _issearch ? _searchlist.length : _list.length,
                        itemBuilder: (context, index) {
                          Chat ch =
                              _issearch ? _searchlist[index] : _list[index];
                          return Column(
                            children: [
                              SizedBox(
                                //      height: 40,
                                child: ListTile(
                                  //   minLeadingWidth: 5,
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatPageView(ch)),
                                    );
                                  },
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, right: 0.0),
                                  leading: CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: ch.profile
                                            .startsWith("default")
                                        ? CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child: Icon(Icons.error)),
                                            imageUrl:
                                                'https://picsum.photos/250?image=11')
                                        : CachedNetworkImageProvider(
                                            ch.profile),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title: Text(
                                    _list[index].ad,
                                    style: TextStyle(
                                        fontSize: AppSize.normalsize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    _list[index].lastmes.startsWith("buton")
                                        ? "Sipariş adımı"
                                        : _list[index].lastmes.length < 20
                                            ? _list[index].lastmes
                                            : _list[index]
                                                    .lastmes
                                                    .substring(0, 19) +
                                                "...", //  "lis[index].aciklama",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      Text(
                                        timeago.format(
                                            DateTime.tryParse(
                                                _list[index].lastmessendat),
                                            locale: 'tr'),
                                        style: TextStyle(fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
