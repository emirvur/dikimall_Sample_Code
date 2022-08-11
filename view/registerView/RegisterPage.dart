import 'package:dikimall/constants/colors.dart';
import 'package:dikimall/constants/size.dart';
import 'package:dikimall/enums/userType.dart';
import 'package:dikimall/models/User.dart';
import 'package:dikimall/services/APIServices.dart';

import 'package:dikimall/utils/facebookloginscreen.dart';
import 'package:dikimall/utils/sabit.dart';
import 'package:dikimall/utils/verifyemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'ProfileType.dart';
import 'ProfileTypeForGoogle.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isChecked = false;
  bool _passwordVisible = false;
  TextEditingController _contname;
  TextEditingController _contemail;
  TextEditingController _contpassword;
  TextEditingController _contrepassword;
  String _name;
  String _email;
  String _sifr;
  String _url;
  String _resif;
  bool _ismail = true;
  int _initialIndex = 0;
  final _formKey = GlobalKey<FormState>();
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contname = TextEditingController();
    _contemail = TextEditingController();
    _contpassword = TextEditingController();
    _contrepassword = TextEditingController();
  }

  @override
  void dispose() {
    _contname.dispose();
    _contemail.dispose();
    _contpassword.dispose();
    _contrepassword.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // color: Colors.red,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        //   color: Colors.yellow,
                        child: Center(
                          child: Image.asset("assets/dikimallyazinet.jpeg"),
                        ),
                      )),
                  Expanded(
                      flex: 6,
                      child: Container(
                        // color: Colors.green,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _contname,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(4.0),
                                  labelStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  labelText: 'Ad Soyad',
                                ),
                                onSaved: (String value) {
                                  _name = value.trim();
                                },
                                validator: (String value) {
                                  return (value == null)
                                      ? 'Kullanıcı adı kısmı boş olamaz'
                                      : null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _contemail,
                                //  maxLength: ismail ? 50 : 10,
                                keyboardType: _ismail
                                    ? TextInputType.emailAddress
                                    : TextInputType.phone,
                                decoration: InputDecoration(
                                  prefix: Padding(
                                      padding: EdgeInsets.only(right: 2),
                                      child: !_ismail ? Text('+90') : null
                                      ),
                                  suffix: ToggleSwitch(
                                    minHeight: 20,
                                    minWidth: 40.0,
                                    initialLabelIndex: _initialIndex,
                                    //     cornerRadius: 20.0,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey,
                                    inactiveFgColor: Colors.white,
                                    totalSwitches: 2,
                                    icons: [
                                      FontAwesomeIcons.envelope,
                                      FontAwesomeIcons.phone
                                    ],
                                    activeBgColors: [
                                      [kPrimaryColor],
                                      [kPrimaryColor]
                                    ],
                                    onToggle: (index) {
                                      print('switched to: $index');
                                      //   setState(() {});

                                      setState(() {
                                        _initialIndex = index;
                                        _initialIndex == 0
                                            ? _ismail = true
                                            : _ismail = false;
                                      });
                                    },
                                  ),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(4.0),
                                  labelStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  labelText:
                                      _ismail ? "E-Posta" : "Telefon Numarası",
                                ),
                                onSaved: (String value) {
                                  _email = value.trim(); // + "@gmail.com";
                                },
                                validator: (String value) {
                                  return (_ismail &&
                                          value != null &&
                                          !value.contains('@'))
                                      ? 'Geçerli bir e-mail giriniz'
                                      : null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _contpassword,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(4.0),
                                  suffixIcon: IconButton(
                                    iconSize: 14,
                                    color: Colors.grey,
                                    splashRadius: 1,
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword,
                                  ),
                                  labelStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  labelText: 'Şifre Oluşturun',
                                ),
                                onSaved: (String value) {
                                  _sifr = value.trim();
                                },
                                validator: (String value) {
                                  return (value != null && value.length < 6)
                                      ? 'Şifre en az 6 karakterden oluşmalıdır'
                                      : null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: _contrepassword,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(4.0),
                                  suffixIcon: IconButton(
                                    iconSize: 14,
                                    color: Colors.grey,
                                    splashRadius: 1,
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword,
                                  ),
                                  labelStyle: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  labelText: 'Şifre Tekrar',
                                ),
                                onSaved: (String value) {},
                                validator: (String value) {
                                  return (value != null &&
                                          value != _contpassword.text)
                                      ? 'Girdiğiniz şifre ile eşleşmedi'
                                      : null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                //  margin: EdgeInsets.all(20),
                                child: FlatButton(
                                  child: Text(
                                    'Kaydol',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  color: kPrimaryColor,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (_ismail == false &&
                                        _contemail.text.length != 10) {
                                      return ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Telefon numaranız 10 karakterden oluşmalıdır')));
                                    }
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      UserData c = _ismail
                                          ? UserData(
                                              //  token: Sabit.user.token,
                                              username: _name,
                                              role: UserTypeHelper.getValue(UserType.USER),
                                              email: _email,
                                            )
                                          : UserData(
                                              username: _name,
                                              role:UserTypeHelper.getValue(UserType.USER),
                                              phone: "+90${_contemail.text}",
                                            );
                                      c.token = Sabit.user.token;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileType(c, _sifr)),
                                      );
                                    } else {
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        //  color: Colors.pink,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Aşağıdaki sosyal medya kanalları aracılığıyla da hızlıca\n kayıt yapabilirsiniz",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(FontAwesomeIcons.google,
                                        size: AppSize.grandeIconsize),
                                    onPressed: () {
                                      try {
                                        _googleSignIn
                                            .signIn()
                                            .then((userData) async {
                                          setState(() {
                                            _userObj = userData;
                                            _url = _userObj.photoUrl.toString();
                                            var emgo = _userObj.email;

                                          });
                                          if (userData != null) {
                                            await EasyLoading.show(
                                              status: 'Kayıt Yapılıyor...',
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                            );
                                            UserData us;

                                            EasyLoading.dismiss();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileTypeForGoogle(
                                                            user: UserModel(
                                                                email: _userObj
                                                                    .email,
                                                                pictureModel:
                                                                    PictureModel(
                                                                        url: _userObj
                                                                            .photoUrl)))));
                                          }
                                        }).catchError((e) {
                                          EasyLoading.dismiss();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Kayıt Bilgilerinizi Kontrol Ediniz')));
                                        });
                                      } catch (e) {
                                        EasyLoading.dismiss();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Giriş Bilgilerinizi Kontrol Ediniz')));
                                      }
                                    }),
                                IconButton(
                                    icon: Icon(FontAwesomeIcons.facebookSquare,
                                        color: Colors.blue,
                                        size: AppSize.grandeIconsize),
                                    onPressed: () {
                                      try {
                                        signInface().then((value) async {
                                          if (value.id == "-1") {
                                            print("rredfs");
                                            EasyLoading.dismiss();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Giriş Bilgilerinizi Kontrol Ediniz')));
                                          } else {

                                            await EasyLoading.show(
                                              status: 'Kayıt Yapılıyor...',
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                            );

                                            UserData us;
                                            try {} catch (e) {

                                              EasyLoading.dismiss();
                                              return ScaffoldMessenger.of(
                                                      context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Kayıt Hatası' + e)));
                                            }

                                            EasyLoading.dismiss();

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileTypeForGoogle(
                                                            user: value)));
                                          }
                                        });
                                      } catch (e) {
                                        EasyLoading.dismiss();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Giriş Bilgilerinizi Kontrol Ediniz')));
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
