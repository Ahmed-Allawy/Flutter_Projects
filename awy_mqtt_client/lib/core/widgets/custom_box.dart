import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.name,
    required this.img,
    required this.effect,
  });
  final String name;
  final String img;

  final bool effect;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.fill,
                      colorFilter:
                          effect ? const ColorFilter.srgbToLinearGamma() : null,
                    )),
              ),
            ),
            Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
