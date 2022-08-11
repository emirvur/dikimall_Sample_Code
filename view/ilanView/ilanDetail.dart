import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/Chat.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/models/ureticiIlan.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/utils/zoomphotoscreen.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/utils/zoomphototest.dart';
import 'package:dikimall/view/chatMessageView/chatPage.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';

class IlanDetail extends StatefulWidget {
  final ureticiIlanData ilan;
  const IlanDetail(this.ilan);

  @override
  _IlanDetailState createState() => _IlanDetailState();
}

class _IlanDetailState extends State<IlanDetail> {
  TextEditingController _contprice;
  IAPIService _apiservice = locator<APIServices>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contprice = TextEditingController(text: widget.ilan.fiyat.toString());
    getstatus();
  }

  getstatus() async {
    Ilan c = await _apiservice.getIlanUuidis(
        widget.ilan.ilansahibi.id, widget.ilan.uuidsi);
    print("qq");
    print(c.status.toString());
    if (c.status != 1) {
      print("iftee");
      showDialog(
          context: context,
          builder: (_) {
            return uyaridia(); //kumasdia(); //KumasDialog();
          });
    } else {
    }
  }

  Widget uyaridia() {
    print("cins widgetddaa");
    return AlertDialog(
      title: Center(
        child: Text(
          "Uyarı",
          style: TextStyle(fontSize: 14),
        ),
      ),
      content: Container(
          //  color: _c,
          height: 120.0,
          width: 100.0,
          child: Text("Bakmakta olduğunuz ilan yayından kaldırılmıştır.")),
      actions: <Widget>[
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text('Anladım'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("İlan Detayı"
            ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoxShadowContainer(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sipariş Detayları",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: AppSize.smallsize),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Dikilecek Ürün : ",
                                style: TextStyle(
                                  fontSize: AppSize.smallsize,
                                )),
                            Text(
                              widget.ilan.urun,
                              style: TextStyle(
                                  //color: kPrimaryColor,
                                  fontSize: AppSize.smallsize),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                widget.ilan.tur == 2
                                    ? "Tarz : "
                                    : "Kumaş Çeşidi : ",
                                style: TextStyle(
                                  fontSize: AppSize.smallsize,
                                )),
                            Text(
                              widget.ilan.ayrinti,
                              style: TextStyle(
                                  //color: kPrimaryColor,
                                  fontSize: AppSize.smallsize),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Teslim Süresi : ",
                                style: TextStyle(
                                  fontSize: AppSize.smallsize,
                                )),
                            Text(
                              widget.ilan.teslim,
                              style: TextStyle(
                                  //color: kPrimaryColor,
                                  fontSize: AppSize.smallsize),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Bütçe : ",
                                style: TextStyle(
                                  fontSize: AppSize.smallsize,
                                )),
                            Text(
                              widget.ilan.fiyat.toString(),
                              style: TextStyle(
                                  //color: kPrimaryColor,
                                  fontSize: AppSize.smallsize),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))),
          Padding(
            padding: const EdgeInsets.all(AppSize.paddingAll),
            child: BoxShadowContainer(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(AppSize.paddingAll),
                child: Column(
                  children: [
                    Text(
                      "Kullanıcı Mesajı",
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: AppSize.smallsize),
                    ),
                    Text(
                      widget.ilan.aciklama, //"aciklama",
                      style: TextStyle(fontSize: AppSize.smallsize),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.paddingAll),
            child: BoxShadowContainer(
              height: MediaQuery.of(context).size.height * 40 / 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Dikilmesi Beklenen Ürün Görseli",
                      style: TextStyle(
                          fontSize: AppSize.smallsize, color: kPrimaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.paddingAll),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 30 / 100,
                      //child: ClipRRect(
                      //    borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ZoomPhotoScreen(
                              widget.ilan.ilanfotolar[0],
                            );
                          }));
                        },
                        child: Hero(
                          tag: 'imageHero',
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            imageUrl: widget.ilan.ilanfotolar[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.paddingAll),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () async {
                  if (Sabit.user.id == widget.ilan.ilansahibi.id) {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kendinle mesajlaşamazsın')),
                    );
                  }
                  Chat x = await _apiservice.getchatFrombutton(
                      Sabit.user.username
                                  .compareTo(widget.ilan.ilansahibi.username) ==
                              1
                          ? Sabit.user.username +
                              "-" +
                              widget.ilan.ilansahibi.username
                          : widget.ilan.ilansahibi.username +
                              "-" +
                              Sabit.user.username,
                      1);
                  if (x.id == "-1") {
                    x.ad = widget.ilan.ilansahibi.username;
                    x.digerkulid = widget.ilan.ilansahibi.id;
                    x.profile = widget.ilan.ilansahibi.profileImage;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPageView(x)),
                  );
                },
                child: Text("Mesaj Gönder"),
                color: kPrimaryColor,
                textColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
