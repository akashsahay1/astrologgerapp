import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/texts.dart';
import '../constants/colors.dart';
import 'package:fapp/screens/home.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<Intro> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': AppStrings.introTitle1,
      'description': AppStrings.introDesc1,
      'image': 'assets/images/intro1.png',
      'backgroundColor': AppColors.introBg1,
    },
    {
      'title': AppStrings.introTitle2,
      'description': AppStrings.introDesc2,
      'image': 'assets/images/intro2.png',
      'backgroundColor': AppColors.introBg2,
    },
    {
      'title': AppStrings.introTitle3,
      'description': AppStrings.introDesc3,
      'image': 'assets/images/intro3.png',
      'backgroundColor': AppColors.introBg3,
    },
  ];

  void _onNextPage() async {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Set the flag to show home screen next time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('showHome', true);
      
      if (!mounted) return;
      
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Container(
                color: page['backgroundColor'],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      page['image'],
                      height: 210,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      page['title'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        page['description'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? AppColors.textLight
                        : AppColors.textLight.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _onNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textLight,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _currentPage == _pages.length - 1
                      ? AppStrings.btnGetStarted
                      : AppStrings.btnNext,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _pages[_currentPage]['backgroundColor'],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}