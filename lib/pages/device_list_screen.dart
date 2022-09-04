
import 'package:familes/controller/message_controller.dart';
import 'package:familes/pages/select_alphabet_page.dart';
import 'package:familes/pages/select_round_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../const/my_colors.dart';
import '../widgets/my_toolbar.dart';

enum DeviceType { advertiser, browser }

class DevicesListScreen extends StatelessWidget {
  final DeviceType deviceType;
  const DevicesListScreen({required this.deviceType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageController(isServer: deviceType==DeviceType.browser), tag: 'MessageController');
    bool isInit = false;
    return GetBuilder<MessageController>(
      init: controller,
      builder: (c) {
        if (!isInit) {
          if (c.selectRound) {
            Future.delayed(const Duration(milliseconds: 50)).then((value) {
              Get.to(const SelectAlphabetPage(), preventDuplicates: false);
            });
            isInit = true;
          }
          if (c.isConnected) {
            Future.delayed(const Duration(milliseconds: 50)).then((value) {
              Get.to(SelectRoundPage(isServer: c.isServer), preventDuplicates: false);
            });
            isInit = true;
          }
        }
        return SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.background,
            body: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: body(c),
                  ),
                ),
                const MyToolbar(),
              ],
            ),
          ),
        );
      }
    );
  }

  Column body(MessageController controller) {
    return Column(
      children: [
        const SizedBox(height: kToolbarHeight + 60),
        SizedBox(
          height: 600,
          width: double.infinity,
          child: GetBuilder<MessageController>(
            builder: (c) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 80.0),
                child: Center(child: CircularProgressIndicator()),
              );
              /*return ListView.builder(
                itemCount: c.endpointMap.keys.length,
                itemBuilder: (context, index) {
                  *//*final device = !c.isServer
                      ? c.connectedDevice
                      : c.devices[index];
                  return deviceItem(device, c, context);*//*
                },
              );*/
            }
          ),
        ),
      ],
    );
  }

  deviceItem(Device device, MessageController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          print(device.deviceName);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: MyColor.orange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device.deviceName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text(
                            getStateName(device.state),
                            style: TextStyle(
                                color: getStateColor(device.state), fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    // Request connect
                    connectBtn(device, c, context),
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector connectBtn(Device device, MessageController c, BuildContext context) {
    return GestureDetector(
      onTap: () => {}/*_onButtonClicked(device, c, context)*/,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        height: 35,
        width: 100,
        decoration: BoxDecoration(
            color: getButtonColor(device.state),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            getButtonStateName(device.state),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  String getStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return "disconnected";
      case SessionState.connecting:
        return "waiting";
      default:
        return "connected";
    }
  }

  String getButtonStateName(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
      case SessionState.connecting:
        return "Connect";
      default:
        return "Disconnect";
    }
  }

  Color getStateColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
        return Colors.black;
      case SessionState.connecting:
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Color getButtonColor(SessionState state) {
    switch (state) {
      case SessionState.notConnected:
      case SessionState.connecting:
        return MyColor.blue;
      default:
        return Colors.red;
    }
  }


 /* _onButtonClicked(Device device, MessageController c, BuildContext context) {
    switch (device.state) {
      case SessionState.notConnected:
        c.nearbyService.invitePeer(
          deviceID: device.deviceId,
          deviceName: device.deviceName,
        );
        // Get.to(SelectRoundPage(device: device, isServer: c.isServer,));
        break;
      case SessionState.connected:
        c.nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        break;
    }
  }*/
}
