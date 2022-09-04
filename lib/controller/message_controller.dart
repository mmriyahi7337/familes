import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:nearby_connections/nearby_connections.dart';

class MessageController extends GetxController {
  late bool isServer;

  MessageController({required this.isServer});

  final String userName = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_STAR;
  Map<String, ConnectionInfo> endpointMap = Map();

  // check permissions:
  bool locationPermission = false;
  bool externalStoragePermission = false;
  bool bluetoothPermission = false;
  bool enableLocationServices = false;

  // connection entities:
  // List<Device> devices = [];
  bool isConnected = false;

  // late Device connectedDevice;
  // late NearbyService nearbyService;
  // late StreamSubscription subscription;
  // late StreamSubscription receivedDataSubscription;

  // selectRound entities:
  int round = 1;
  bool selectRound = false;

  //selectAlphabet entities:
  bool isMyTurn = false;
  List<String> selectedWordList = [];
  int turn = -1;
  bool isSelectedWord = false;
  String selectedWord = '';

  // playground entities:
  bool endRound_1 = false;
  bool endRound_2 = false;
  bool endGame = false;

  int score_1 = 0; // you
  int score_2 = 0; // enemy

  String? name_1; //you
  String? family_1; //you
  String? city_1; //you
  String? country_1; //you
  String? things_1; //you

  // ignore: non_constant_identifier_names
  int scoreName_1 = 0;
  int scoreFamily_1 = 0;
  int scoreCity_1 = 0;
  int scoreCountry_1 = 0;
  int scoreThings_1 = 0;

  String? name_2; //enemy
  String? family_2; //enemy
  String? city_2; //enemy
  String? country_2; //enemy
  String? things_2; //enemy

  // ignore: non_constant_identifier_names
  int scoreName_2 = 0;
  int scoreFamily_2 = 0;
  int scoreCity_2 = 0;
  int scoreCountry_2 = 0;
  int scoreThings_2 = 0;

  int winner = 0;

  get totalScore_1 {
    return (scoreName_1 + scoreFamily_1 + scoreCity_1 + scoreCountry_1 + scoreThings_1);
  }

  get totalScore_2 {
    return (scoreName_2 + scoreFamily_2 + scoreCity_2 + scoreCountry_2 + scoreThings_2);
  }

  void updateScore(){
    judgment();
    if (totalScore_1 > totalScore_2) {
      score_1++;
    } else if (totalScore_1 < totalScore_2) {
      score_2++;
    }
    if ((score_1 + score_2) == round) {
      endGame = true;
      winner = (score_1>score_2) ? 1 : 2; // 1 means you & 2 means enemy
    }
    isMyTurn = !isMyTurn;
    update();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void dispose() {
    // subscription.cancel();
    // receivedDataSubscription.cancel();
    // nearbyService.stopBrowsingForPeers();
    // nearbyService.stopAdvertisingPeer();
    super.dispose();
  }

  void init() async {
    await checkPermissions();
    isServer ? discovering() : advertising();
  }

  void sendMessage(String m) {
    endpointMap.forEach((key, value) {
      Nearby().sendBytesPayload(key, Uint8List.fromList(utf8.encode(m)));
    });
  }

  void judgment() {
    scoreName_1 = judgmentLogic(name_1, name_2);
    scoreName_2 = judgmentLogic(name_2, name_1);

    scoreFamily_1 = judgmentLogic(family_1, family_2);
    scoreFamily_2 = judgmentLogic(family_2, family_1);

    scoreCity_1 = judgmentLogic(city_1, city_2);
    scoreCity_2 = judgmentLogic(city_2, city_1);

    scoreCountry_1 = judgmentLogic(country_1, country_2);
    scoreCountry_2 = judgmentLogic(country_2, country_1);

    scoreThings_1 = judgmentLogic(things_1, things_2);
    scoreThings_2 = judgmentLogic(things_2, things_1);
  }

  int judgmentLogic(String? you, String? enemy) {
    if (you==null || you.isEmpty) {
      return 0;
    } else if (you.isNotEmpty && (enemy == null || enemy.isEmpty)) {
      // only you answer:
      return 20;
    } else if (you.isNotEmpty && (enemy != null && enemy.isNotEmpty) && you == enemy) {
      // same answer:
      return 5;
    } else if (you.isNotEmpty && (enemy != null && enemy.isNotEmpty)) {
      // both answer:
      return 10;
    }
    return 0;
  }

  void discovering() async {
    try {
      bool a = await Nearby().startDiscovery(
        userName,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          Nearby().requestConnection(
            userName,
            id,
            onConnectionInitiated: (id, info) {
              onConnectionInit(id, info);
            },
            onConnectionResult: (id, status) {
              // todo
              print(status);
            },
            onDisconnected: (id) {
              endpointMap.remove(id);
              update();
            },
          );
        },
        onEndpointLost: (id) {},
      );
    } catch (e) {}
  }

  /// Called upon Connection request (on both devices)
  /// Both need to accept connection to start sending/receiving
  void onConnectionInit(String id, ConnectionInfo info) {
    endpointMap[id] = info;
    isConnected = true;
    update();
    Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endid, payload) async {
        if (payload.type == PayloadType.BYTES) {
          String str = utf8.decode(payload.bytes!);
          print(str);
          messageReader(str);
        }
      },
      onPayloadTransferUpdate: (endid, payloadTransferUpdate) {},
    );
  }

  void advertising() async {
    try {
      bool a = await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: onConnectionInit,
        onConnectionResult: (id, status) {},
        onDisconnected: (id) {
          endpointMap.remove(id);
          update();
        },
      );
    } catch (exception) {}
  }

  String msgAnswers() {
    endRound_1 = true;
    update();
    return (jsonEncode({
      'answer': true,
      'name': name_1 ?? '',
      'family': family_1 ?? '',
      'city': city_1 ?? '',
      'country': country_1 ?? '',
      'things': things_1 ?? '',
    }));
  }

  void resetAns(){
    name_1 = '';
    family_1 = '';
    city_1 = '';
    country_1 = '';
    things_1 = '';
    update();
  }

  String msgSelectRound() {
    final rand = Random().nextInt(2);
    turn = rand;
    isMyTurn = isServer ? (turn == 1) : (turn!=1);
    selectRound = true;
    update();
    return (jsonEncode({'round': round, 'turn': rand}));
  }

  String msgSelectAlphabet() {
    selectedWordList.add(selectedWord);
    isSelectedWord = true;
    update();
    return (jsonEncode({'selectAlphabet': true, 'word': selectedWord}));
  }

  void messageReader(data) {
    // decode data and get "message":
    final json = jsonDecode(data);
    // conditions:
    if (json['round'] != null) {
      round = json['round'];
      turn = json['turn'];
      isMyTurn = isServer ? (turn == 1) : (turn!=1);
      selectRound = true;
      update();
    } else if (json['selectAlphabet'] != null) {
      selectedWord = json['word'];
      selectedWordList.add(selectedWord);
      isSelectedWord = true;
      update();
    } else if (json['answer'] != null) {
      name_2 = json['name'];
      family_2 = json['family'];
      city_2 = json['city'];
      country_2 = json['country'];
      things_2 = json['things'];

      endRound_2 = true;
      update();
    }
  }

  void incRound() {
    round++;
    update();
  }

  void decRound() {
    round--;
    update();
  }

  void changeSelectedWord(String element) {
    selectedWord = element;
    update();
  }

  Future<void> checkPermissions() async {
    await Nearby().askLocationPermission();
    Nearby().askExternalStoragePermission();
    Nearby().askBluetoothPermission();
    await Nearby().enableLocationServices();
  }

  void resetEndRounds() {
    endRound_1 = false;
    endRound_2 = false;
    update();
  }

  void resetSelectedWordState() {
    isSelectedWord = false;
    update();
  }
}

/*void init() async {
  nearbyService = NearbyService();
  String? devInfo = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  devInfo = androidInfo.model;
  await nearbyService.init(
      serviceType: 'mpconn',
      deviceName: devInfo,
      strategy: Strategy.P2P_CLUSTER,
      callback: (isRunning) async {
        if (isRunning) {
          if (isServer) {
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            await nearbyService.startBrowsingForPeers();
          } else {
            await nearbyService.stopAdvertisingPeer();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(const Duration(microseconds: 200));
            await nearbyService.startAdvertisingPeer();
            await nearbyService.startBrowsingForPeers();
          }
        }
      });
  subscription =
      nearbyService.stateChangedSubscription(callback: (devicesList) {
        for (var element in devicesList) {
          print(
              " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");

          if (element.state == SessionState.connected) {
            nearbyService.stopBrowsingForPeers();
          } else {
            nearbyService.startBrowsingForPeers();
          }
        }

        devices.clear();
        devices.addAll(devicesList);
        connectedDevice =
            devicesList.firstWhere((d) => d.state == SessionState.connected);
        isConnected = true;
        update();
      });

  receivedDataSubscription = nearbyService.dataReceivedSubscription(
    callback: (data) {
      messageReader(data);
    },
  );
}*/
