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
import 'package:dikimall/models/Order.dart';
import 'package:dikimall/models/User.dart';
import 'package:flutter/material.dart';

abstract class IAPIService {
  Future<String> sendPhoto(Uint8List h);
  Future<User> getList();
  Future hasEvaluationTailor(String username, String orderid);
  Future hasEvaluationDesigner(String username, String orderid);
  Future<List<PostElement>> getPostSearch(String query);
  Future<OrderData> getOrderId(String orderid);

}
