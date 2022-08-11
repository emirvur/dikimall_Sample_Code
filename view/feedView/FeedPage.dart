import 'dart:async';

import 'package:badges/badges.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/enums/userType.dart';
import 'package:dikimall/models/Feed.dart';
import 'package:dikimall/models/Post.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/provider/feedviewmodel.dart';
import 'package:dikimall/provider/languageprovider.dart';
import 'package:dikimall/provider/profileviewmodel.dart';
import 'package:dikimall/services/APIServices.dart';

import 'package:dikimall/utils/imagecropper.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/view/chatMessageView/messagesPage.dart';
import 'package:dikimall/view/competenceView/YetkinliklerKayitTerzi.dart';
import 'package:dikimall/view/competenceView/competenceSaveDesigner.dart';
import 'package:dikimall/view/otherView/SoruIlan.dart';
import 'package:dikimall/widgets/drawerWidget.dart';
import 'package:dikimall/widgets/postItem.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:auto_size_text/auto_size_text.dart';

import 'userSearch.dart';
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _issearch = false;
  List<PostElement> _searchlist = [];
  Timer _debounce;
  FocusNode _focus = FocusNode();
  TextEditingController _cont = TextEditingController();
  IAPIService _apiservice = locator<APIServices>();
  _onSearchChanged(String query) {
    print("onearchdee");
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // do something with query
      _searchlist = await _apiservice.getPostSearch(query);
      _issearch = true;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener(_onFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedProvider>().initFeed();
      if (Sabit.user.role == UserTypeHelper.getValue(UserType.TAILOR) &&
          Sabit.user.urunlerterzi.length == 0) {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return uyaridia(1);
            });
      } else if (Sabit.user.role ==
              UserTypeHelper.getValue(UserType.DESIGNER) &&
          Sabit.user.urunlertasarimci.length == 0) {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (_) {
              return uyaridia(2);
            });
      } else if (Sabit.user.role.startsWith("Hem")) {
        if (Sabit.user.urunlerterzi.length == 0) {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return uyaridia(1);
              });
        } else if (Sabit.user.urunlertasarimci.length == 0) {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return uyaridia(2);
              });
        }
      }
    });
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    Provider.of<FeedProvider>(context, listen: false).clearFeed();
    Provider.of<FeedProvider>(context, listen: false).initFeed();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    _cont.dispose();
    _focus.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");

    if (_focus.hasFocus) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Usersearch()));
      FocusScope.of(context).unfocus();
    }
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print("feedd build");
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 180,
        child: DrawerWidget(scaffoldKey: _scaffoldKey),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage()),
              );
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.envelope,
                      color: kPrimaryColor,
                      size: AppSize.grandeIconsize,
                    ),
                  ],
                )),
          ),
        ],
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.bars, color: kPrimaryColor, size: 18),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Container(
            height: 60,
            width: 120,
            child: Center(child: Image.asset("assets/logad.png"))),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: Hero(
              tag: "HeroOne",
              child: SizedBox(
                  height: 34,
                  child: Consumer<LanguageProvider>(builder: (_, prov, child) {
                    return TextField(
                      focusNode: _focus,
                      controller: _cont,
                      //  onChanged: //_onSearchChanged,
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
                              fontSize: AppSize.smallsize, color: Colors.grey)),
                    );
                  })),
            ),
          ),
          Consumer<FeedProvider>(builder: (_, prov, child) {
            return context.read<FeedProvider>().state == FeedViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount: _issearch
                              ? _searchlist.length
                              : prov.Feeds.length,
                          itemBuilder: (BuildContext context, int index) {
                            PostElement x = _issearch
                                ? _searchlist[index]
                                : prov.Feeds[index];
                            FeedElement c = FeedElement(
                                owner: x.userId,
                                post: x,
                                sendAt: x.createdAt,
                                comments: x.comments,
                                username: x.username,
                                userphoto: x.userphoto,
                                usertype: x.usertype);

                            PostItem post = PostItem(c);
                            return post;
                          },
                        )
                        //   })
                        ),
                  );
          })
        ],
      ),
    );
  }

  Widget uyaridia(int x) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        //contentPadding: EdgeInsets.symmetric(horizontal: 48),
        title: Icon(
          FontAwesomeIcons.exclamationCircle,
          color: kPrimaryColor,
          size: 48,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "UYARI",
                style: TextStyle(fontSize: 28),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
        
              child: Text(
                "Profilini tamamlamak için yetkinlik bilgilerini doldurmalısın.Profilimdeki yetkinlikler kısmında sonradan değiştirebilirsin",
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                  child: Text('Hemen doldur'),
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    Navigator.of(context).pop(1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => x == 1
                            ? YetkinliklerKayitTerzi(Sabit.user.id,
                                UserTypeHelper.getValue(UserType.TAILOR))
                            : CompetenceSaveDesigner(Sabit.user.id,
                                UserTypeHelper.getValue(UserType.DESIGNER)),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              //  margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Daha sonra'),
                color: Colors.white,
                textColor: kPrimaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                  //  Navigator.of(context).pop();
                  return -1;
                  //  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
