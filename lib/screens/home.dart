import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chefbot/screens/recipe_generator.dart';
import 'package:chefbot/screens/about.dart';
import 'package:chefbot/screens/chat.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:particles_fly/particles_fly.dart';
import 'food.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://Chairil13.github.io/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double minSize = 110;
    double lottieSize =
        screenWidth * 0.13 < minSize ? minSize : screenWidth * 0.13;
    double circleSize =
        screenWidth * 0.15 < minSize ? minSize : screenWidth * 0.15;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 1,
            child: Lottie.asset('assets/backgrounds/back_anim.json'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 95, sigmaY: 95),
              child: const SizedBox(),
            ),
          ),
          ParticlesFly(
            height: screenHeight,
            width: screenWidth,
            lineStrokeWidth: 0.1,
            connectDots: true,
            numberOfParticles: 15,
            awayRadius: 100,
            speedOfParticles: 1,
            isRandomColor: true,
            maxParticleSize: 7,
            awayAnimationCurve: Curves.bounceOut,
            awayAnimationDuration: const Duration(milliseconds: 10),
            isRandSize: true,
            enableHover: true,
            hoverRadius: 30,
            lineColor: const Color.fromARGB(90, 149, 148, 149),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Chef Bot 👨‍🍳',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Poppins',
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                          "Chef Bot adalah AI yang ahli dalam bidang kuliner yang dapat membantumu menjadi seorang chef berbakat. Silahkan konsultasikan apapun mengenai kuliner dengan Chef Bot 😊",
                          speed: const Duration(milliseconds: 45),
                          textStyle:
                              const TextStyle(fontFamily: 'Intel-SemiBold'),
                          textAlign: TextAlign.center)
                    ],
                    totalRepeatCount: 1,
                  )),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircularButton(
                        'Chat dengan\nChef Bot',
                        'assets/backgrounds/chefbot.json',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatScreen()),
                        ),
                        circleSize,
                        lottieSize,
                      ),
                      _buildCircularButton(
                        'Analisis Bahan\nMakanan',
                        'assets/backgrounds/food_home.json',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FoodPage()),
                        ),
                        circleSize,
                        lottieSize,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircularButton(
                        'Buat\nResep',
                        'assets/backgrounds/generate_recipes.json',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecipeGenerateView(isIngredient: true)),
                        ),
                        circleSize,
                        lottieSize,
                      ),
                      _buildCircularButton(
                        'Tentang\nDeveloper',
                        'assets/backgrounds/about.json',
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutDevPage()),
                        ),
                        circleSize,
                        lottieSize,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Developed by ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Fausan and Anggun',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _launchUrl,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(String text, String assetPath, VoidCallback onTap,
      double circleSize, double lottieSize) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.7),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(7, 7),
                  blurRadius: 7,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  offset: const Offset(-3, -3),
                  blurRadius: 7,
                ),
              ],
            ),
            child: Center(
              child: Lottie.asset(
                assetPath,
                width: lottieSize,
                height: lottieSize,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
