import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertrip/dao/home_dao.dart';
import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/model/grid_nav_model.dart';
import 'package:fluttertrip/model/home_model.dart';
import 'package:fluttertrip/model/sales_box_model.dart';
import 'package:fluttertrip/widget/grid_nav.dart';
import 'package:fluttertrip/widget/local_nav.dart';
import 'package:fluttertrip/widget/sales_box.dart';
import 'package:fluttertrip/widget/sub_nav.dart';

//滚动完全变为白色的最大距离
const APPBAR_SCROLL_OFFSET = 80;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //监听滚动
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    //异常逻辑补偿
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2),
      //叠加widget
      body: Stack(
        children: <Widget>[
          //移除padding
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            //监听子元素
            child: NotificationListener(
              // ignore: missing_return
              onNotification: (scrollNotification) {
                //滚动且是列表滚动的时候
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0 /*第1个Widget*/) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: bannerList.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(bannerList[index].icon,
                            fit: BoxFit.fill);
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: LocalNav(localNavList: localNavList),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: GridNav(gridNavModel: gridNavModel),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: SubNav(subNavList: subNavList),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: SalesBox(salesBox: salesBoxModel),
                  ),
                ],
              ),
            ),
          ),
          //改变Widget透明度
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
