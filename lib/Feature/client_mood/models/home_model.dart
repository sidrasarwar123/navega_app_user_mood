/// A destination shown in the "Popular Locations" horizontal list.
class PopularLocation {
  final String name;
  final String imagePath;

  const PopularLocation({
    required this.name,
    required this.imagePath,
  });
}

/// A boat listing shown in the "Recommended Boats" horizontal list.
class BoatListing {
  final String title;
  final String imagePath;
  final double rating;
  final String tag;
  final double price;
  final String currency;
  final String priceUnit;
  bool isFavorite;

  BoatListing({
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.tag,
    required this.price,
    this.currency = 'US\$',
    this.priceUnit = '/ day',
    this.isFavorite = false,
  });
}