import 'package:flutter/material.dart';
import 'package:shop_app/modules/welcome_screen/welcome_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart' ;

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<OnBoardingModel> models = [
    OnBoardingModel(
      image: 'assets/images/shop1.png',
      title: 'Explore many product',
      body:
          'Choose your product we have many categories electronics , clothes and ',
    ),
    OnBoardingModel(
      title: 'Choose and checkout',
      body:
          'We have many sales and many best offers on many products and categories ',
      image: 'assets/images/shop2.png',
    ),
    OnBoardingModel(
      title: 'Get it delivered',
      body:
          'We can deliver your product to your home in any government or any place ',
      image: 'assets/images/shop3.png',
    ),
  ];

  bool isLast = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, WelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              itemBuilder: (context, index) => buildPageView(models[index],context),
              itemCount: models.length,
              onPageChanged: (int index){
                if(index == models.length-1){
                  setState(() {
                    isLast =true;
                  });
                }else{
                  setState(() {
                    isLast=false;
                  });
                }
              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageView(OnBoardingModel model,context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Image(
              image: AssetImage('${model.image}'),
            )),
            SizedBox(
              height: 5,
            ),
            Text(
              '${model.title}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.deepOrange),
              maxLines: 3,
            ),
            Text(
              '${model.body}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: submit,
                  child: Text('Skip'),
                ),
                Spacer(),
                SmoothPageIndicator(
                  controller: boardController,
                  count: models.length,
                  effect: ExpandingDotsEffect(
                      spacing: 5.0,
                      expansionFactor: 4,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepOrange),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(duration: Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn,);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      );
}

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({this.image, this.title, this.body});
}
