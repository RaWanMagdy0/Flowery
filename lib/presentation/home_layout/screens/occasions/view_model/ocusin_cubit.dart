import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../data/models/home/occasions/occasions_response_model.dart';
import '../../../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../../../domain/use_case/home/occastions/get_occasion_products_use_case.dart';
import '../../../../../domain/use_case/home/occastions/occastions_use_case.dart';
import 'ocusin_state.dart';

@injectable
class OccasionCubit extends BaseViewModel<OccasionState> {
  final OccasionsUseCase occasionsUseCase;
  final GetOccasionProductUseCase getPrudactUseCase;

  OccasionCubit(this.occasionsUseCase, this.getPrudactUseCase)
      : super(InitialState());

  List<ProductEntity?>? prudact = [];

  Future<void> loadFlowers() async {
    emit(OccasionLoadingState());
    var result = await occasionsUseCase.invoke();
    switch (result) {
      case Success<List<Occasions>?>():
        emit(OccasionSuccessState(result.data));
        selectCategory(result.data![0].id!);

      case Fail<List<Occasions>?>():
        emit(OccasionErrorState(result.exception));
    }
  }

  void selectCategory(String id) async {
    emit(GetOccasionPrudactLoadingState());
    prudact = [];
    var result = await getPrudactUseCase.invoke(id);
    switch (result) {
      case Success():
        prudact = result.data;
        emit(GetOccasionPrudactSuccessState());

      case Fail():
        emit(GetOccasionPrudactErrorState(result.exception));
    }
  }
}
