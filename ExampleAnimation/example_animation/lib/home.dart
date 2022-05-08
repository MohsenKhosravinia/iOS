import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _curveAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _setupAnimations();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, _) {
            return IconButton(
              iconSize: _sizeAnimation.value,
              icon: Icon(
                Icons.accessibility_new_rounded,
                color: _colorAnimation.value,
              ),
              onPressed: () {
                _hasAnimated
                    ? _animationController.reverse()
                    : _animationController.forward();
              },
            );
          },
        ),
      ),
    );
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Curve
    _curveAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    // Color tween
    _colorAnimation = ColorTween(begin: Colors.amber, end: Colors.red)
        .animate(_curveAnimation);

    // Tween sequence
    _sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 70, end: 150), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 150, end: 70), weight: 50),
    ]).animate(_curveAnimation);

    _animationController.addListener(() {
      if (kDebugMode) {
        print('animation: ${_animationController.value}');
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _hasAnimated = true;
      } else {
        _hasAnimated = false;
      }
    });
  }
}
