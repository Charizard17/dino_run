import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final Function onResumePressed;

  const PauseMenu({
    Key? key,
    required this.onResumePressed,
  })  : assert(onResumePressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 70.0,
            vertical: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Paused',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 10),
              IconButton(
                icon: Icon(Icons.play_arrow,
                    size: 30, color: Colors.deepOrangeAccent),
                onPressed: () {
                  onResumePressed();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
