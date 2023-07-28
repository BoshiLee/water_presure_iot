import 'package:flutter/material.dart';

class DashBoardCard extends StatelessWidget {
  final EdgeInsets? margin;
  final Widget child;
  const DashBoardCard({
    super.key,
    required this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xfff2f4f7),
            blurRadius: 0.3,
            offset: Offset(1.8, 1.8),
          )
        ],
      ),
      child: child,
    );
  }
}
