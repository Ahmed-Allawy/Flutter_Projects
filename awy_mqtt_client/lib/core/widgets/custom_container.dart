import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.secondWidget,
    required this.label,
  });
  final String label;
  final Widget secondWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          secondWidget,
        ],
      ),
    );
  }
}
