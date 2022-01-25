import 'package:flutter/material.dart';

class HUD extends StatelessWidget {
  final Function onPausePressed;
  final ValueNotifier<int> life;

  const HUD({Key? key, required this.onPausePressed, required this.life})
      : assert(onPausePressed != null),
        assert(life != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.pause, size: 30, color: Colors.white),
            onPressed: () {
              onPausePressed();
            },
          ),
          ValueListenableBuilder(
            valueListenable: life,
            builder: (context, int value, child) {
              final list = <Widget>[];
              list.add(Text(
                '${life.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ));
              for (int i = 0; i < 5; ++i) {
                list.add(
                  Icon(
                    (i < value) ? Icons.favorite : Icons.favorite_border,
                    color: Colors.deepOrangeAccent,
                  ),
                );
              }
              return Row(
                children: list,
              );
            },
          )
        ],
      ),
    );
  }
}
