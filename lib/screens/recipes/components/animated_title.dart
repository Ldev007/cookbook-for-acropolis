import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    Key key,
    @required this.currentTitle,
    @required this.pastTitle,
  }) : super(key: key);

  final String currentTitle;
  final String pastTitle;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Text.rich(
        TextSpan(
          text: currentTitle.substring(0, currentTitle.length - 4),
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline3.fontSize,
            color: Colors.green[400],
            fontWeight: FontWeight.w200,
          ),
          children: [
            TextSpan(
              text: currentTitle.substring(currentTitle.length - 4),
              style: TextStyle(
                color: Colors.green[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      secondChild: Text(pastTitle),
      duration: Duration(milliseconds: 500),
      crossFadeState: CrossFadeState.showFirst,
    );
  }
}
