import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tugas_front_end_nicolas/components/button.dart';
import 'package:tugas_front_end_nicolas/screens/home.dart';
import 'package:tugas_front_end_nicolas/screens/landing_screen.dart';

class StepperScreens extends StatefulWidget {
  const StepperScreens({super.key});

  @override
  _StepperScreensState createState() => _StepperScreensState();
}

class _StepperScreensState extends State<StepperScreens> {
  final PageController _controller = PageController();
  final List<Map<String, dynamic>> steps = [
    {
      "title": "Find Parking Easily",
      "content": "Find parking around you easily and online",
      "image": "assets/starting/toy car turn right blue.png",
      "align": "left",
      "offset": 20.0,
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
      "offset": 20.0,
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

  void skipAll(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
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
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
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
                    offset: steps[index]["offset"],
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
              activeDotColor: Color(0xFF4D5DFA),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              children: [
                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () => nextPage(context),
                  text: "Next",
                  textColor: Colors.white,
                  backgroundColor: Color(0xFF4D5DFA),
                ),
                SizedBox(height: isSmall ? 0 : 10),
                ResponsiveButton(
                  isSmall: isSmall,
                  onPressed: () => skipAll(context),
                  text: "Skip",
                  textColor: Color(0xFF4D5DFA),
                  backgroundColor: Color.fromARGB(255, 212, 217, 255),
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
    this.offset,
  });

  final String title;
  final String subtitle;
  final String image;
  final String align;
  final double? offset;

  // inside your LandingStepper class:
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isSmall ? 32 : 40,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: isSmall ? 20 : 24,
            fontFamily: "Poppins",
          ),
        ),
        const SizedBox(height: 30),
        Transform.translate(
          offset: Offset(offset ?? 0.0, 0),
          child: Align(
            alignment:
                align == "left"
                    ? Alignment.centerLeft
                    : align == "right"
                    ? Alignment.centerRight
                    : Alignment.center,
            child: Image.asset(image, height: isSmall ? 160 : 240),
          ),
        ),
      ],
    );
  }
}
