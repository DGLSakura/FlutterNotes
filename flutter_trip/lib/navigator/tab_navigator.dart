import 'package:flutter/material.dart';
import 'package:fluttertrip/pages/home_page.dart';
import 'package:fluttertrip/pages/my_page.dart';
import 'package:fluttertrip/pages/search_page.dart';
import 'package:fluttertrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget{
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>{
  final PageController _controller = PageController(
    //初始显示页面
    initialPage: 0,
  );
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  //当前选中的页面
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ],
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
          },
          //底部按钮文字始终显示
          type: BottomNavigationBarType.fixed,
          items:[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color: _defaultColor),
                activeIcon: Icon(Icons.home,color: _activeColor),
                title: Text(
                    '首页',
                    style: TextStyle(color: _currentIndex != 0 ? _defaultColor : _activeColor)
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,color: _defaultColor),
                activeIcon: Icon(Icons.search,color: _activeColor),
                title: Text(
                    '搜索',
                    style: TextStyle(color: _currentIndex != 1 ? _defaultColor : _activeColor)
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt,color: _defaultColor),
                activeIcon: Icon(Icons.camera_alt,color: _activeColor),
                title: Text(
                    '旅拍',
                    style: TextStyle(color: _currentIndex != 2 ? _defaultColor : _activeColor)
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,color: _defaultColor),
                activeIcon: Icon(Icons.account_circle,color: _activeColor),
                title: Text(
                    '我的',
                    style: TextStyle(color: _currentIndex != 3 ? _defaultColor : _activeColor)
                )
            )
          ])
    );
  }

}
