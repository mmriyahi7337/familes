import 'package:familes/pages/device_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:familes/const/my_colors.dart';
import 'package:familes/pages/select_round_page.dart';
import 'package:familes/widgets/my_button.dart';
import 'package:get/get.dart';


import '../widgets/my_toolbar.dart';

class FindFriendPage extends StatefulWidget {
  const FindFriendPage({Key? key}) : super(key: key);

  @override
  _FindFriendPageState createState() => _FindFriendPageState();
}

class _FindFriendPageState extends State<FindFriendPage> {
  int selectedIndex = -1;
  int clientSide = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: body(),
              ),
            ),
            const MyToolbar(),
          ],
        ),
      ),
    );
  }

  body() {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight + 60),
        // finder(),
        const SizedBox(height: 25),
        serverBtn(),
        const SizedBox(height: 25),
        clientBtn(),
        const SizedBox(height: 25),
        // serverBtn(),
      ],
    );
  }

  // finder() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 32.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         header(),
  //         if (clientSide==0 || clientSide == -1) list(),
  //       ],
  //     ),
  //   );
  // }

  // SizedBox list() {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.width * 0.75,
  //     child: SingleChildScrollView(
  //       physics: const BouncingScrollPhysics(),
  //       child: Column(
  //         children: [
  //           ...devices(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  serverBtn() {
    return MyButton(
      onClick: () {
       Get.to( const DevicesListScreen(deviceType: DeviceType.browser));
      },
      text: 'میزبان',
    );
  }
  clientBtn() {
    return MyButton(
      onClick: () {
        Get.to( const DevicesListScreen(deviceType: DeviceType.advertiser));
      },
      text: 'مهمان',
    );
  }

  header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: MyColor.lightBlue,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
        child: Center(
          child: Text(
            'این بار دوست داری با کی بازی کنی؟',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  // List<Widget> devices() {
  //   List<Widget> items = [];
  //   // todo: pass devices to loop
  //   for (int i = 0; i < 100; i++) {
  //     items.add(deviceItem('guest', i));
  //   }
  //   return items;
  // }

  // deviceItem(String name, int index) {
  //   final color = (selectedIndex == index)
  //       ? MyColor.blue
  //       : (index % 2 == 0)
  //           ? MyColor.highlightBlue
  //           : MyColor.lightBlue;
  //   return Material(
  //     color: color,
  //     child: InkWell(
  //       splashColor: MyColor.blue,
  //       onTap: () {
  //         setState(() {
  //           selectedIndex = index;
  //         });
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.all(16),
  //         child: Center(
  //           child: Text(
  //             name,
  //             style: const TextStyle(color: Colors.white),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

/*
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => FindFriendPage());
    case 'browser':
      return MaterialPageRoute(
          builder: (_) =>
              const DevicesListScreen(deviceType: DeviceType.browser));
    case 'advertiser':
      return MaterialPageRoute(
          builder: (_) =>
              const DevicesListScreen(deviceType: DeviceType.advertiser));
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

class FindFriendPage extends StatelessWidget {
  const FindFriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'browser');
              },
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'BROWSER',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'advertiser');
              },
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'ADVERTISER',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


*/
