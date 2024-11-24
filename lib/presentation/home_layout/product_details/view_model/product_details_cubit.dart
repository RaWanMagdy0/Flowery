import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/data/model/auth/response/produc_details_model.dart';
import 'package:flowery/domain/use_case/home_layout/product_details_use_case.dart';
import 'package:flowery/presentation/home_layout/product_details/view_model/product_details_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends BaseViewModel<ProductDetailsStates> {
  ProductDetailsUseCase useCase;
  ProductDetailsCubit(this.useCase) : super(ProductDetailsInitialState());
  Future<void> getProductDetails({required String productId}) async {
    emit(ProductDetailsLoadingState(loadingMessage: "Loading..."));
    var result = await useCase.invoke(productId: productId);
    switch (result) {
      case Success<ProductDetailsModel?>():
        emit(ProductDetailsSuccessState(success: result.data));
      case Fail<ProductDetailsModel?>():
        emit(ProductDetailsErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}
