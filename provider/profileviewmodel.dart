import 'package:dikimall/models/User.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum UserDataViewState { Idle, Loaded, Busy }

class UserDataProvider with ChangeNotifier {
  UserData _UserDatas;

  UserData get UserDatas => _UserDatas;

  UserDataViewState _state = UserDataViewState.Idle;

  UserDataViewState get state => _state;

  set state(UserDataViewState value) {
    _state = value;
    notifyListeners();
  }

  set inituserdata(UserData value) {
    _UserDatas = value;
  }

  set clearuserdata(int x) {
    _UserDatas = null;
  }

 
  void inituser(UserData UserData) {
    state = UserDataViewState.Busy;
    inituserdata = UserData;
    state = UserDataViewState.Loaded;
  }

  void clearuser() {
    state = UserDataViewState.Busy;
    clearuserdata = 1;
    state = UserDataViewState.Loaded;
  }

  void addilan(Ilan ilan) {
    state = UserDataViewState.Busy;
    _UserDatas.ilanlar.insert(0, ilan); //.add(ilan);
    state = UserDataViewState.Loaded;
  }

  void updateilan(Ilan ilan) {
    state = UserDataViewState.Busy;
    ilan.status = -1;
    state = UserDataViewState.Loaded;
  }

  void incordernumber() {
    state = UserDataViewState.Busy;
    _UserDatas.orderNumber = _UserDatas.orderNumber + 1;
    state = UserDataViewState.Loaded;
  }

  void incfollowers() {
    state = UserDataViewState.Busy;
    _UserDatas.followers = _UserDatas.followers + 1;
    state = UserDataViewState.Loaded;
  }

  void incfollowings() {
    state = UserDataViewState.Busy;
    _UserDatas.followings = _UserDatas.followings + 1;
    state = UserDataViewState.Loaded;
  }

  void decfollowers() {
    state = UserDataViewState.Busy;
    _UserDatas.followers = _UserDatas.followers - 1;
    state = UserDataViewState.Loaded;
  }

  void decfollowings() {
    state = UserDataViewState.Busy;
    _UserDatas.followings = _UserDatas.followings - 1;
    state = UserDataViewState.Loaded;
  }

  void addterziornek(Ornekekle orn) {
    state = UserDataViewState.Busy;
    _UserDatas.terziornekler.add(orn);
    state = UserDataViewState.Loaded;
  }

  void addtasarimciornek(Ornekekle orn) {
    state = UserDataViewState.Busy;
    _UserDatas.terziornekler.add(orn);
    print("UserDatalar eklendi prov viewmodel");
    state = UserDataViewState.Loaded;
  }

}
