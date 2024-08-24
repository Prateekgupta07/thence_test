// lib/models/plant.dart
class Plant {
   int id;
   String imageUrl;
   String name;
   double rating;
   int displaySize;
   List<int> availableSize;
   String unit;
   String price;
   String priceUnit;
   String description;

  Plant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.displaySize,
    required this.availableSize,
    required this.unit,
    required this.price,
    required this.priceUnit,
    required this.description,
  });

   factory Plant.fromJson(Map<String, dynamic> json) {
     // Ensure default values for any potentially missing or null fields
     return Plant(
       id: json['id'] ?? 0, // Default to 0 if id is missing
       imageUrl: json['image_url'] ?? '', // Default to empty string if missing
       name: json['name'] ?? '', // Default to empty string if missing
       rating: (json['rating'] ?? 0.0).toDouble(), // Default to 0.0 if missing
       displaySize: json['display_size'] ?? 0, // Default to 0 if missing
       availableSize: json['available_size'] != null
           ? List<int>.from(json['available_size'])
           : [], // Default to empty list if missing
       unit: json['unit'] ?? '', // Default to empty string if missing
       price: json['price'] ?? '', // Default to empty string if missing
       priceUnit: json['price_unit'] ?? '', // Default to empty string if missing
       description: json['description'] ?? '', // Default to empty string if missing
     );
   }
}
