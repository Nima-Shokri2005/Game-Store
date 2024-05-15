import 'package:flutter/material.dart';
import 'consts.dart';
import 'game_model.dart';
import 'image_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.gameModel});

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    const String detailChert =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua';
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                gameModel.coverImage,
                height: 375,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 150,
                left: 150,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 450,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 75,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        infoSection(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About game',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                detailChert,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Game Picture',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            customImage(context, gameModel.image1),
                            customImage(context, gameModel.image2),
                            customImage(context, gameModel.image3)
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primeColor,
                                fixedSize: const Size(200, 30)),
                            child: const Text(
                              'install now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector customImage(BuildContext context, String imageAddress) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageScreen(
              imagePath: imageAddress,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Hero(
          tag: imageAddress,
          child: Image.asset(
            imageAddress,
            width: 85,
            height: 85,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Container infoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          customRow(Icons.download, '1M'),
          customRow(Icons.star, '5K'),
          customRow(Icons.phone_android, '1.5M'),
        ],
      ),
    );
  }

  Row customRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
          color: primeColor,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        )
      ],
    );
  }
}
