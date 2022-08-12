import 'package:dikimall/models/Post.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/services/APIServices.dart';
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum PostViewState { Idle, Loaded, Busy }

class PostProvider with ChangeNotifier {
  List<PostElement> _Posts = [];

  List<PostElement> get Posts => _Posts;
  PostViewState _state = PostViewState.Idle;

  PostViewState get state => _state;

  set state(PostViewState value) {
    _state = value;
    notifyListeners();
  }

  IAPIService apiservice = locator<APIServices>();
  void initpost(List<PostElement> posts) {
    state = PostViewState.Busy;
    _Posts = posts;
    state = PostViewState.Loaded;
  }

  void clearpost() {
    state = PostViewState.Busy;
    _Posts.clear();
    state = PostViewState.Loaded;
  }

  void addpost(PostElement ilan) {

    state = PostViewState.Busy;
    _Posts.add(ilan);
    state = PostViewState.Loaded;
  }

  Future<void> addallpost(//List<PostElement> ilanlar
      ) async {
    state = PostViewState.Busy;
    List<PostElement> posts = await apiservice.postgetbyId(Sabit.user.id);
    _Posts.addAll(posts);
    state = PostViewState.Loaded;
  }
}
