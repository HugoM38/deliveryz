import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String leftText;
  final String rightText;
  final VoidCallback onPressed;

  const MenuItemWidget({super.key,
    required this.leftText,
    required this.rightText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  rightText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text('Delete',
                    style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
