import 'package:badges/badges.dart';
import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/services/APIServices.dart';

import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/view/feedView/FeedPage.dart';
import 'package:dikimall/view/notificationView/notificationProducer.dart';
import 'package:dikimall/view/notificationView/notificationUser.dart';
import 'package:dikimall/view/orderView/salesIncomes.dart';
import 'package:dikimall/view/profilePageView/ProfilePageClient.dart';
import 'package:dikimall/view/profilePageView/ProfilePageProducer.dart';
import 'package:dikimall/view/sharePostWork/addwork.dart';
import 'package:dikimall/view/sharePostWork/sharepost.dart';
import 'package:dikimall/view/tailorView/ServicesTerzi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dikimall/enums/userType.dart';
import 'package:dikimall/services/IAPIServices.dart';
import 'package:dikimall/utils/locator.dart';

class Home extends StatefulWidget {
  final UserData user;

  Home(this.user);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  static PageController pageController =
      PageController(); //initstate mi alsan vre dispose
  IAPIService apiservice = locator<APIServices>();
  static void onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    print("$index");
    if (index == 3) {
      if (Sabit.user.hasnotification == true) {
        apiservice.updateHasNotify(Sabit.user.id);
      }
      Sabit.user.hasnotification = false;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgets;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widgets = <Widget>[
      FeedPage(),
      Sabit.user.role == UserTypeHelper.getValue(UserType.USER)
          ? SharePost()
          : AddWork(),
      Sabit.user.role == UserTypeHelper.getValue(UserType.USER)
          ? ServicesTerzi()
          : SalesIncomes(Sabit.user.id),
      Sabit.user.role == UserTypeHelper.getValue(UserType.USER)
          ? NotificationUser()
          : NotificationProducer(),
      Sabit.user.role == UserTypeHelper.getValue(UserType.USER)
          ? ProfilePageClient(true)
          : ProfilePageProducer(true, false, Sabit.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: _widgets,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey.shade300,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled, // FontAwesomeIcons.ho,
                color:
                    _selectedIndex == 0 ? kPrimaryColor : Colors.grey.shade300,
                size: 16,
              ),
              title: Text(
                "anasayfa".tr(),
                style: TextStyle(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.plusCircle,
                color:
                    _selectedIndex == 1 ? kPrimaryColor : Colors.grey.shade300,
                size: 16,
              ),
              title: Text(
                "paylas".tr(), //  "Paylaş",
                style: TextStyle(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/kucuklogo.svg",
                  width: 25,
                  height: 25,
                  color: _selectedIndex == 2 ? kPrimaryColor : Colors.black,
                  semanticsLabel: 'Label'),
              title: Text(
                Sabit.user.role == UserTypeHelper.getValue(UserType.USER)
                    ? "hizmetler".tr()
                    : "satislarim".tr(),
                style: TextStyle(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Badge(
                showBadge: Sabit.user.hasnotification,
                badgeContent: Text(""),
                child: Icon(
                  FontAwesomeIcons.bell,
                  color: _selectedIndex == 3
                      ? kPrimaryColor
                      : Colors.grey.shade300,
                  size: 16,
                ),
              ),
              title: Text(
                "bildirimler".tr(), // " Bildirimler",
                style: TextStyle(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                color:
                    _selectedIndex == 4 ? kPrimaryColor : Colors.grey.shade300,
                size: 16,
              ),
              title: Text(
                "profilim".tr(),
                style: TextStyle(fontSize: 10),
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
