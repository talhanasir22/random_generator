import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'AllCardsList.dart';
import 'CoinScreen.dart';
import 'DiceScreen.dart';
import 'PageCards.dart';
import 'PlaceHolderScreen.dart';
import 'RandomPasswordScreen.dart';
import 'RouletteScreen.dart';

class PageCardsCoverImage extends StatelessWidget {
  const PageCardsCoverImage({
    required this.pageCards,
    super.key,
    this.height,
  });

  final PageCards pageCards;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToScreen(context, pageCards.id);
      },
      child: SizedBox(
        height: height,
        child: AspectRatio(
          aspectRatio: .75,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(pageCards.assetImage),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 40,
                  offset: Offset(-20, 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String id) {
    Widget destinationScreen;

    switch (id) {
      case '0':
        destinationScreen = RouletteScreen();
        break;
      case '1':
        destinationScreen = DiceScreen();
        break;
      case '2':
        destinationScreen = RandomPasswordScreen();
        break;
      case '3':
        destinationScreen = CoinScreen();
        break;
      default:
        destinationScreen = PlaceholderScreen();
        break;
    }

    Navigator.push(
      context,
      PageTransition(child: destinationScreen, type: PageTransitionType.rightToLeft),
    );
  }
}
