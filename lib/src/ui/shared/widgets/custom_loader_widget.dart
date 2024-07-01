import 'package:flutter/material.dart';

class CustomLoaderPage extends StatelessWidget {
  const CustomLoaderPage({
    super.key,
    required this.isLoading,
  });
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: isLoading
          ? Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox(),
    );
  }
}
