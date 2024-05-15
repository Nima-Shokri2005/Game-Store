import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'consts.dart';
import 'detail_screen.dart';
import 'game_model.dart';

enum Category { action, racing, strategy, baby, other }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Enum enumStatus = Category.action;

  @override
  Widget build(BuildContext context) {
    //print(GameModel.gameModeList.length);
    return Scaffold(
      appBar: appBarSection(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchBarSection(),
            categorySection(),
            trendingItems(),
            newGameSection()
          ],
        ),
      ),
    );
  }

  Column newGameSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Games',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'see all',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: GameModel.gameModeList.length,
              itemBuilder: (context, index) {
                return NewGamesItemWidget(
                  index: index,
                );
              }),
        )
      ],
    );
  }

  Column trendingItems() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'see all',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: GameModel.gameModeList.length,
            itemBuilder: (context, index) {
              return TrenfingItemsWidget(
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }

  Padding categorySection() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 15,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryFunction(
                        title: 'Actions',
                        iconData: Icons.directions_walk,
                        primaryColor: enumStatus == Category.action
                            ? primeColor
                            : Colors.grey.shade800,
                        backgroundColor: enumStatus == Category.action
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        function: () {
                          setState(() {
                            enumStatus = Category.action;
                          });
                        }),
                    categoryFunction(
                        title: 'Racing',
                        iconData: Icons.car_crash,
                        primaryColor: enumStatus == Category.racing
                            ? primeColor
                            : Colors.grey.shade800,
                        backgroundColor: enumStatus == Category.racing
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        function: () {
                          setState(() {
                            enumStatus = Category.racing;
                          });
                        }),
                    categoryFunction(
                        title: 'Baby',
                        iconData: Icons.child_care,
                        primaryColor: enumStatus == Category.baby
                            ? primeColor
                            : Colors.grey.shade800,
                        backgroundColor: enumStatus == Category.baby
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        function: () {
                          setState(() {
                            enumStatus = Category.baby;
                          });
                        }),
                    categoryFunction(
                        title: 'Strategic',
                        iconData: Icons.castle,
                        primaryColor: enumStatus == Category.strategy
                            ? primeColor
                            : Colors.grey.shade800,
                        backgroundColor: enumStatus == Category.strategy
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        function: () {
                          setState(() {
                            enumStatus = Category.strategy;
                          });
                        }),
                    categoryFunction(
                        title: 'Other',
                        iconData: Icons.more_horiz,
                        primaryColor: enumStatus == Category.other
                            ? primeColor
                            : Colors.grey.shade800,
                        backgroundColor: enumStatus == Category.other
                            ? Colors.red.shade100
                            : Colors.grey.shade200,
                        function: () {
                          setState(() {
                            enumStatus = Category.other;
                          });
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell categoryFunction(
      {required String title,
      required IconData iconData,
      required Function function,
      required Color primaryColor,
      required Color backgroundColor}) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        margin: const EdgeInsets.only(left: 3, right: 3),
        width: 120,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: primaryColor,
              size: 28,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              title,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Padding searchBarSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: TextField(
        style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[270],
            hintText: 'Search games',
            prefixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 25,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25),
            ),
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0)),
      ),
    );
  }

  AppBar appBarSection() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: primeColor,
      ),
      leading: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: primeColor,
          borderRadius: BorderRadius.circular(251),
          border: Border.all(width: 2),
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(25)),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.thumb_up,
                  color: Colors.orange,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                '23456',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'roboto',
                    fontSize: 15),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }
}

class NewGamesItemWidget extends StatelessWidget {
  const NewGamesItemWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 135,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            SizedBox(
              width: 165,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  GameModel.gameModeList[index].coverImage,
                  width: 175,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    GameModel.gameModeList[index].title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  GameModel.gameModeList[index].category,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //width: 45,
                      padding:
                          const EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            GameModel.gameModeList[index].score,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const InstallButton()
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrenfingItemsWidget extends StatelessWidget {
  const TrenfingItemsWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  gameModel: GameModel.gameModeList[index],
                )));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 17, left: 5, right: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                GameModel.gameModeList[index].coverImage,
                width: 200,
                height: 270,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: SizedBox(
                      width: 200,
                      height: 125,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              GameModel.gameModeList[index].title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              GameModel.gameModeList[index].category,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 15, sigmaY: 15),
                                    child: SizedBox(
                                      width: 56,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 25,
                                          ),
                                          Text(
                                            GameModel.gameModeList[index].score,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const InstallButton(),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InstallButton extends StatelessWidget {
  const InstallButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'install',
        style: TextStyle(color: primeColor),
      ),
    );
  }
}
