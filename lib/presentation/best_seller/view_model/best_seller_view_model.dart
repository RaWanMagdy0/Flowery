import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/entities/best_seller_entity.dart';
import '../../../domain/use_case/home/get_best_seller_products_use_case.dart';
import 'best_seller_state.dart';

@injectable
class BestSellerViewModel extends BaseViewModel<BestSellerState> {
  final GetBestSellerProductsUseCase _bestSellerProductsUseCase;

  BestSellerViewModel(this._bestSellerProductsUseCase)
      : super(BestSellerInitial());

  Future<void> getBestSellers() async {
    emit(BestSellerLoading());

    final response = await _bestSellerProductsUseCase.invoke();

    switch (response) {
      case Success():
        final products = response.data
                ?.map((model) => BestSeller(
                      id: model.id,
                      title: model.title,
                      imageUrl: model.imageUrl,
                      price: model.price,
                      priceAfterDiscount: model.priceAfterDiscount,
                      occasionid: model.occasionid,
                    ))
                .toList() ??
            [];

        emit(BestSellerLoaded(products));
      case Fail():
        emit(BestSellerError(getErrorMassageFromException(response.exception)));
    }
  }
}
