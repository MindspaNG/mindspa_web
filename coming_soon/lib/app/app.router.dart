// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../UI/coming_soon/coming_soon_view.dart';

class Routes {
  static const String comingSoonView = '/';
  static const all = <String>{
    comingSoonView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.comingSoonView, page: ComingSoonView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    ComingSoonView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ComingSoonView(),
        settings: data,
      );
    },
  };
}
