import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle? style;
  const RoundedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style:
          style ??
          ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
      onPressed: onPressed,
      child: child,
    );
  }
}
