import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_2/Pages/LoginPage.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> with SingleTickerProviderStateMixin{
  int _currentPage = 0;
  AnimationController? _animationController;
  PageController? _pageController;

  List<IntroductionContent> _pages = [
    IntroductionContent(
      title: "Page 1",
      description: "Description 1",
      icon: Icons.access_alarm,
    ),
    IntroductionContent(
      title: "Page 2",
      description: "Description 2",
      icon: Icons.accessibility,
    ),
    IntroductionContent(
      title: "Page 3",
      description: "Description 3",
      icon: Icons.account_balance,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _pageController = PageController(initialPage: _currentPage);
    _pageController!.addListener(() {
      setState(() {
        _currentPage = _pageController!.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _pageController!.dispose();
    super.dispose();
  }

void _nextPage() {
  if (_currentPage < _pages.length - 1) {
    _pageController!.animateToPage(
      _currentPage + 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  } else {
    // Navigate to the login page when on the last page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
            itemBuilder: (context, index) {
              final bool isCurrentPage = index == _currentPage;

              return IntroductionContent(
                title: _pages[index].title,
                description: _pages[index].description,
                icon: _pages[index].icon,
                isCurrentPage: isCurrentPage,
                animationController: _animationController,
              );
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.blue,
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.blue[50],
                  enableFeedback: false,
                  onPressed: _nextPage,
                  child: Text(_currentPage < _pages.length - 1 ? 'Next' : 'Start'),
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.94,
            right: MediaQuery.of(context).size.width * 0.41,
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: _currentPage == i ? 20.0 : 10.0, // Make the current dot wider
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}

class IntroductionContent extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isCurrentPage;
  final AnimationController? animationController;

  IntroductionContent({
    required this.title,
    required this.description,
    required this.icon,
    this.isCurrentPage = false,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final slidePercent = isCurrentPage ? 0.0 : 1.0;

    return AnimatedOpacity(
      opacity: isCurrentPage ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 350),
            width: isCurrentPage ? 130.0 : 100.0, // Make the current dot wider
            height: isCurrentPage ? 130.0 : 100.0, // Make the current dot wider
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrentPage ? Colors.blue : Colors.transparent,
            ),
            child: Icon(
              icon,
              size: isCurrentPage ? 60.0 : 50.0,
              color: isCurrentPage ? Colors.white : Colors.blue,
            ),
          ),
          SizedBox(height: 20.0),
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, slidePercent), // Slide up from bottom
              end: Offset.zero,
            ).animate(animationController!),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0), // Slide up from bottom
              end: Offset(1.0, -4.0),
            ).animate(animationController!),
            child: Text(
              description,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
