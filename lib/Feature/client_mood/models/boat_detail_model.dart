class OwnerInfo {
  final String name;
  final String imageUrl;
  final String joinedDate;

  OwnerInfo({
    required this.name,
    required this.imageUrl,
    required this.joinedDate,
  });
}

class MarinaLocation {
  final String description;
  final double latitude;
  final double longitude;
  final String mapImageUrl;

  MarinaLocation({
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.mapImageUrl,
  });
}

class SimilarBoat {
  final String id;
  final String name;
  final String imageUrl;
  final String boatType;
  final String petsInfo;
  final double pricePerDay;
  final double? pricePerHour;

  SimilarBoat({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.boatType,
    required this.petsInfo,
    required this.pricePerDay,
    this.pricePerHour,
  });
}

class BoatDetailModel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;

  final OwnerInfo owner;

  final String boatType;
  final String make;
  final String model;
  final int year;
  final bool hasPets;
  final int capacity;

  final double pricePerDay;
  final double? pricePerHour;

  final String aboutBoat;
  final String minMaxDaysLabel;

  final MarinaLocation marina;

  final String boatRules;
  final String cancellationPolicy;

  final List<SimilarBoat> similarBoats;

  bool isFavorite;

  BoatDetailModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.owner,
    required this.boatType,
    required this.make,
    required this.model,
    required this.year,
    required this.hasPets,
    required this.capacity,
    required this.pricePerDay,
    this.pricePerHour,
    required this.aboutBoat,
    required this.minMaxDaysLabel,
    required this.marina,
    required this.boatRules,
    required this.cancellationPolicy,
    this.similarBoats = const [],
    this.isFavorite = false,
  });
}