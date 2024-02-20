import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pet/common/httpClient.dart';
import 'package:pet/common/kColors.dart';
import 'package:pet/common/photoScreen.dart';
import 'package:pet/model/pet_item.dart';
import 'package:pet/widget/animationButton.dart';
import 'package:rive/rive.dart';

class VotePage extends StatefulWidget {
  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  final CardSwiperController controller = CardSwiperController();
  late RiveAnimationController riveController;

  List<PetItem> petList = [];
  bool isEnd = false;

  @override
  void initState() {
    super.initState();
    getCardList();
  }

  void getCardList() async {
    dio.Response? res =
        await HttpClient().get('/v1/images/search', map: <String, dynamic>{
      'has_breeds': true,
      'limit': 25,
    });
    if (res!.data != null) {
      List<dynamic> resList = res.data;
      petList = resList.map((item) => PetItem.fromJson(item)).toList();
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    print(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    PetItem pet = petList[previousIndex];
    //不喜欢
    if (direction.name == 'left') {
      voteAction(pet.id!, -1);
    } else if (direction.name == 'right') {
      voteAction(pet.id!, 1);
    } else {
      favouritesActon(pet.id!);
    }
    return true;
  }

  // 刷新数据
  bool onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    print(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }

  //滑动的数据结束了
  void onEnd() {
    isEnd = true;
    setState(() {});
  }

  //投票
  void voteAction(String imageId, int value) async {
    dio.Response? res = await HttpClient().post('/v1/votes', <String, dynamic>{
      "image_id": imageId,
      "sub_id": "my-user-1234",
      "value": value
    });
  }

  //收藏
  void favouritesActon(String imageId) async {
    dio.Response? res =
        await HttpClient().post('/v1/favourites', <String, dynamic>{
      "image_id": imageId,
      "sub_id": "my-user-1234",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: !isEnd
              ? Column(
                  children: [
                    Flexible(
                      child: petList.length > 0
                          ? CardSwiper(
                              controller: controller,
                              isLoop: true,
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 60, bottom: 100),
                              scale: .9, // 后面的卡的比例
                              cardsCount: petList.length,
                              numberOfCardsDisplayed: 3,
                              onSwipe: onSwipe,
                              onUndo: onUndo,
                              onEnd: onEnd,
                              cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) {
                                PetItem pet = petList[index];
                                return CardView(
                                  petItem: pet,
                                );
                              },
                            )
                          : Text(''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BouncingButton(
                            onTap: () {
                              controller.swipe(CardSwiperDirection.left);
                            },
                            image: 'assets/images/icon_unlike.png',
                          ),
                          BouncingButton(
                            onTap: () {
                              controller.swipe(CardSwiperDirection.right);
                            },
                            image: 'assets/images/icon_like_0.png',
                          ),
                          BouncingButton(
                            onTap: () {
                              controller.swipe(CardSwiperDirection.top);
                            },
                            image: 'assets/images/icon_collect_0.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text('过会儿再来吧'),
                )),
    );
  }
}

class CardView extends StatefulWidget {
  final PetItem petItem;
  const CardView({super.key, required this.petItem});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: KColors().cardColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2), // 设置阴影偏移量
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(PhotoScreen(imgList: [widget.petItem.url], index: 0));
              },
              child: Container(
                width: double.infinity, // 设置宽度为整个父容器宽度
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    '${widget.petItem.url}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: KColors().cardColor(),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                'breeds: ${widget.petItem.breeds?[0].name}',
                style: TextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
