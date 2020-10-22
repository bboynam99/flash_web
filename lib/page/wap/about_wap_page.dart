import 'dart:async';

import 'package:flash_web/common/color.dart';
import 'package:flash_web/generated/l10n.dart';
import 'package:flash_web/model/lang_model.dart';
import 'package:flash_web/provider/common_provider.dart';
import 'package:flash_web/provider/index_provider.dart';
import 'package:flash_web/router/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

import 'package:provider/provider.dart';

class AboutWapPage extends StatefulWidget {
  @override
  _AboutWapPageState createState() => _AboutWapPageState();
}

class _AboutWapPageState extends State<AboutWapPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  bool tronFlag = false;
  Timer _timer;


  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        CommonProvider.changeHomeIndex(2);
      });
    }
    _reloadAccount();
  }

  @override
  void dispose() {
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.white,
      appBar: _appBarWidget(context),
      drawer: _drawerWidget(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _mainWidget(context),
          ),
          //FooterPage(),
        ],
      ),
    );
  }


  Widget _mainWidget(BuildContext context) {
    return Container(
      color: MyColors.white,
      width: ScreenUtil().setWidth(750),
      child: ListView(
        children: <Widget>[
          _bizWidget(context),
        ],
      ),
    );
  }

  Widget _bizWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20), left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(10), bottom: ScreenUtil().setHeight(20)),
      child: Column(
        children: [
          Container(
            child: Text(
              'Flash Finance',
              style: GoogleFonts.lato(fontSize: ScreenUtil().setSp(38), fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
            child: Text('${S.of(context).aboutTips5}',
                style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(28),
                  color: MyColors.black87,
                  fontWeight: FontWeight.w500
              ),
              maxLines: 2, overflow: TextOverflow.clip,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
            child: Text('${S.of(context).aboutTips3}',
              style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(28),
                  color: MyColors.black87,
                  fontWeight: FontWeight.w500
              ),
              maxLines: 2, overflow: TextOverflow.clip,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: Text('${S.of(context).aboutTips4}',
              style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(28),
                  color: MyColors.black87,
                  fontWeight: FontWeight.w500
              ),
              maxLines: 2, overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor:  MyColors.lightBg,
      elevation: 0,
      titleSpacing: 0.0,
      title: Container(
        child: Image.asset('images/logo.png', fit: BoxFit.contain, width: ScreenUtil().setWidth(110), height: ScreenUtil().setWidth(110)),
      ),
      leading: IconButton(
        hoverColor: MyColors.white,
        icon: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
          child: Icon(Icons.menu, size: ScreenUtil().setWidth(55), color: Colors.black87),
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      centerTitle: true,
    );
  }

  Widget _drawerWidget(BuildContext context) {
    int _homeIndex = CommonProvider.homeIndex;
    int langType = Provider.of<IndexProvider>(context).langType;
    String account = Provider.of<IndexProvider>(context).account;
    return Drawer(
      child: Container(
        color: MyColors.white,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            ListTile(
              title: Text(
                '${S.of(context).actionTitle0}',
                style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(32),
                  color: _homeIndex == 0 ? Colors.black : Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  CommonProvider.changeHomeIndex(0);
                });
                Application.router.navigateTo(context, 'wap/farm', transition: TransitionType.fadeIn);
              },
              leading: Icon(
                Icons.assistant,
                color: _homeIndex == 0 ? Colors.black87 : Colors.grey[700],
              ),
            ),
            ListTile(
              title:  Text(
                '${S.of(context).actionTitle1}',
                style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(32),
                  color: _homeIndex == 1 ? Colors.black : Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                setState(() {
                  CommonProvider.changeHomeIndex(1);
                });
                Application.router.navigateTo(context, 'wap/swap', transition: TransitionType.fadeIn);
              },
              leading: Icon(
                Icons.broken_image,
                color: _homeIndex == 1 ? Colors.black87 : Colors.grey[700],
              ),
            ),
            ListTile(
              title:  Text(
                '${S.of(context).actionTitle2}',
                style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(32),
                  color: _homeIndex == 2 ? Colors.black : Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                setState(() {
                  CommonProvider.changeHomeIndex(2);
                });
                Application.router.navigateTo(context, 'wap/about', transition: TransitionType.fadeIn);
              },
              leading: Icon(
                Icons.file_copy_sharp,
                color: _homeIndex == 2 ? Colors.black87 : Colors.grey[700],
              ),
            ),
            ListTile(
              title: Text(
                account == '' ? '${S.of(context).actionTitle3}' : account.substring(0, 4) + '...' + account.substring(account.length - 4, account.length),
                style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(32),
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
              },
              leading: Icon(
                Icons.account_circle,
                color: Colors.grey[700],
              ),
            ),
            ListTile(
              title: Text(
                langType == 1 ? 'English' : '简体中文',
                style: GoogleFonts.lato(
                  fontSize: ScreenUtil().setSp(32),
                  color: Colors.grey[700],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                _showLangTypeDialLog();
              },
              leading: Icon(
                Icons.language,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLangTypeDialLog() {
    List<LangModel> langModels = Provider.of<IndexProvider>(context, listen: false).langModels;
    showDialog(
      context: context,
      child: AlertDialog(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        content: Container(
          width: ScreenUtil().setWidth(400),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: langModels.length,
            itemBuilder: (context, index) {
              return _selectLangTypeItemWidget(context, index, langModels[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _selectLangTypeItemWidget(BuildContext context, int index, LangModel item) {
    int langType = Provider.of<IndexProvider>(context, listen: false).langType;
    bool flag = index == langType ? true : false;
    return InkWell(
      onTap: () {
        Provider.of<IndexProvider>(context, listen: false).changeLangType(index);
        Navigator.pop(context);
      },
      child: Container(
        width: ScreenUtil().setWidth(300),
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(200),
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              alignment: Alignment.centerLeft,
              child: Text(
                '${item.name}',
                style: TextStyle(
                  color: !flag ? Colors.black87 : Colors.blue[800],
                  fontSize: ScreenUtil().setSp(30),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(100),
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
              alignment: Alignment.centerRight,
              child: !flag ? Container() : Icon(
                Icons.check,
                color: Colors.blue[800],
                size: ScreenUtil().setSp(35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _reloadAccount() async {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) async {
      tronFlag = js.context.hasProperty('tronWeb');
      if (tronFlag) {
        var result = js.context["tronWeb"]["defaultAddress"]["base58"];
        if (result.toString() != 'false') {
          Provider.of<IndexProvider>(context, listen: false).changeAccount(result.toString());
        } else {
          Provider.of<IndexProvider>(context, listen: false).changeAccount('');
        }
      } else {
        Provider.of<IndexProvider>(context, listen: false).changeAccount('');
      }
    });
  }


}