import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart'; // Replace with your main app screen

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {"title": "Welcome!", "description": "Discover new features", "image": "assets/image1.png"},
    {"title": "Easy to Use", "description": "Navigate with ease", "image": "assets/image2.png"},
    {"title": "Get Started!", "description": "Let's begin your journey", "image": "assets/image3.png"},
  ];

  Future<void> _finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(_pages[index]["image"]!, height: 250),
                    SizedBox(height: 20),
                    Text(
                      _pages[index]["title"]!,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _pages[index]["description"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Container(
                margin: EdgeInsets.all(4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          _currentPage == _pages.length - 1
              ? ElevatedButton(
                  onPressed: _finishOnboarding,
                  child: Text("Get Started"),
                )
              : ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                  child: Text("Next"),
                ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
