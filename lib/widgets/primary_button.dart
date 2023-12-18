import 'package:flutter/material.dart';
import 'package:task_app/widgets/small_text.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const PrimaryButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Adjust this value for desired border radius
            side: const BorderSide(
                color: Colors.grey,
                width: 2), // Change color to your preference
          ),
        ),
        child: SmallText(text: title),
      ),
    );
  }
}
