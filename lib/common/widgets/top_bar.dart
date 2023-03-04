import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final String upperTitle;

  const TopBar({
    required this.title,
    required this.upperTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).shadowColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    upperTitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const Spacer(),
            if (upperTitle.isNotEmpty)
              CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                radius: 25,
                child: Center(
                  child: Text(
                    title.substring(0, 1).toUpperCase(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
