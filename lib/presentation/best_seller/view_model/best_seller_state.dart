import '../../../domain/entities/best_seller_entity.dart';

sealed class BestSellerState {}

final class BestSellerInitial extends BestSellerState {}

final class BestSellerLoading extends BestSellerState {}

final class BestSellerLoaded extends BestSellerState {
  final List<BestSeller> products;
  BestSellerLoaded(this.products);
}

final class BestSellerError extends BestSellerState {
  final String message;
  BestSellerError(this.message);
}
