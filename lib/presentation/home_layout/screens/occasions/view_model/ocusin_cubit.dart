// import 'package:flowery/core/base/base_view_model.dart';
// import 'package:flowery/data/models/occasions/occasions_response_model.dart';
// import 'package:flowery/domain/use_case/auth/home/occastions/occastions_use_case.dart';
// import 'package:flowery/presentation/home_layout/screens/occasions/view_model/ocusin_state.dart';

// import '../../../../../core/api/api_result.dart';

// class OccasionCubit extends BaseViewModel<OccasionState> {
//   OccasionCubit(this.occasionsUseCase) : super(InitialState());
//   final OccasionsUseCase occasionsUseCase;
//   Occasion() async {
//     emit(OccasionLoadingState());
//     var result = await occasionsUseCase.invoke();
//     switch (result) {
//       case Success<List<Occasions>?>():
//         emit(OccasionSuccessState(result.data as String?));
//       case Fail<List<Occasions>?>():
//         emit(OccasionErrorState(result.exception));
//     }
//   }
// }

import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/data/models/occasions/occasions_response_model.dart';
import 'package:flowery/domain/use_case/auth/home/occastions/occastions_use_case.dart';
import 'package:injectable/injectable.dart';

import 'ocusin_state.dart';

@injectable
class OccasionCubit extends BaseViewModel<OccasionState> {
  final OccasionsUseCase occasionsUseCase;

  OccasionCubit(this.occasionsUseCase) : super(InitialState());

  Future<void> loadFlowers() async {
    emit(OccasionLoadingState());
    var result = await occasionsUseCase.invoke();
    switch (result) {
      case Success<List<Occasions>?>():
        print(result.data?.length);
        emit(OccasionSuccessState(result.data as List<Occasions>?));

      case Fail<List<Occasions>?>():
        emit(OccasionErrorState(result.exception));
    }
  }

  void selectCategory(int index) {}
}
