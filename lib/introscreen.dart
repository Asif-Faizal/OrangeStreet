import 'package:flutter/material.dart';
import 'package:shop/signup.dart';
import 'package:shop/widgets/button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: [
                _buildIntroPage(
                  'Discover the Latest Trends',
                  'Immerse yourself in a world of style and discover outfits that express your unique personality. With our app, you\'re just a swipe away from staying on top of the fashion game.',
                  'lib/assets/page1.jpg',
                ),
                _buildIntroPage(
                  'Your Wardrobe, Your Style',
                  'Step into a personalized shopping experience designed just for you. From timeless classics to cutting-edge fashion, find the pieces that resonate with your personality. Your wardrobe makeover begins here!',
                  'lib/assets/page2.jpg',
                ),
                _buildIntroPage(
                  'Effortless Shopping, Endless Possibilities',
                  'Embrace the ease of shopping. Whether you\'re revamping your wardrobe or searching for that perfect outfit, our app provides a seamless and enjoyable shopping journey. Unleash the possibilities and redefine your style effortlessly!',
                  'lib/assets/page3.jpg',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: Colors.deepOrange,
                    dotColor: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                onLastPage ? _buildDoneButton() : _buildNextButton(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroPage(String title, String description, String imagePath) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(right: 40, left: 40, bottom: 120, top: 80),
        child: Card(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Button(
      onPressed: () {
        _controller.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      },
      child: Text(
        'next'.toUpperCase(),
        style: const TextStyle(
          fontSize: 20,
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDoneButton() {
    return Button(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Signup()),
        );
      },
      child: Text(
        'done'.toUpperCase(),
        style: const TextStyle(
          fontSize: 20,
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
