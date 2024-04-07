import 'package:flutter/material.dart';
import 'package:reminderapp/common/pallete.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback voidCallback;

  const CommonButton({
    super.key,
    required this.text,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: voidCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
