import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/data/model/home/produc_details_model.dart';
import 'package:flowery/domain/use_case/home_layout/product_details_use_case.dart';
import 'package:flowery/presentation/home_layout/product_details/view_model/product_details_states.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/home_layout/product_details_entity.dart';

@injectable
class ProductDetailsCubit extends BaseViewModel<ProductDetailsStates> {
  ProductDetailsUseCase useCase;

  ProductDetailsCubit(this.useCase) : super(ProductDetailsInitialState());

  Future<void> getProductDetails({required String productId}) async {
    emit(ProductDetailsLoadingState(loadingMessage: 'Loading product details...'));
    var result = await useCase.invoke(productId: productId);

    switch (result) {
      case Success<ProductDetailsModel?>():
        var entity = ProductDetailsEntity(
          message: result.data?.message,
          products: result.data?.products
              ?.map((e) => ProductEntity(
            id: e.id,
            title: e.title,
            description: e.description,
            images: e.images,
            price: e.price,
            slug: e.slug,
          ))
              .toList(),
        );
        emit(ProductDetailsSuccessState(success: entity));
        break;

      case Fail<ProductDetailsModel?>():
        emit(ProductDetailsErrorState(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
        break;
    }
  }
}
