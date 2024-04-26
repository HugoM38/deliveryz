import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final String leftText;
  final VoidCallback onPressed;
  final bool isEnabled;

  const OrderItemWidget({
    required this.leftText,
    required this.onPressed,
    required this.isEnabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            leftText,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          child: Text('Button'),
        ),
      ],
    );
  }
}
