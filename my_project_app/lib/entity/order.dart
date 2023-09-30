class Order {
  final int orderitemId;
  final int orderId;
  final int userId;
  final int productId;
  final int sizeId;
  final int colorId;
  final int boughtAmount;

  const Order({
    required this.orderitemId,
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.sizeId,
    required this.colorId,
    required this.boughtAmount,
  });

  factory Order.fromJSON(Map<String, dynamic> json) {
    return Order(
      orderitemId: json["order_item_id"],
      orderId: json["order_id"],
      userId: json["user_id"],
      productId: json["product_id"],
      sizeId: json["size_id"],
      colorId: json["color_id"],
      boughtAmount: json["bought_amount"],
    );
  }
}
