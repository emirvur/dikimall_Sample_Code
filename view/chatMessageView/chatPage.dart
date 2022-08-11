mport 'package:cached_network_image/cached_network_image.dart';
import 'package:dikimall/Widgets/receivedMessageWidget.dart' as RC;
import 'package:dikimall/Widgets/sendedMessageWidget.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/enums/userType.dart';
import 'package:dikimall/models/Chat.dart';
import 'package:dikimall/models/Message.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/utils/locator.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/utils/zoomphototest.dart';
import 'package:dikimall/view/designerView/designerIlan.dart';
import 'package:dikimall/view/ilanView/IlanList.dart';
import 'package:dikimall/view/tailorView/TerziIlan.dart';
import 'package:dikimall/widgets/receivedMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:easy_localization/easy_localization.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dikimall/services/IAPIServices.dart';

class ChatPageView extends StatefulWidget {
  final Chat chat;

  const ChatPageView(this.chat);

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  TextEditingController _text = new TextEditingController();
  ScrollController _scrollController;
  var _childsocketList = <Widget>[];
  List<Widget> _childListapi = <Widget>[];
  IO.Socket _socket;
  ValueNotifier<int> _buttonClickedTimes = ValueNotifier(0);
  bool _isnochat = false;
  bool _buttondisabled = false;
  List<Messagefortime> _messagefortimelist = [];
  IAPIService _apiservice = locator<APIServices>();
  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uyarı'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Seçmiş olduğunuz üretici hem terzi hem de tasarımcı'),
                Text('Hangi seçenek için teklif yapmak istiyorsunuz? '),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Terzi için'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TerziIlan(
                            false,
                            true,
                            kimdenId: Sabit.user.id,
                            kimeId: widget.chat.digerkulid,
                            kimead: widget.chat.ad,
                          )),
                );
              },
            ),
            TextButton(
              child: const Text('Tasarım için'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DesignerIlan(
                            false,
                            true,
                            fromId: Sabit.user.id,
                            toId: widget.chat.digerkulid,
                            toname: widget.chat.ad,
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.chat.id != "-1") {
      print("-1 degilmiss");
      _apiservice.getMessage(widget.chat.id).then((value) {
        for (var i in value) {}
        for (var i = 0; i < value.length; i++) {
          Messagefortime m = Messagefortime(
              value[i]["from"],
              value[i]["to"],
              value[i]["message"],
              value[i]["sendAt"].toString().substring(0, 10),
              value[i]["sendAt"].toString().substring(11, 16));
          _messagefortimelist.add(m);
        }
        setState(() {

          _scrollDown();
        });
      });
    } else {
      _isnochat = true;
      print("elsete");
    }
    _socket = IO.io(
        APIServices.site, //<String, dynamic>{
        //   "transports": ["websocket"], "autoConnect": false  }
        OptionBuilder()
            .setTransports(['websocket'])

            //add this line
            .enableForceNewConnection() // necessary because otherwise it would reuse old connection
            //  .disableAutoConnect()
            .build()); //('http://192.168.1.104:5000');
    _socket.onConnect((_) {
      print('cconnect clientt');
      print(_socket.id);
      _socket.emit('kayit', "${Sabit.user.username}-${widget.chat.ad}");
      _socket.on('msg', (data) {
        _childsocketList.add(Align(
          alignment: Alignment(-1, 0),
          child: ReceivedMessageWidget(
            content: data,
            time: "${DateTime.now().hour}:${DateTime.now().minute}",
            isImage: false,
          ),
        ));
        setState(() {});
      });
      _socket.on('private', (data) {
        print("privatteea" + data);
        _buttonClickedTimes.value = _buttonClickedTimes.value + 1;
        _childsocketList.add(Align(
          alignment: Alignment(-1, 0),
          child: ReceivedMessageWidget(
            content: data,
            time: "${DateTime.now().hour}:${DateTime.now().minute}",
            isImage: false,
          ),
        ));
        //  _scrollDown();
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      });

    });
    _socket.on('event', (data) => print(data));
    _socket.onDisconnect((_) => print('disconnect clientt'));
    _socket.on('fromServer', (_) => print(_));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // buttonClickedTimes.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 65,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {
                                  _socket
                                      .ondisconnect(); //bu uzunlugu azaltıyor
                                  Navigator.pop(context);
                                },
                              ),
                              CircleAvatar(
                                radius: AppSize.avatarRadius,
                                backgroundImage: CachedNetworkImageProvider(
                                    widget.chat.profile),
                                backgroundColor: Colors.transparent,
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.chat.ad,
                                style: TextStyle(fontSize: 15),
                              ),
                              /*Text(
                                "online",
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 12),
                              ),*/
                            ],
                          ),
                          Spacer(),
                          Sabit.user.role ==
                                  UserTypeHelper.getValue(UserType.USER)
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 12.0, 0.0),
                                  child: InkWell(
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return uyaridia(); //kumasdia(); //KumasDialog();
                                          });
                                    },
                                    child: Text(
                                      "teklifver".tr(),
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 14),
                                    ),
                                  ))
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.grey.shade200,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.grey.shade200,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSize.paddingAll),
                        child: SingleChildScrollView(
                            controller: _scrollController,
                            reverse: true,
                            //   reverse: true,
                            child: Column(
                              children: [
                                GroupedListView<dynamic, String>(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  elements: _messagefortimelist,
                                  groupBy: (element) => element.sendAt,
                                  groupSeparatorBuilder: (String value) =>
                                      SizedBox(
                                    height: 30,
                                    child: Center(
                                      child: Card(
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: Text(
                                            tarihconvert(value),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (c, element) {
                                    return Align(
                                      alignment: element.from == Sabit.user.id
                                          ? Alignment(1, 0)
                                          : Alignment(-1, 0),
                                      child: element.from == Sabit.user.id
                                          ? SendedMessageWidget(
                                              content: element.message,
                                              time: element.sendAttime,
                                              isImage: false,
                                            )
                                          : ReceivedMessageWidget(
                                              content: element.message,
                                              time: element.sendAttime,
                                              isImage: false,
                                            ),
                                    );
                                  },
                                ),

                                ValueListenableBuilder(
                                    valueListenable: _buttonClickedTimes,
                                    builder: (BuildContext context,
                                        int counterValue, Widget child) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: _childsocketList,
                                      );
                                    })
                              ],
                            )),
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.black26),
                  Container(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        maxLines: 20,
                        controller: _text,
                        decoration: InputDecoration(
                          suffixIcon: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () async {
                                  if (_text.text.length == 0) {
                                    print("boss");
                                    return -1;
                                  }
                                  bool kullanicimi = Sabit.user.username
                                              .compareTo(widget.chat.ad) ==
                                          1
                                      ? true
                                      : false;
                                  if (_isnochat) {
                                    print(kullanicimi.toString() + "wqwq");
                                    await _apiservice.createChat(
                                        kullanicimi
                                            ? Sabit.user.id
                                            : widget.chat.digerkulid,
                                        !kullanicimi
                                            ? Sabit.user.id
                                            : widget.chat.digerkulid,
                                        "lastme",
                                        kullanicimi
                                            ? Sabit.user.username
                                            : widget.chat.ad,
                                        !kullanicimi
                                            ? Sabit.user.username
                                            : widget.chat.ad,
                                        Sabit.user.username.compareTo(
                                                    widget.chat.ad) ==
                                                1
                                            ? Sabit.user.username +
                                                "-" +
                                                widget.chat.ad
                                            : widget.chat.ad +
                                                "-" +
                                                Sabit.user.username);
                                    _isnochat = false;
                                  } else {
                                    print("chat varmis");
                                  }
                                  /*    var map = {
                                    "ad": Sabit.user.role == "Kullanici"
                                        ? "${Sabit.user.username}-${widget.chat.ad}"
                                        : "${widget.chat.ad}-${Sabit.user.username}",
                                    "mesaj": _text.text
                                  };*/
                                  var map = {
                                    "ad":
                                        "${widget.chat.ad}-${Sabit.user.username}",
                                    "mesaj": _text.text
                                  };
                                  _socket.emit('msg', map);

                                  _apiservice.sendMessage(
                                      Sabit.user.username
                                                  .compareTo(widget.chat.ad) ==
                                              1
                                          ? Sabit.user.username +
                                              "-" +
                                              widget.chat.ad
                                          : widget.chat.ad +
                                              "-" +
                                              Sabit.user
                                                  .username, //widget.chat.id,
                                      Sabit.user.id,
                                      widget.chat.digerkulid,
                                      _text.text,
                                      DateTime.now().toString());

                                  _childsocketList.add(Align(
                                    alignment: Alignment(1, 0),
                                    child: SendedMessageWidget(
                                      content: _text.text,
                                      time:
                                          "${DateTime.now().hour}:${DateTime.now().minute}",
                                      isImage: false,
                                    ),
                                  ));
                                  //  _scrollDown();
                                  _scrollController.animateTo(
                                    _scrollController.position.minScrollExtent,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                  _text.clear();
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.image,
                                  color: kPrimaryColor,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          border: InputBorder.none,
                          hintText: "",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget uyaridia() {
    return AlertDialog(
      /* title: Center(
        child: Text(
          "",
          style: TextStyle(fontSize: 14),
        ),
      ),*/
      content: Container(
          //  color: _c,
          height: 100.0,
          width: 100.0,
          child: Text(
              "Üreticiye yeni bir teklif mi vermek istersin yoksa aktif ilanlarından birini mi teklif edersin?")),
      actions: <Widget>[
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //  margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text('Yeni Teklif'),
              color: kPrimaryColor,
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                UserData x =
                    await _apiservice.getIdwithUser(widget.chat.digerkulid);
                if (x.role.startsWith("Hem")) {
                  _showMyDialog();
                } else if (x.role == UserTypeHelper.getValue(UserType.TAILOR)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TerziIlan(
                              false,
                              true,
                              kimdenId: Sabit.user.id,
                              kimeId: widget.chat.digerkulid,
                              kimead: widget.chat.ad,
                            )),
                  );
                } else if (x.role ==
                    UserTypeHelper.getValue(UserType.DESIGNER)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DesignerIlan(
                              false,
                              true,
                              fromId: Sabit.user.id,
                              toId: widget.chat.digerkulid,
                              toname: widget.chat.ad,
                            )),
                  );
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
              child: Text('Aktif İlanlardan Seç'),
              color: kPrimaryColor,
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                UserData x =
                    await _apiservice.getIdwithUser(widget.chat.digerkulid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IlanList(
                          x.role.startsWith("Hem") == true
                              ? 3
                              : x.role ==
                                      UserTypeHelper.getValue(UserType.TAILOR)
                                  ? 1
                                  : 2,
                          widget.chat.digerkulid,
                          widget.chat.ad)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
