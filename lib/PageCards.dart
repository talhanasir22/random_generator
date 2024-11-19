class PageCards {
  const PageCards({
    required this.id,
    required this.assetImage,
    required this.description,
  });
  final String id;
  final String assetImage;
  final String description;
  static final List<PageCards> fakePageCardsValues = List.generate( // Corrected typo
    4,

        (index) => PageCards(
      id: '$index',
      assetImage: 'assets/Images/Images${index + 1}.png',
      description:
      ' ',
    ),
  ); // PageCards
} // List.generate
