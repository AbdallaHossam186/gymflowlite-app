import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Color? bgColor;
  const RoundedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.bgColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style:
          style ??
          ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? theme.primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor:
                (bgColor ?? theme.primaryColor).withValues(alpha: 0.6),
            disabledForegroundColor: Colors.white70,
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
