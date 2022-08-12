import 'package:dikimall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String imageAddress;
  final String time;
  final bool isImage;
  const ReceivedMessageWidget({
    Key key,
    this.content,
    this.time,
    this.isImage,
    this.imageAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content.startsWith("resim")
        ? Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  constraints: BoxConstraints(minWidth: 80),
                  color:
                      kPrimaryColor, //whatsappyesil, //Colors.white, //Colors.blue[500],
                  // margin: const EdgeInsets.only(left: 10.0),
                  child: Stack(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.network(
                              content.split("resim-")[1],
                              height: 200,
                              width: 130,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 10,
                      child: Text(
                        time,
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          )
        : content.startsWith("butonteklif")
            ? InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kPrimaryColor,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.dyalog,
                          color: Colors.white,
                        ),
                        Text(
                          "Teklif Verildi",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : content.startsWith("butonodeme")
                ? InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: kPrimaryColor,
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FontAwesomeIcons.dyalog,
                              color: Colors.white,
                            ),
                            Text(
                              "Ödeme Yapıldı",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : content.startsWith("butonayrintionay")
                    ? InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kPrimaryColor,
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  FontAwesomeIcons.dyalog,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Örnek Görseller\n Onaylandı",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : content.startsWith("butonurunonay")
                        ? InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: kPrimaryColor,
                                ),
                                height: 60,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.dyalog,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Ürün Onaylandı",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : content.startsWith("butonkargo")
                            ? InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: kPrimaryColor,
                                    ),
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.dyalog,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Ürün Kargoya\n Verildi",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : content.startsWith("butontamamlandi")
                                ? InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: kPrimaryColor,
                                        ),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.dyalog,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Sipariş Tamamlandı",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 75.0,
                                        left: 8.0,
                                        top: 8.0,
                                        bottom: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: Container(
                                        constraints:
                                            BoxConstraints(minWidth: 80),
                                        color: Colors.white,
                                        child: Stack(
                                          children: <Widget>[
                                            !isImage
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0,
                                                            left: 8.0,
                                                            top: 8.0,
                                                            bottom: 15.0),
                                                    child: Text(    :
                                                      content,
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0,
                                                            left: 8.0,
                                                            top: 8.0,
                                                            bottom: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          child: Image.asset(
                                                            imageAddress,
                                                            height: 130,
                                                            width: 130,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(content)
                                                      ],
                                                    ),
                                                  ),
                                            Positioned(
                                              bottom: 1,
                                              right: 10,
                                              child: Text(
                                                time,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
  }
}
