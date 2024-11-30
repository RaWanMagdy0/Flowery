class AddToCartRequestBodyModel {
  final String? productId;
  final String? quantity;

  AddToCartRequestBodyModel({
    this.productId,
    this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
      'quantity': quantity ?? 1,
    };
  }
}
