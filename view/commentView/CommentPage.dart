import 'package:cached_network_image/cached_network_image.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/models/Feed.dart';
import 'package:dikimall/models/Post.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/utils/locator.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dikimall/services/IAPIServices.dart';

class CommentPage extends StatefulWidget {
  final FeedElement post;
  const CommentPage(this.post);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _contcomment;
  IAPIService _apiservice = locator<APIServices>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contcomment = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contcomment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: new Text(
            "Yorumlar",
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSize.paddingAll),
          child: Column(
            children: [
              BoxShadowContainer(
                child: Center(
                  child: ListTile(
                    minLeadingWidth: 5,
                    leading: CircleAvatar(
                      radius: AppSize.avatarRadius,
                      backgroundImage:
                          CachedNetworkImageProvider(widget.post.userphoto),
                      backgroundColor: Colors.transparent,
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: widget.post.username,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: " ",
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(
                              text: widget.post.post.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: anayazi)),
                        ],
                      ),
                    ),
                  ),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder //.separated
                    (
                        /* separatorBuilder: (context, index) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Divider());
                    },*/
                        itemCount: widget.post.post.comments.length,
                        itemBuilder: (context, index) {
                          Comment com = widget.post.post.comments[index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListTile(
                                  minLeadingWidth: 5,
                                  leading: CircleAvatar(
                                    radius: AppSize.miniavatarRadius,
                                    backgroundImage: CachedNetworkImageProvider(
                                        com.photo), //('https://via.placeholder.com/150'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title: RichText(
                                    text: TextSpan(
                                      text: com.username,
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: " ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal)),
                                        TextSpan(
                                            text: com.comment,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: anayazi)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Divider(
                                    thickness: 1,
                                  ))
                            ],
                          );
                        }),
              ),
              Divider(color: golge //Colors.grey,
                  ),
              SizedBox(
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.paddingAll),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: AppSize.avatarRadius,
                        backgroundImage:
                            CachedNetworkImageProvider(Sabit.user.profileImage),
                        backgroundColor: Colors.transparent,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: 30,
                            child: TextField(
                              controller: _contcomment,
                              decoration: new InputDecoration(
                                isDense: true,
                                //  contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 8),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(48)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(48)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(48)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(48)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                hintText: "Yorum Yap",
                                hintStyle: TextStyle(
                                    fontSize: AppSize.hintsize,
                                    color: Color(0xFFB3B1B1)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          height: 30,
                          //width: 30,
                          child: InkWell(
                            onTap: () async {
                              try {
                                await EasyLoading.show(
                                  status: 'Lütfen Bekleyiniz...',
                                  maskType: EasyLoadingMaskType.black,
                                );
                                await _apiservice.postComment(
                                    widget.post.post.id,
                                    Sabit.user.id,
                                    _contcomment.text,
                                    DateTime.now().toString(),
                                    Sabit.user.username,
                                    Sabit.user.profileImage);
                                setState(() {
                                  widget.post.post.comments.add(Comment(
                                      comment: _contcomment.text,
                                      commentedAt: DateTime.now().toString(),
                                      username: Sabit.user.username,
                                      userId: Sabit.user.id,
                                      photo: Sabit.user.profileImage));
                                  _contcomment.clear();
                                });
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Hata var' + e.toString())),
                                );
                              } finally {
                                EasyLoading.dismiss();
                              }
                            },
                            child: Center(
                                child: Icon(
                              Icons.send,
                              color: kPrimaryColor,
                              size: AppSize.ultraIconsize,
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
