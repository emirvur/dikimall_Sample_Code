import 'dart:io';

import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/photoUtils.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/Post.dart';
import 'package:dikimall/provider/feedviewmodel.dart';
import 'package:dikimall/provider/postviewmodel.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/view/otherView/Home.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flimer/flimer.dart' as fl;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';

class SharePost extends StatefulWidget {
  const SharePost({Key key}) : super(key: key);

  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  TextEditingController _contdescription;
  List<String> _foto = [];
  IAPIService _apiservice = locator<APIServices>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contdescription = TextEditingController();

  }

  List<ImageFile> _images = [];
  List<ImageFile> _imageOutputs = [];
  ImageFile _ornima;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: new Text(
          "paylas".tr(),
          style: TextStyle(color: anayazi),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text("Fotoğraf Ekleyiniz"),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSize.verticalPadding),
                      child: _images.length == 0
                          ? BoxShadowContainer(
                              height:
                                  //       (MediaQuery.of(context).size.height * 20) /   100,
                                  180,
                              width:
                                  //  MediaQuery.of(context).size.width * 43 / 100,
                                  180,
                              child: Center(
                                  child: InkWell(
                                onTap: () {

                                  PhotoUtils.handleOpenGallery()
                                      .then((value) async {
                                    _images = value;
                                    await EasyLoading.show(
                                      status: 'Lütfen Bekleyiniz...',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    EasyLoading.dismiss();
                                    setState(() {});
                                  });
                                },
                                child: Icon(
                                  FontAwesomeIcons.plus,
                                  color: kPrimaryColor,
                                ),
                              )))
                          : SizedBox(
                              height:
                                  //     (MediaQuery.of(context).size.height * 20) /  100,
                                  180,
                              width:
                                  //    MediaQuery.of(context).size.width * 43 / 100,
                                  180,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [

                                  BoxShadowContainer(
                                      height:
                                          (MediaQuery.of(context).size.height *
                                                  20) /
                                              100,
                                      width: MediaQuery.of(context).size.width *
                                          43 /
                                          100,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          child: Image.memory(
                                            _images[0].rawBytes,
                                            fit: BoxFit.fill,
                                          )) 
                                      ),

                                  Positioned(
                                      top: -10,
                                      right: -14,
                                      child: InkWell(
                                        onTap: () {
                                          PhotoUtils.handleOpenGallery()
                                              .then((value) {
                                            _images = value;
                                            setState(() {});
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: kPrimaryColor,
                                          radius: 16,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BoxShadowContainer(
                      height: 120,
                      child: TextField(
                        controller: _contdescription,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            //      hintMaxLines: 2,
                            hintText: 'Açıklama yazınız',
                            hintStyle: TextStyle(
                                fontSize: AppSize.smallsize,
                                color: Colors.grey)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          //   Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                child: Text('paylas'.tr()),
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    if (_contdescription.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Açıklama kısmı boş olamaz")),
                      );
                      return -1;
                    }
                    await EasyLoading.show(
                      status: 'Lütfen Bekleyiniz...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    _imageOutputs =
                        await PhotoUtils.handleCompressImage(_images);
                    String acikl = _contdescription.text;
                    List<String> urllist = [];
                    for (ImageFile i in _imageOutputs) {
                      String url = await _apiservice.sendPhoto(i.rawBytes);
                      print("url bu" + url);
                      urllist.add(url);
                    }
                    var idsi = await _apiservice.postShare(PostElement(
                        userId: Sabit.user.id,
                        postusername: Sabit.user.username,
                        description: acikl,
                        photo: urllist[0],
                        likeCount: 0));
                    context.read<PostProvider>().addpost(PostElement(
                        id: idsi,
                        userId: Sabit.user.id,
                        postusername: Sabit.user.username,
                        description: acikl,
                        photo: urllist[0],
                        likeCount: 0,
                        createdAt: DateTime.now().toString(),
                        comments: []));
                    Provider.of<FeedProvider>(context, listen: false).addFeed(
                        PostElement(
                            id: idsi,
                            username: Sabit.user.username,
                            usertype: Sabit.user.role,
                            userphoto: Sabit.user.profileImage,
                            userId: Sabit.user.id,
                            postusername: Sabit.user.username,
                            description: acikl,
                            photo: urllist[0],
                            likeCount: 0,
                            likes: [],
                            createdAt: DateTime.now().toString(),
                            comments: []));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Gönderiniz başarıyla paylaşıldı')));
                    _foto = [];
                    setState(() {
                      _images.clear();
                      _imageOutputs.clear();
                      _contdescription.clear();
                    });
                    HomeState.onItemTapped(0);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Hata var' + e.toString())),
                    );
                  } finally {
                    await EasyLoading.dismiss();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
