import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dogehouse_flutter/models/auth_model.dart';
import 'package:dogehouse_flutter/models/chat_model.dart';
import 'package:dogehouse_flutter/models/models.dart';
import 'package:dogehouse_flutter/resources/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DogeProvider with ChangeNotifier {
  late WebSocketChannel channel;
  UseSocketStatus? useSocketStatus;
  bool? authGood;
  AuthModel authModel = AuthModel();
  PublicRoomsQuery publicRoomsQuery = PublicRoomsQuery(rooms: []);
  ScheduledRoomsInfo scheduledRoomsInfo = ScheduledRoomsInfo(scheduledRooms: []);

  BaseUser? me;
  Room? currRoom;
  CurrentRoom? currentRoom;
  List<ChatModel> currMessages = [];
  List<BaseUser> following = [];

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future<void> connectWS() async {
    if (authModel.accessToken == null || authModel.refreshToken == null) {
      var res420 = await http.post(Uri.https('randommer.io', '/Name'), body: {'type': 'fullname', 'number': '1'});

      var res = await http.get(Uri.https(AppApi.apiBase, AppApi.apiDevLogin, {'username': jsonDecode(res420.body)[0]}));
      authModel = AuthModel.fromJson(jsonDecode(res.body));
    }

    useSocketStatus = UseSocketStatus.connecting;
    channel = IOWebSocketChannel.connect('ws://' + AppApi.wsBase + '/socket');
    channel.sink.add(jsonEncode({"op": "auth", "d": authModel.toJson()}));
    channel.stream.listen(
      (dynamic message) {
        if (message == '"pong"') {
          return;
        }
        var json = jsonDecode(message);
        debugPrint('Op: ' + json["op"].toString());
        switch (json["op"]) {
          case "new_room_details":
            break;

          case "chat_user_banned":
            break;

          case "new_chat_msg":
            currMessages.add(ChatModel.fromJson(json["d"]["msg"]));
            notifyListeners();
            break;

          case "message_deleted":
            break;

          case "room_privacy_change":
            break;

          case "banned":
            break;

          case "ban_done":
            break;

          case "someone_you_follow_created_a_room":
            break;

          case "invitation_to_room":
            break;

          case "fetch_invite_list_done":
            break;

          case "fetch_following_online_done":
            following = List.of(json["d"]["users"] ?? []).map((i) => BaseUser.fromJson(i)).toList();
            notifyListeners();
            break;

          case "get_top_public_rooms_done":
            break;

          case "fetch_follow_list_done":
            break;

          case "follow_info_done":
            break;

          case "active_speaker_change":
            break;

          case "room_destroyed":
            break;

          case "new_room_creator":
            break;

          case "speaker_removed":
            break;

          case "speaker_added":
            break;

          case "setCurrentRoom":
            break;

          case "mod_changed":
            break;

          case "user_left_room":
            break;

          case "new_user_join_room":
            break;

          case "hand_raised":
            break;

          case "mute_changed":
            currentRoom!.muteMap![json["d"]["userId"]] = json["d"]["value"];
            notifyListeners();
            break;

          case "get_current_room_users_done":
            currentRoom = CurrentRoom.fromJson(json["d"]);
            notifyListeners();
            break;

          case "new_current_room":
            break;

          case "join_room_done":
            currRoom = Room.fromJson(json["d"]["room"]);
            notifyListeners();
            break;

          case "new-tokens":
            authModel.accessToken = json["d"]["accessToken"];
            authModel.refreshToken = json["d"]["refreshToken"];
            break;

          case "you-joined-as-peer":
            //  json["d"]["recvTransportOptions"]["iceParameters"]["password"]
            //  json["d"]["recvTransportOptions"]["iceParameters"]["usernameFragment"]
            //  json["d"]["recvTransportOptions"]["iceCandidates"][0]["ip"]
            //  json["d"]["recvTransportOptions"]["iceCandidates"][0]["port"]
            break;

          case "error":
            debugPrint("error");
            break;
          default:
            useSocketStatus = UseSocketStatus.authGood;
            if (json["op"] == "auth-good") {
              authGood = true;
              me = BaseUser.fromJson(json["d"]["user"]);
            }
            if (json["op"] == "fetch_done") {
              switch (json["d"].keys.toList()[0]) {
                case 'rooms':
                  publicRoomsQuery = PublicRoomsQuery.fromJson(json["d"]);
                  notifyListeners();
                  break;
                case 'scheduledRooms':
                  scheduledRoomsInfo = ScheduledRoomsInfo.fromJson(json["d"]);
                  notifyListeners();
                  break;
              }
            }
            break;
        }
      },
      onDone: () {
        useSocketStatus = UseSocketStatus.closed;
        debugPrint('ws channel closed');
      },
      onError: (error) {
        useSocketStatus = UseSocketStatus.closed;
        debugPrint('ws error $error');
      },
    );
    channel.sink.add(jsonEncode({
      "op": "follow",
      "d": {"userId": "9a5f8653-deca-4356-8706-edcdd48d5e2b", "value": true}
    }));
    channel.sink.add(jsonEncode({
      "op": "follow",
      "d": {"userId": "371942a9-96cf-49ac-8c94-e24b9161869b", "value": true}
    }));

    getInfos();

    Timer.periodic(new Duration(seconds: 8), (timer) {
      if (useSocketStatus == UseSocketStatus.authGood) {
        channel.sink.add("ping");
      } else {
        timer.cancel();
      }
    });
  }

  getInfos() async {
    channel.sink.add(jsonEncode({
      "op": "fetch_following_online",
      "d": {"cursor": 0}
    }));
    channel.sink.add(jsonEncode({
      "op": "get_scheduled_rooms",
      "d": {"cursor": "", "getOnlyMyScheduledRooms": false},
      "fetchId": ""
    }));
    channel.sink.add(jsonEncode({
      "op": "get_top_public_rooms",
      "d": {"cursor": 0},
      "fetchId": ""
    }));

    channel.sink.add(jsonEncode({
      "op": "fetch_following_online",
      "d": {"cursor": 0}
    }));
    return true;
  }

  leaveRoom() {
    currRoom = null;
    currentRoom = null;
    currentRoom = null;
    currMessages = [];
    channel.sink.add(jsonEncode({"op": "leave_room", "d": {}}));
  }

  joinRoom(String? roomID) {
    channel.sink.add(jsonEncode({
      "op": "join_room",
      "d": {"roomId": roomID}
    }));

    channel.sink.add(jsonEncode({"op": "get_current_room_users", "d": {}}));
  }

  sendMessage(String text) {
    channel.sink.add(jsonEncode({
      "op": "send_room_chat_msg",
      "d": {
        "tokens": [
          {"t": "text", "v": text}
        ],
        "whisperedTo": []
      }
    }));
  }
}
