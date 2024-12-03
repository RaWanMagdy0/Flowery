import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../domain/repository/home/occasions_repository.dart';
import '../../data_sources/remote_data_source/home/occasions/occasions_remote_data_sourcse.dart';
import '../../models/home/occasions/occasions_response_model.dart';

@Injectable(as: OccasionsRepository)
class OccasionsRepositoryImpl extends OccasionsRepository {
  final OccastionsRmoteDataSourcse occasionsDataSource;

  OccasionsRepositoryImpl(this.occasionsDataSource);

  @override
  Future<Result<List<Occasions>?>> getAllOccasions() async {
    final result = await occasionsDataSource.getOccasions();
    switch (result) {
      case Success():
        return Success<List<Occasions>?>(data: result.data?.occasions);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<List<ProductEntity>?>> getOccasionProducts(String id) async {
    final result = await occasionsDataSource.getOccasionsPrudact(id);
    switch (result) {
      case Success():
        final products = result.data
                ?.map((model) => ProductEntity(
                      id: model.id,
                      title: model.title,
                      imgCover: model.imgCover,
                      price: model.price,
                      priceAfterDiscount: model.priceAfterDiscount,
                      occasion: model.occasion,
                      category: model.category,
                      description: model.description,
                      images: model.images,
                      quantity: model.quantity,
                      slug: model.slug,
                    ))
                .toList() ??
            [];

        return Success<List<ProductEntity>?>(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
