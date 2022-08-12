import 'package:dikimall/models/Feed.dart';
import 'package:dikimall/models/Post.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum FeedViewState { Idle, Loaded, Busy }

class FeedProvider with ChangeNotifier {
  IAPIService apiservice = locator<APIServices>();
  List<PostElement> _Feeds = [];

  List<PostElement> get Feeds => _Feeds;

  //final List<UserData> _myList = [];

  // List<UserData> get myList => _myList;
  FeedViewState _state = FeedViewState.Idle;

  FeedViewState get state => _state;

  set state(FeedViewState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> initFeed(//List<PostElement> Feeds
      ) async {
    state = FeedViewState.Busy;
    _Feeds = await apiservice.getPost("get");
    state = FeedViewState.Loaded;
  }

  void clearFeed() {
    state = FeedViewState.Busy;
    _Feeds.clear();
    state = FeedViewState.Loaded;
  }

  void addFeed(PostElement ilan) {
    state = FeedViewState.Busy;
    _Feeds.insert(0, ilan); // .add(ilan);
 
    state = FeedViewState.Loaded;
  }

  void addtumFeed(List<PostElement> ilanlar) {
    state = FeedViewState.Busy;
    _Feeds.addAll(ilanlar);
    state = FeedViewState.Loaded;
  }
}
