import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/components/components.dart';
import '../login_screens/login_screen.dart';


class BoardModel{
  late final String image;
  late final String title;
  late final String name;
  BoardModel({
    required this.title,
    required this.name,
    required this.image,
});
}

class OnBoarding extends StatefulWidget {
   const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardModel> boarding =[
    BoardModel(
        title: 'Title App',
        name: 'Name App',
        image: 'assets/images/PngItem_1.png'),
    BoardModel(
        title: 'Title App 2',
        name: 'Name App 2',
        image: 'assets/images/PngItem_2.png'),
    BoardModel(
        title: 'Title App 3',
        name: 'Name App 3',
        image: 'assets/images/PngItem_94296.png'),
  ];
  var pageController = PageController();
  bool isLast = false;


  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context,ShopLoginScreen());
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:(){
                submit();
              },
              child: const Text('SKIP',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context,index)=>boardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.teal,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 3,
                      spacing: 6,
                    ),
                ),
                const Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                   submit();
                  }
                  else{
                  pageController.nextPage(
                  duration: const Duration(
                  milliseconds: 950,
                  ),
                  curve:Curves.fastLinearToSlowEaseIn);
                  }

                },
                  child: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boardItem(BoardModel model)=> Column(crossAxisAlignment: CrossAxisAlignment.start,
    children:   [
      Expanded(
        child: Image(
          image:AssetImage(model.image) ,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(model.title,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(model.name,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ),

      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
