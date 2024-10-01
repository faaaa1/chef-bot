import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDevPage extends StatelessWidget {
  const AboutDevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'About Developer',
          style: TextStyle(
            color: Color.fromARGB(255, 11, 1, 5),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset('assets/backgrounds/back_anim.json'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: const SizedBox(),
            ),
          ),
          const AboutDevBody(),
        ],
      ),
    );
  }
}

class AboutDevBody extends StatelessWidget {
  const AboutDevBody({super.key});

  void _launchWhatsApp() async {
    const phoneNumber =
        '6282251891347'; // Replace with your actual phone number
    const message = 'Assalamualaikum';
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: const AssetImage('assets/icon.png'),
            backgroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Muh. Fausan,\nAnggun Setia Dewi",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Flutter Developer",
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Passionate about creating innovative mobile applications using Flutter. "
            "Experienced in developing user-friendly and efficient solutions.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: _launchWhatsApp,
            child: const Text(
              "Contact Us",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
