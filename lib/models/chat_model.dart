class ChatModel {
  String? id;
  String? avatarUrl;
  String? displayName;
  String? userId;
  bool? isWhisper;
  DateTime? sentAt;
  List<ChatItemModel>? tokens;

  ChatModel({this.id, this.avatarUrl, this.displayName, this.userId, this.isWhisper, this.sentAt, this.tokens});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"],
      avatarUrl: json["avatarUrl"],
      displayName: json["displayName"],
      userId: json["userId"],
      isWhisper: json["isWhisper"] == 'true',
      sentAt: DateTime.parse(json["sentAt"]),
      tokens: List.of(json["tokens"]).map((i) => ChatItemModel.fromJson(i)).toList(),
    );
  }
}

class ChatItemModel {
  String? v;
  String? t;

  ChatItemModel({this.v, this.t});

  factory ChatItemModel.fromJson(Map<String, dynamic> json) {
    return ChatItemModel(
      v: json["v"],
      t: json["t"],
    );
  }
}
