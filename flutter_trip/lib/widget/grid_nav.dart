import 'package:flutter/material.dart';
import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/model/grid_nav_model.dart';
import 'package:fluttertrip/widget/webview.dart';

//网格卡片
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    //酒店
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    //机票
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    //旅行
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  Widget _gridNavItem(
      BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(Expanded(
      child: _mainItem(context, gridNavItem.mainItem),
      flex: 1,
    ));
    items.add(Expanded(
      child: _doubleItem(context, gridNavItem.item1, gridNavItem.item2),
      flex: 1,
    ));
    items.add(Expanded(
      child: _doubleItem(context, gridNavItem.item3, gridNavItem.item4),
      flex: 1,
    ));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [
          Color(int.parse('0xff' + gridNavItem.startColor)),
          Color(int.parse('0xff' + gridNavItem.endColor))
        ]),
      ),
      child: Row(
        children: items,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        model);
  }

  Widget _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满父布局的宽度
      widthFactor: 1,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          )),
          child: _wrapGesture(
              context,
              Center(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              item)),
    );
  }

  //跳转到web页面
  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: model.url,
                      statusBarColor: model.statusBarColor,
                      title: model.title,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
