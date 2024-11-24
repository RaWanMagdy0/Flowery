class BestSellerModel {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final int priceAfterDiscount;

  BestSellerModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        imageUrl = json['imgCover'],
        price = json['price'],
        priceAfterDiscount = json['priceAfterDiscount'];
}