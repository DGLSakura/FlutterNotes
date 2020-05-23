import 'package:fluttertrip/model/common_model.dart';
import 'package:fluttertrip/model/config_model.dart';
import 'package:fluttertrip/model/grid_nav_model.dart';
import 'package:fluttertrip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.bannerList,
      this.config,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList: subNavList,
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['config'] = this.config.toJson();
    data['bannerList'] = this.bannerList.map((i) => i.toJson()).toList();
    data['localNavList'] = this.localNavList.map((i) => i.toJson()).toList();
    data['gridNav'] = this.gridNav;
    data['localNavList'] = this.localNavList.map((i) => i.toJson()).toList();
    data['salesBox'] = this.salesBox.toJson();
    return data;
  }
}
