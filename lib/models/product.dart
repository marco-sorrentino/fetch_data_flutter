class Product {
  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.rating,
      required this.image});

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final Rating rating;
  final String image;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
      description: json["description"],
      category: json["category"],
      rating: Rating.fromJson(json["rating"]),
      image: json["image"],
    );
  }
}

class Rating {
  const Rating({required this.rate, required this.count});

  final double rate;
  final int count;

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json["rate"].toDouble(),
      count: json["count"],
    );
  }
}
