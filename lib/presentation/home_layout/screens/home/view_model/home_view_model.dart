import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_result.dart';
import '../../../../../core/base/base_view_model.dart';
import '../../../../../domain/entities/home/home_data_entity.dart';
import '../../../../../domain/entities/home/home_discovery_entity.dart';
import '../../../../../domain/use_case/home/get_home_data_use_case.dart';

part 'home_state.dart';

@injectable
class HomeViewModel extends BaseViewModel<HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;

  HomeViewModel(this._getHomeDataUseCase) : super(HomeInitial());

  void getHomeData() async {
    emit(HomeDataLoading());

    final result = await _getHomeDataUseCase.invoke();

    switch (result) {
      case Success():
        final List<HomeDiscovery> discovery = [
          HomeDiscovery(
            id: "1",
            title: "Its time to celebrate all grads with happiness",
            imageUrl:
                'https://images.pexels.com/photos/3171837/pexels-photo-3171837.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
          HomeDiscovery(
            id: "2",
            title: "Discover the perfect birthday gift",
            imageUrl:
                'https://images.pexels.com/photos/3171837/pexels-photo-3171837.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
        ];

        final data = result.data?.copyWith(discovery: discovery);
        emit(HomeDataLoaded(data));

      case Fail():
        emit(
          HomeDataError(getErrorMassageFromException(result.exception)),
        );
    }
  }
}
