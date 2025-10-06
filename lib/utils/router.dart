import 'package:flutter/material.dart';
import 'package:tira_fe/view/atasan/add_atasan.dart';
import 'package:tira_fe/view/atasan/data_atasan.dart';
import 'package:tira_fe/view/atasan/update_atasan.dart';
import 'package:tira_fe/view/member/add_member.dart';
import 'package:tira_fe/view/member/data_member.dart';
import 'package:tira_fe/view/homescreen.dart';
import 'package:tira_fe/view/login_screen.dart';
import 'package:tira_fe/view/member/update_member.dart';
import 'package:tira_fe/view/reseller/data_reseller.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Homescreen());
      case '/atasan':
        return MaterialPageRoute(builder: (_) => const DataAtasan());
      case '/member':
        return MaterialPageRoute(builder: (_) => const DataMember());
      case '/add-member':
        return MaterialPageRoute(builder: (_) => const AddMember());
      case '/update-member':
        return MaterialPageRoute(
          builder: (_) => UpdateMember(mRepId: settings.arguments as String),
        );
      case '/add-atasan':
        return MaterialPageRoute(builder: (_) => const AddAtasan());
      case '/update-atasan':
        return MaterialPageRoute(
          builder: (_) => UpdateAtasan(mRepId: settings.arguments as String),
        );
      case '/reseller':
        return MaterialPageRoute(builder: (_) => const DataReseller());
      default:
        return _routeError();
    }
  }

  static Route _routeError() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text("Something went wrong!")),
      ),
    );
  }
}
