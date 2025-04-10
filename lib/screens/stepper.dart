import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StepperScreens extends StatefulWidget {
  @override
  _StepperScreensState createState() => _StepperScreensState();
}

class _StepperScreensState extends State<StepperScreens> {
  final PageController _controller = PageController();
  final List<Map<String, String>> steps = [
    {
      "title": "Find Parking Easily",
      "subtitle": "Find parking around you easily and online",
      "image": "assets/starting/toy car turn right blue.png",
    },
    {
      "title": "Book and Pay for Parking Quickly and Easily",
      "subtitle":
          "Make a booking for your parking and make a payment quickly and easier",
      "image": "assets/starting/back view of toy car turn right blue.png",
    },
    {
      "title": "Park According to the Desired Time",
      "subtitle":
          "Can decide when parking time is and determine when it’s time to leave",
      "image": "assets/starting/toy car turn left blue.png",
    },
  ];

  int currentPage = 0;

  void nextPage() {
    if (currentPage < steps.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLastPage() {
    _controller.animateToPage(
      steps.length - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(), // 👈 disable swipe
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Center(
                  child: LandingStepper(title: steps[index][title]),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: steps.length,
            effect: WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              activeDotColor: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: nextPage,
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                ),
                ElevatedButton(
                  onPressed: skipToLastPage,
                  child: Text('Skip'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
