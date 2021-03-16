class AuthModel {
  String? accessToken;
  String? refreshToken;
  bool? reconnectToVoice = true;
  bool? muted = false;
  String? platform = "app";

  AuthModel({this.accessToken, this.refreshToken, this.reconnectToVoice, this.muted, this.platform});

  Map<String, dynamic> toJson() {
    return {
      "accessToken": this.accessToken,
      "refreshToken": this.refreshToken,
      "reconnectToVoice": this.reconnectToVoice,
      "muted": this.muted,
      "platform": this.platform,
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }
}
