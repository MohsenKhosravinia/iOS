import 'package:flutter/material.dart';

class AnimatedOpacityScreen extends StatefulWidget {
  const AnimatedOpacityScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedOpacityScreen> createState() => _AnimatedOpacityScreenState();
}

class _AnimatedOpacityScreenState extends State<AnimatedOpacityScreen> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInBack,
          opacity: _opacity,
          child: Container(color: Colors.red),
        ),
        onTap: () {
          setState(() {
            _opacity == 0 ? _opacity = 1 : _opacity = 0;
          });
        },
      ),
    );
  }
}
