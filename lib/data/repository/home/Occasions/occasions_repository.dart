import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/data/data_source/remote_data_source/home/occastions/occastions_emote_data_sourcse.dart';
import 'package:flowery/data/models/occasions/occasions_response_model.dart';
import 'package:flowery/domain/entities/best_seller_entity.dart';
import 'package:flowery/domain/repository/home/occastions/occastons_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionsRepository)
class OccasionsRepositoryImpl extends OccasionsRepository {
  final OccastionsRmoteDataSourcse occasionsDataSource;

  OccasionsRepositoryImpl({required this.occasionsDataSource});

  @override
  Future<Result<List<Occasions>?>> GetOccasions() async {
    final result = await occasionsDataSource.GetOccasions();
    switch (result) {
      case Success():
        return Success<List<Occasions>?>(data: result.data?.occasions);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<List<BestSeller>>> getOccasionsPrudact() async {
    final result = await occasionsDataSource.getOccasionsPrudact();
    switch (result) {
      case Success():
        final products = result.data
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
        return Success(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
