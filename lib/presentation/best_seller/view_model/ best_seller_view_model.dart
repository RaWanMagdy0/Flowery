import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/data_source/remote_data_source/best_seller_remote_data_source.dart';
import '../../../data/models/best_seller_model.dart';
import '../../../domain/entities/best_seller_entity.dart';
import 'best_seller_state.dart';

@injectable
class BestSellerViewModel extends Cubit<BestSellerState> {
  final BestSellerRemoteDataSource _dataSource;

  BestSellerViewModel(this._dataSource) : super(BestSellerInitial());

  Future<void> getBestSellers() async {
    emit(BestSellerLoading());

    final result = await _dataSource.getBestSellers();

    if (result is Success<List<BestSellerModel>>) {
      final products = result.data?.map((model) => BestSeller(
        id: model.id,
        title: model.title,
        imageUrl: model.imageUrl,
        price: model.price,
        priceAfterDiscount: model.priceAfterDiscount,
      )).toList() ?? [];

      emit(BestSellerLoaded(products));
    } else if (result is Fail<List<BestSellerModel>>) { // Properly type the Fail case
      final failResult = result as Fail<List<BestSellerModel>>;
      emit(BestSellerError(failResult.exception?.toString() ?? 'Unknown error'));
    }
  }
}