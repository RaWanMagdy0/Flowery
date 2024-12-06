import 'package:injectable/injectable.dart';

class CreateOrder {
  CreateOrder({
    this.message,
    this.order,
  });

  String? message;
  Order? order;
}
