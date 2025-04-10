import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tugas_front_end_nicolas/screens/landing_screen.dart';

class StepperScreens extends StatefulWidget {
  const StepperScreens({super.key});

  @override
  _StepperScreensState createState() => _StepperScreensState();
}

class _StepperScreensState extends State<StepperScreens> {
  final PageController _controller = PageController();
  final List<Map<String, String>> steps = [
    {
      "title": "Find Parking Easily",
      "content": "Find parking around you easily and online",
      "image": "assets/starting/toy car turn right blue.png",
      "align": "left",
    },
    {
      "title": "Book and Pay for Parking Quickly and Easily",
      "content":
          "Make a booking for your parking and make a payment quickly and easier",
      "image": "assets/starting/back view of toy car turn right blue.png",
      "align": "center",
    },
    {
      "title": "Park According to the Desired Time",
      "content":
          "Can decide when parking time is and determine when it’s time to leave",
      "image": "assets/starting/toy car turn left blue.png",
      "align": "right",
    },
  ];

  int currentPage = 0;

  void nextPage(BuildContext context) {
    if (currentPage < steps.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // _controller.jumpToPage(0);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    }
  }

  void skipToLastPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Center(
                  child: LandingStepper(
                    title: steps[index]["title"]!,
                    subtitle: steps[index]["content"]!,
                    image: steps[index]["image"]!,
                    align: steps[index]["align"]!,
                  ),
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
                SizedBox(
                  width: 240,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () => nextPage(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4D5DFA),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 240,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () => skipToLastPage(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 212, 217, 255),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Color(0xFF4D5DFA)),
                      ),
                    ),
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

class LandingStepper extends StatelessWidget {
  const LandingStepper({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.align = "center",
  });

  final String title;
  final String subtitle;
  final String image;
  final String align;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
          SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontFamily: "Poppins",
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(
              left: align == "left" ? 20 : 0,
              right: align == "right" ? 20 : 0,
            ),
            child: Align(
              alignment:
                  align == "left"
                      ? Alignment.centerLeft
                      : align == "right"
                      ? Alignment.centerRight
                      : Alignment.center,
              child: Image.asset(image, height: 160),
            ),
          ),
        ],
      ),
    );
  }
}
