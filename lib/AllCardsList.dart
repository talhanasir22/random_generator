import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'CoinScreen.dart';
import 'DiceScreen.dart';
import 'PageCards.dart';
import 'PlaceHolderScreen.dart';
import 'RandomPasswordScreen.dart';
import 'RouletteScreen.dart';

class AllCardsListView extends StatelessWidget {
  const AllCardsListView({
    required this.pageCards,
    super.key,
  });

  final List<PageCards> pageCards;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'ALL FEATURES',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: pageCards.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final pageCard = pageCards[index];
              return Padding(
                padding: const EdgeInsets.only(right: 25),
                child: GestureDetector(
                  onTap: () {
                    _navigateToScreen(context, pageCard.id);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.asset(
                        pageCard.assetImage,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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