import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:dikimall/models/notification.dart';
import 'package:dikimall/models/Chat.dart';
import 'package:dikimall/models/Feed.dart';
import 'package:dikimall/models/matchIlan.dart';
import 'package:dikimall/models/Message.dart';
import 'package:dikimall/models/Order.dart';
import 'package:dikimall/models/Post.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/models/ureticiIlan.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dikimall/services/IAPIServices.dart';

class APIServices extends IAPIService {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "apikey": "yourapikey",
  };
  static Map<String, String> headerfcm = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'yourfcmkey'
  };

  static String site = "http://192.168.1.110:5000";
  static String fotur = "$site/generatePresignedUrl";

  Future<String> sendPhoto(Uint8List h) async {
    String v;
    try {
      String base64Image = base64Encode(h);
      Uri uri = Uri.parse(fotur);
      var t = await http.post(uri,
          body: jsonEncode({
            'image': '$base64Image',
          }),
          headers: {"Content-Type": "application/json"});
      var re = json.decode(t.body);
      v = re["path"];
    } catch (e) {
      print(e.toString());
    }
    return v;
  }

  Future<User> getList() async {
    http.Response res = await http.get(Uri.parse("$site/api/users"));
    if (res.statusCode != 200) {
      throw Exception;
    }
    var re = json.decode(res.body);
    User x = User.fromJson(re);
    return x;
  }

  Future hasEvaluationTailor(String username, String orderid) async {
    http.Response res = await http.get(Uri.parse(
        "$site/api/users/hasdegerlendirmeterzi?username=$username&orderid=$orderid"));
    if (res.statusCode != 200) {
      throw Exception;
    }
    var re = json.decode(res.body);
    return re["success"];
  }

  Future hasEvaluationDesigner(String username, String orderid) async {
    http.Response res = await http.get(Uri.parse(
        "$site/api/users/hasdegerlendirmetasarimci?username=$username&orderid=$orderid"));
    if (res.statusCode != 200) {
      throw Exception;
    }
    var re = json.decode(res.body);

    return re["success"];
  }

  

  Future<OrderData> getOrderId(String orderid) async {
    http.Response res = await http.get(Uri.parse("$site/api/orders/$orderid"));
    if (res.statusCode != 200) {
      throw Exception;
    }
    var re = json.decode(res.body);
    OrderData x = OrderData.fromJson(re["message"]);
    return x;
  }

 

  Future<List<PostElement>> getPostSearch(String query) async {
    var maps = json.encode({"ara": query});
    http.Response res = await http.post(Uri.parse("$site/api/post/ara"),
        headers: header, body: maps);
    if (res.statusCode != 200) {
      throw Exception;
    }
    var re = json.decode(res.body);
    List<PostElement> li = [];
    for (var l in re["posts"]) {
      PostElement x = PostElement.fromJson(l);

      li.add(x);
    }
    return li;
  }

  

}
