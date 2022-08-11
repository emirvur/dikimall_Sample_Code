import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/provider/languageprovider.dart';

import 'package:dikimall/view/designerView/findDesigner.dart';
import 'package:dikimall/widgets/BoxShadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'DikimBul.dart';

class ServicesTerzi extends StatefulWidget {
  const ServicesTerzi({Key key}) : super(key: key);

  @override
  _ServicesTerziState createState() => _ServicesTerziState();
}

class _ServicesTerziState extends State<ServicesTerzi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: new Text(
            "hizmetler".tr(),
            style: TextStyle(color: anayazi),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text("neyeihtiyacinvar".tr()),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FindDesigner()),
                            );
                          },
                          child: BoxShadowContainer(
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        child: Image.asset(
                                          "assets/servistasarimnet.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Center(child:
                                          Consumer<LanguageProvider>(
                                              builder: (_, prov, child) {
                                        return Text(
                                          "tasarim".tr(),
                                          style: TextStyle(fontSize: 12),
                                        );
                                      })))
                                ],
                              ),
                              height:
                                  ((MediaQuery.of(context).size.height * 30) /
                                      100),
                              width:
                                  MediaQuery.of(context).size.width * 2 / 3)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DikimBul()),
                            );
                          },
                          child: BoxShadowContainer(
                              height:
                                  (MediaQuery.of(context).size.height * 30) /
                                      100,
                              width: MediaQuery.of(context).size.width * 2 / 3,
                              //        color: Colors.blue,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(

                                        child: Image.asset(
                                          "assets/servisterzinet.jpeg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Center(child:
                                          Consumer<LanguageProvider>(
                                              builder: (_, prov, child) {
                                        return Text(
                                          "dikim".tr(),
                                          style: TextStyle(fontSize: 12),
                                        );
                                      })))
                                ],
                              ))),
                    )
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}

