class GameModel {
  final String title;
  final String category;
  final String score;
  final String coverImage;
  final String image1;
  final String image2;
  final String image3;

  GameModel(
      {required this.title,
      required this.category,
      required this.score,
      required this.coverImage,
      required this.image1,
      required this.image2,
      required this.image3});

  static List<GameModel> gameModeList = [
    GameModel(
        title: 'battel filed',
        category: 'action',
        score: '4.8',
        coverImage: 'assets/images/battlefield/battlefield_cover.jpg',
        image1: 'assets/images/battlefield/battlefield1.jpg',
        image2: 'assets/images/battlefield/battlefield2.jpg',
        image3: 'assets/images/battlefield/battlefield3.jpg'),
    GameModel(
        title: 'call of duty',
        category: 'action',
        score: '4.6',
        coverImage: 'assets/images/callofduty/callofduty_cover.jpg',
        image1: 'assets/images/callofduty/callofduty1.jpg',
        image2: 'assets/images/callofduty/callofduty2.jpg',
        image3: 'assets/images/callofduty/callofduty_cover.jpg'),
    GameModel(
        title: 'crash bandicoot',
        category: 'action',
        score: '4.9',
        coverImage: 'assets/images/crashbandicoot/crashbandicoot_cover.jpg',
        image1: 'assets/images/crashbandicoot/crashbandicoot1.jpg',
        image2: 'assets/images/crashbandicoot/crashbandicoot2.jpg',
        image3: 'assets/images/crashbandicoot/crashbandicoot3.png'),
    GameModel(
        title: 'godofwar',
        category: 'action',
        score: '4.4',
        coverImage: 'assets/images/godofwar/godofwar_cover.png',
        image1: 'assets/images/godofwar/godofwar1.jpg',
        image2: 'assets/images/godofwar/godofwar2.jpg',
        image3: 'assets/images/godofwar/godofwar3.jpg'),
    GameModel(
        title: 'need for speed',
        category: 'action',
        score: '4.8',
        coverImage: 'assets/images/needforspeed/needforspeed_cover.png',
        image1: 'assets/images/needforspeed/needforspeed1.jpg',
        image2: 'assets/images/needforspeed/needforspeed2.jpg',
        image3: 'assets/images/needforspeed/needforspeed3.png'),
    GameModel(
        title: 'spiderman',
        category: 'action',
        score: '4.3',
        coverImage: 'assets/images/spiderman/spiderman_cover.jpg',
        image1: 'assets/images/spiderman/spiderman1.jpg',
        image2: 'assets/images/spiderman/spiderman2.jpg',
        image3: 'assets/images/spiderman/spiderman3.jpg'),
  ];
}
