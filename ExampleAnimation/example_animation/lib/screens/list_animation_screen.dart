import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ListAnimationScreen extends StatefulWidget {
  const ListAnimationScreen({Key? key}) : super(key: key);

  @override
  State<ListAnimationScreen> createState() => _ListAnimationScreenState();
}

class _ListAnimationScreenState extends State<ListAnimationScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = [];

  @override
  void initState() {
    super.initState();

    // adding items after the build method is called
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _addItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation animation,
        ) {
          return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ),
              ),
              child: _createCard(index));
        },
      ),
    );
  }

  Card _createCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: SizedBox(
        height: 80,
        child: Center(
          child: Text(
            _items[index],
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  void _addItems() {
    List<String> items = List.generate(10, (index) => 'Item ${++index}');

    // adding item with delay
    items.forEachIndexed(
      (index, element) {
        Future.delayed(Duration(milliseconds: index * 100), () {
          _items.add(element);
          _listKey.currentState?.insertItem(_items.length - 1);
        });
      },
    );
  }
}
