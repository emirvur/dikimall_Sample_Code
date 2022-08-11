import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/Chat.dart';
import 'package:dikimall/models/Feed.dart';
import 'package:dikimall/models/Post.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/models/ureticiIlan.dart';
import 'package:dikimall/provider/feedviewmodel.dart';
import 'package:dikimall/provider/languageprovider.dart';
import 'package:dikimall/provider/postviewmodel.dart';
import 'package:dikimall/provider/profileviewmodel.dart';
import 'package:dikimall/services/APIServices.dart';

import 'package:dikimall/trashes/test.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/utils/zoomphotoscreen.dart';
import 'package:dikimall/utils/zoomphototest.dart';
import 'package:dikimall/view/chatMessageView/chatPage.dart';
import 'package:dikimall/view/feedView/detailpostscreen.dart';
import 'package:dikimall/view/ilanView/ilanDetail.dart';
import 'package:dikimall/view/measurementsView/bedenolculeriopsiyonlist.dart';
import 'package:dikimall/view/measurementsView/olcugenel.dart';
import 'package:dikimall/view/orderView/orderlist.dart';
import 'package:dikimall/view/otherView/FavouritesList.dart';
import 'package:dikimall/view/otherView/TakipciListesi.dart';
import 'package:dikimall/view/otherView/Welcome.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:dikimall/widgets/postItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';

import 'editProfile.dart';

class ProfilePageClient extends StatefulWidget {
  final bool ismyself;
  final String idsi;
  const ProfilePageClient(this.ismyself, {this.idsi});

  @override
  _ProfilePageClientState createState() => _ProfilePageClientState();
}

class _ProfilePageClientState extends State<ProfilePageClient>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  UserData infoclient;
  bool isloading = true;
  bool isfollowers = false;
  List<PostElement> postlist = [];
  IAPIService apiservice = locator<APIServices>();
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    try {
      if (widget.ismyself == false) {
        apiservice.getIdwithUser(widget.idsi).then((value) {
          infoclient = value;
          apiservice.postgetbyId(infoclient.id).then((value) {
            postlist = value;

            setState(() {
              isloading = false;

              isfollowers = Sabit.user.followinglist.contains(infoclient.id);
            });
          });
        });
      } else {
        context.read<PostProvider>().addallpost();
        setState(() {
          isloading = false;
        });

      }

    } catch (e) {
      setState(() {
        isloading = false;
      });
    }
  }

  Widget uyaridia(Ilan i) {
    print("cins widgetddaa");
    return AlertDialog(
      title: Center(
        child: Text(
          "Uyarı",
          style: TextStyle(fontSize: 14),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.exclamationCircle,
            color: kPrimaryColor,
            size: 48,
          ),
          SizedBox(
            height: 40,
          ),
          Container(

              child: Text("İlanınız yayından kaldırılacaktır emin misiniz?")),
        ],
      ),
      actions: <Widget>[
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text('Evet'),
              color: kPrimaryColor,
              textColor: Colors.white,
              onPressed: () async {
                try {
                  await EasyLoading.show(
                    status: 'Giriş Yapılıyor...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  await apiservice.updateIlanStatus(Sabit.user.id, i.id, -1);
                  Provider.of<UserDataProvider>(context, listen: false)
                      .updateilan(i);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("İlanınız başarıyla kaldırıldı")),
                  );
                  EasyLoading.dismiss();
                  Navigator.of(context, rootNavigator: true).pop();
                } catch (e) {
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Hata var' + e.toString())),
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text('İptal'),
              color: kPrimaryColor,
              textColor: Colors.white,
              onPressed: () {
                //  Navigator.of(context).pop();
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ),
        ),
      ],
    );
  }

  void _presentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          SizedBox(height: 8),
          _buildBottomSheetRow(context, Icons.edit, 'Profil Düzenle', () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfile(Sabit.user.bio ?? "")),
            ).then((value) {
              setState(() {
              });
            });
          }),
          _buildBottomSheetRow(
              context, FontAwesomeIcons.angleLeft, 'Beden Ölçülerim', () {
            Navigator.of(context).pop();
            if (Sabit.user.olculer.length != 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Olcugenel()),
              ).then((value) {
                setState(() {
                });
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Bedenolculeriopsiyonlist()),
              ).then((value) {
                setState(() {
                });
              });
            }
          }),
          _buildBottomSheetRow(
              context, FontAwesomeIcons.firstOrder, 'Siparişlerim', () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderList(Sabit.user.id)),
            ).then((value) {
              setState(() {
              });
            });
          }),
          _buildBottomSheetRow(context, Icons.bookmark, 'Kaydettiklerim', () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavouriteList()),
            );
          }),
          _buildBottomSheetRow(context, Icons.logout, 'Çıkış Yap', () {
            Navigator.of(context).pop();
            Provider.of<UserDataProvider>(context, listen: false).clearuser();
            Provider.of<PostProvider>(context, listen: false).clearpost();
            Provider.of<FeedProvider>(context, listen: false).clearFeed();
            SharedPreferences.getInstance().then((prefs) async {
              await prefs.setBool('rememberMe', false);
              await prefs.setBool('isgoogle', false);
              print("yy");
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Welcome()));

            });

          }),
        ],
      ),
    );
  }

  Widget _buildBottomSheetRow(
          BuildContext context, IconData icon, String text, Function func) =>
      InkWell(
        onTap: () {
          func();
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(icon, color: kPrimaryColor //Colors.grey[700],
                  ),
            ),
            SizedBox(width: 8),
            Text(text),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return isloading == true
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: widget.ismyself ? false : true,
              centerTitle: true,
              actions: [
                if (widget.ismyself)
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: InkWell(
                      onTap: () {
                        _presentBottomSheet(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.ellipsisV,
                        color: kPrimaryColor,
                        size: 18,
                      ),
                    ),
                  )
              ],
              title: new Text(
                widget.ismyself == false
                    ? infoclient.username
                    : Sabit.user.username,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return ZoomPhotoScreen(widget.ismyself
                                        ? Sabit.user.profileImage
                                        : infoclient.profileImage);
                                  }));
                                },
                                child: Hero(
                                  tag: 'imageHero',
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Center(child: Icon(Icons.error)),
                                    imageUrl: widget.ismyself
                                        ? Sabit.user.profileImage
                                        : infoclient
                                            .profileImage,
                                    fit: BoxFit.fill, height: 100.0,
                                    width: 100.0,
                                  ),
                                ),
                              ),
                            ),
                            // Text(""),
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 55 / 100,
                            height:
                                MediaQuery.of(context).size.height * 10 / 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //     mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 36.0),
                                      child: Column(
                                        children: [
                                          Consumer<UserDataProvider>(
                                              builder: (_, prov, child) {
                                            return Text(
                                              widget.ismyself
                                                  ? prov.UserDatas
                                                      .orderNumber //Sabit.user.orderNumber
                                                      .toString()
                                                  : infoclient.orderNumber
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            );
                                          }),
                                          Consumer<LanguageProvider>(
                                              builder: (_, prov, child) {
                                            return Text(
                                              "siparis".tr(),
                                              style: TextStyle(
                                                  fontSize: AppSize.smallsize,
                                                  color: anayazi),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TakipciListesi()),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.ismyself == false
                                                ? infoclient.followers
                                                    .toString()
                                                : Sabit.user.followers
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Consumer<LanguageProvider>(
                                              builder: (_, prov, child) {
                                            return Text(
                                              "takipci".tr(),
                                              style: TextStyle(
                                                  fontSize: AppSize.smallsize,
                                                  color: anayazi),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          widget.ismyself == false
                                              ? infoclient.followings.toString()
                                              : Sabit.user.followings
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: AppSize.smallsize,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Consumer<LanguageProvider>(
                                            builder: (_, prov, child) {
                                          return Text(
                                            "takip".tr(),
                                            style: TextStyle(
                                                fontSize: AppSize.smallsize,
                                                color: anayazi),
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.ismyself == false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            minWidth:
                                MediaQuery.of(context).size.width * 42 / 100,
                            child: Text(
                                isfollowers ? "Takipten Çık" : 'Takip Et',
                                style: TextStyle(fontSize: 12)),
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            onPressed: () async {
                              isfollowers
                                  ? await apiservice.addUnollow(
                                      infoclient.id, Sabit.user.id)
                                  : await apiservice.addFollow(
                                      infoclient.id, Sabit.user.id);
                              isfollowers
                                  ? await apiservice.notificationCreate(
                                      Sabit.user.id,
                                      infoclient.id,
                                      "Takipten çıkma",
                                      Sabit.user.username,
                                      infoclient.username,
                                      Sabit.user.username +
                                          " seni takipten çıktı",
                                      "2",
                                      infoclient.id)
                                  : await apiservice.notificationCreate(
                                      Sabit.user.id,
                                      infoclient.id,
                                      "Takip",
                                      Sabit.user.username,
                                      infoclient.username,
                                      Sabit.user.username + " seni takip etti",
                                      "1",
                                      infoclient.id);
                              isfollowers
                                  ? await apiservice.sendFcmToken(
                                      infoclient.token,
                                      "Takipten Çıkma",
                                      Sabit.user.username +
                                          " seni takipten çıktı")
                                  : await apiservice.sendFcmToken(
                                      infoclient.token,
                                      "Yeni Takipçi",
                                      Sabit.user.username + " seni takip etti");
                              setState(() {
                                isfollowers
                                    ? context
                                        .read<UserDataProvider>()
                                        .decfollowings()
                                    : context
                                        .read<UserDataProvider>()
                                        .incfollowings();
                                isfollowers
                                    ? infoclient.followers =
                                        infoclient.followers - 1
                                    : infoclient.followers =
                                        infoclient.followers + 1;
                                isfollowers
                                    ? Sabit.user.followinglist
                                        .remove(infoclient.id)
                                    : Sabit.user.followinglist
                                        .add(infoclient.id);
                                isfollowers = !isfollowers;
                              });
                            },
                          ),
                          FlatButton(
                            minWidth:
                                MediaQuery.of(context).size.width * 42 / 100,
                            child: Text(
                              'Mesaj Gönder',
                              style: TextStyle(fontSize: 12, color: anayazi),
                            ),
                            color: Colors.white,
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: kPrimaryColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                            onPressed: () async {
                              if (Sabit.user.id == infoclient.id) {
                                print("tol");
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Kendinle mesajlaşamazsın')),
                                );
                              }
                              Chat x = await apiservice.getchatFrombutton(
                                  Sabit.user.username
                                              .compareTo(infoclient.username) ==
                                          1
                                      ? Sabit.user.username +
                                          "-" +
                                          infoclient.username
                                      : infoclient.username +
                                          "-" +
                                          Sabit.user.username,
                                  1);
                              if (x.id == "-1") {
                                x.ad = infoclient.username;
                                x.digerkulid = infoclient.id;
                                x.profile = infoclient.profileImage;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPageView(x)),
                              );
                            },
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hakkında",
                            style: TextStyle(
                                fontSize: AppSize.smallsize,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            widget.ismyself == false
                                ? infoclient.bio ?? "Yok"
                                : Sabit.user.bio ?? "Yok",
                            style: TextStyle(fontSize: AppSize.smallsize),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
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
                                      text: widget.ismyself
                                          ? 'İlanlarım'
                                          : 'İlanlar',
                                    ),
                                    Tab(
                                      text: widget.ismyself
                                          ? 'Gönderilerim'
                                          : 'Gönderiler',
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
                                    Consumer<UserDataProvider>(
                                        builder: (_, prov, child) {
                                      return ListView.builder(
                                          itemCount: widget.ismyself == false
                                              ? infoclient.ilanlar.length
                                              : prov.UserDatas.ilanlar.length,
                                          itemBuilder: (context, item) {
                                            Ilan il = widget.ismyself == false
                                                ? infoclient.ilanlar[item]
                                                : prov.UserDatas.ilanlar[item];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: AppSize
                                                          .verticalPadding),
                                              child: BoxShadowContainer(
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      if (il.status != 1)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 8, 0),
                                                          child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              color:
                                                                  Colors.grey,
                                                              child: Text(
                                                                "İlan Yayından kaldırıldı",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                        ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                height: 150,
                                                                width: 100,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Center(
                                                                          child:
                                                                              Icon(Icons.error)),
                                                                  imageUrl: il
                                                                          .ilanfotolar[
                                                                      0], // "assets/ilanfoto.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      il.tur ==
                                                                              1
                                                                          ? "Terzi Arıyorum"
                                                                          : "Tasarımcı Arıyorum",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            kPrimaryColor,
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      "Ürün : ${il.urun}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppSize.smallsize,
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      il.tur ==
                                                                              1
                                                                          ? "Kumaş : ${il.ayrinti}"
                                                                          : "Tarz : ${il.ayrinti}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppSize.smallsize,
                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      "Bütçe : ${il.butce} TL",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppSize.smallsize,

                                                                      )),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                      "Teslim : ${il.teslim}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppSize.smallsize,
                                                                        //color:
                                                                        //      kPrimaryColor,
                                                                      )),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: FlatButton(
                                                              child: Text(widget
                                                                      .ismyself
                                                                  ? il.status ==
                                                                          1
                                                                      ? "İlanı Yayından Kaldır"
                                                                      : ""
                                                                  : 'Detayları Gör'),
                                                              color:
                                                                  kPrimaryColor,
                                                              textColor:
                                                                  Colors.white,
                                                              onPressed: () {
                                                                if (widget
                                                                    .ismyself) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) {
                                                                        return uyaridia(
                                                                            il); 
                                                                      });
                                                                } else {
                                                                  ureticiIlanData u = ureticiIlanData(
                                                                      aciklama: il
                                                                          .aciklama,
                                                                      cinsiyet: il
                                                                          .cinsiyet,
                                                                      ilanfotolar: il
                                                                          .ilanfotolar,
                                                                      teslim: il
                                                                          .teslim,
                                                                      tur: il
                                                                          .tur,
                                                                      ayrinti: il
                                                                          .ayrinti,
                                                                      urun: il
                                                                          .urun,
                                                                      uuidsi: il
                                                                          .uuidsi,
                                                                      fiyat: il
                                                                          .butce,
                                                                      id: il.id,
                                                                      asama: il
                                                                          .status
                                                                          .toString());

                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                IlanDetail(u)),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          });
                                    }),
                                    Consumer<PostProvider>(
                                        builder: (_, prov, child) {
                                      print("post prv refresh");
                                      return GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          crossAxisCount: 2,
                                        ),
                                        itemCount: widget.ismyself
                                            ? prov.Posts.length
                                            : postlist.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return DetailPostScreen(
                                                    widget.ismyself
                                                        ? prov.Posts[index]
                                                        : postlist[index],
                                                    index);
                                              }));
                                            },
                                            child: Hero(
                                              tag: "imageHero$index",
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Center(
                                                        child:
                                                            Icon(Icons.error)),
                                                imageUrl: widget.ismyself
                                                    ? prov.Posts[index].photo
                                                    : postlist[index].photo,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ],
                                  controller: _tabController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
