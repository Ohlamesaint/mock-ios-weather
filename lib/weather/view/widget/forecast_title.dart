import 'package:flutter/material.dart';

class ForecastTitle extends StatelessWidget {
  const ForecastTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey[300],
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey[300],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
