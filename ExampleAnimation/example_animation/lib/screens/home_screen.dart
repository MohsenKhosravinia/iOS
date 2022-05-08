import 'package:example_animation/screens/list_animation_screen.dart';
import 'package:example_animation/screens/pulse_animation_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return ListTile(
                title: const Text('Pulse animation'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PulseAnimationScreen()),
                  );
                },
              );
            case 1:
              return ListTile(
                title: const Text('List animation'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListAnimationScreen()),
                  );
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
