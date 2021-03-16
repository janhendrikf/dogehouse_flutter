class Room {
  String? id;
  String? name;
  String? description;
  bool? isPrivate;
  int? numPeopleInside;
  String? creatorId;
  List<PeoplePreviewListItem>? peoplePreviewList = [];

  Room({this.id, this.name, this.description, this.isPrivate, this.numPeopleInside, this.creatorId, this.peoplePreviewList});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      isPrivate: json["isPrivate"] == 'true',
      numPeopleInside: json["numPeopleInside"],
      creatorId: json["creatorId"],
      peoplePreviewList: List.of(json["peoplePreviewList"] ?? []).map((i) => PeoplePreviewListItem.fromJson(i)).toList(),
    );
  }
}

class PeoplePreviewListItem {
  String? id;
  String? displayName;
  int? numFollowers;

  PeoplePreviewListItem({this.id, this.displayName, this.numFollowers});

  factory PeoplePreviewListItem.fromJson(Map<String, dynamic> json) {
    return PeoplePreviewListItem(
      id: json["id"],
      displayName: json["displayName"],
      numFollowers: json["numFollowers"],
    );
  }
}

class BaseUser {
  String? username;
  bool? online;
  DateTime? lastOnline;
  String? id;
  String? bio;
  String? displayName;
  String? avatarUrl;
  int? numFollowing;
  int? numFollowers;
  Room? currentRoom;

  BaseUser(
      {this.username,
      this.online,
      this.lastOnline,
      this.id,
      this.bio,
      this.displayName,
      this.avatarUrl,
      this.numFollowing,
      this.numFollowers,
      this.currentRoom});

  factory BaseUser.fromJson(Map<String, dynamic> json) {
    return BaseUser(
      username: json["username"],
      online: json["online"] == 'true',
      lastOnline: DateTime.parse(json["lastOnline"]),
      id: json["id"],
      bio: json["bio"],
      displayName: json["displayName"],
      avatarUrl: json["avatarUrl"],
      numFollowing: json["numFollowing"],
      numFollowers: json["numFollowers"],
      currentRoom: json["currentRoom"] != null ? Room.fromJson(json["currentRoom"]) : null,
    );
  }
//

}

class PaginatedBaseUsers {
  List<BaseUser>? users;
  int? nextCursor;
}

class RoomPermissions {
  bool? askedToSpeak;
  bool? isSpeaker;
  bool? isMod;

  RoomPermissions({this.askedToSpeak, this.isSpeaker, this.isMod});

  factory RoomPermissions.fromJson(Map<String, dynamic> json) {
    return RoomPermissions(
      askedToSpeak: json["askedToSpeak"] == 'true',
      isSpeaker: json["isSpeaker"] == 'true',
      isMod: json["isMod"] == 'true',
    );
  }
}

class UserWithFollowInfo {
  String? username;
  bool? online;
  DateTime? lastOnline;
  String? id;
  String? bio;
  String? displayName;
  String? avatarUrl;
  int? numFollowing;
  int? numFollowers;
  Room? currentRoom;

  bool? followsYou;
  bool? youAreFollowing;
}

class RoomUser {
  String? username;
  bool? online;
  DateTime? lastOnline;
  String? id;
  String? bio;
  String? displayName;
  String? avatarUrl;
  int? numFollowing;
  int? numFollowers;
  Room? currentRoom;

  bool? followsYou;
  bool? youAreFollowing;
  RoomPermissions? roomPermissions;

  RoomUser(
      {this.username,
      this.online,
      this.lastOnline,
      this.id,
      this.bio,
      this.displayName,
      this.avatarUrl,
      this.numFollowing,
      this.numFollowers,
      this.currentRoom,
      this.followsYou,
      this.youAreFollowing,
      this.roomPermissions});

  factory RoomUser.fromJson(Map<String, dynamic> json) {
    return RoomUser(
      username: json["username"],
      online: json["online"] == 'true',
      lastOnline: DateTime.parse(json["lastOnline"]),
      id: json["id"],
      bio: json["bio"],
      displayName: json["displayName"],
      avatarUrl: json["avatarUrl"],
      numFollowing: json["numFollowing"],
      numFollowers: json["numFollowers"],
      currentRoom: Room.fromJson(json["currentRoom"]),
      followsYou: json["followsYou"] == 'true',
      youAreFollowing: json["youAreFollowing"] == 'true',
      roomPermissions: json["roomPermissions"] != null ? RoomPermissions.fromJson(json["roomPermissions"]) : null,
    );
  }
//

}

class CurrentRoom {
  String? id;
  String? name;
  String? description;
  bool? isPrivate;
  int? numPeopleInside;
  String? creatorId;
  List<PeoplePreviewListItem>? peoplePreviewList;
  List<RoomUser>? users;
  Map<String?, bool?>? muteMap;
  Map<String, bool>? activeSpeakerMap;
  bool? autoSpeaker;

  CurrentRoom(
      {this.id,
      this.name,
      this.description,
      this.isPrivate,
      this.numPeopleInside,
      this.creatorId,
      this.peoplePreviewList,
      this.users,
      this.muteMap,
      this.activeSpeakerMap,
      this.autoSpeaker});

  factory CurrentRoom.fromJson(Map<String, dynamic> json) {
    return CurrentRoom(
      id: json["id"] ?? null,
      name: json["name"],
      description: json["description"],
      isPrivate: json["isPrivate"] == 'true',
      numPeopleInside: json["numPeopleInside"],
      creatorId: json["creatorId"],
      peoplePreviewList: List.of(json["peoplePreviewList"] ?? []).map((i) => PeoplePreviewListItem.fromJson(i)).toList(),
      users: List.of(json["users"] ?? []).map((i) => RoomUser.fromJson(i)).toList(),
      muteMap: new Map<String, bool>.from(json["muteMap"]),
      activeSpeakerMap: new Map<String, bool>.from(json["muteMap"]),
      autoSpeaker: json["autoSpeaker"] == 'true',
    );
  }
}

class WsParam {
  String? op;
  dynamic d;
}

class ScheduledRoom {
  String? roomId;
  String? description;
  DateTime? scheduledFor;
  int? numAttending;
  String? name;
  String? id;
  String? creatorId;
  BaseUser? creator;

  ScheduledRoom({this.roomId, this.description, this.scheduledFor, this.numAttending, this.name, this.id, this.creatorId, this.creator});

  factory ScheduledRoom.fromJson(Map<String, dynamic> json) {
    return ScheduledRoom(
      roomId: json["roomId"],
      description: json["description"],
      scheduledFor: DateTime.parse(json["scheduledFor"]),
      numAttending: json["numAttending"],
      name: json["name"],
      id: json["id"],
      creatorId: json["creatorId"],
      creator: BaseUser.fromJson(json["creator"]),
    );
  }
//

}

class ScheduledRoomsInfo {
  List<ScheduledRoom>? scheduledRooms = [];
  String? nextCursor;

  ScheduledRoomsInfo({this.scheduledRooms, this.nextCursor});

  factory ScheduledRoomsInfo.fromJson(Map<String, dynamic> json) {
    return ScheduledRoomsInfo(
      scheduledRooms: List.of(json["scheduledRooms"] ?? []).map((i) => ScheduledRoom.fromJson(i)).toList(),
      nextCursor: json["nextCursor"],
    );
  }
}

class PublicRoomsQuery {
  List<Room>? rooms = [];
  int? nextCursor;

  PublicRoomsQuery({this.rooms, this.nextCursor});

  factory PublicRoomsQuery.fromJson(Map<String, dynamic> json) {
    return PublicRoomsQuery(
      rooms: List.of(json["rooms"] ?? []).map((i) => Room.fromJson(i)).toList(),
      nextCursor: json["nextCursor"] ?? null,
    );
  }
}

enum UseSocketStatus { authGood, open, connecting, closedByServer, closed }
