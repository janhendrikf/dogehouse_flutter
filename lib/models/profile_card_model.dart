class ProfileCardModel {
  String? profilePicUrl = "";
  String? name = "";
  String? username = "";
  String? followers = "";
  String? following = "";
  String? description = "";
  String? url = "";

  ProfileCardModel({this.profilePicUrl, this.name, this.username, this.followers, this.following, this.description, this.url});

  factory ProfileCardModel.testData() {
    return ProfileCardModel(
      profilePicUrl: 'https://avatars.githubusercontent.com/u/7872329?s=400&u=f41fcb80dc9ce32a809caf9a6c4d9bf31c6ae11a&v=4',
      name: 'Arnau Jiménez',
      username: '@ajmnz',
      followers: '3.4k',
      following: '90',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis nunc sit pulvinar ut tellus sit tincidunt faucibus sapien. ⚡',
      url: 'loremipsum.com',
    );
  }
}
