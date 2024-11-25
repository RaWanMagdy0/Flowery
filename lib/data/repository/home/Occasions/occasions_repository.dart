import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../../domain/repository/home/occastions/occastons_repository.dart';
import '../../../data_source/remote_data_source/home/occastions/occastions_emote_data_sourcse.dart';
import '../../../models/occasions/occasions_response_model.dart';

@Injectable(as: OccasionsRepository)
class OccasionsRepositoryImpl extends OccasionsRepository {
  final OccastionsRmoteDataSourcse occasionsDataSource;

  OccasionsRepositoryImpl({required this.occasionsDataSource});

  @override
  Future<Result<List<Occasions>?>> getOccasions() async {
    final result = await occasionsDataSource.getOccasions();
    switch (result) {
      case Success():
        return Success<List<Occasions>?>(data: result.data?.occasions);
      case Fail():
        return Fail(exception: result.exception);
    }
  }

  @override
  Future<Result<List<ProductEntity>?>> getOccasionsPrudact() async {
    final result = await occasionsDataSource.getOccasionsPrudact();
    switch (result) {
      case Success():
        log('data: ${result.data}', name: 'Occasions Repository');

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
        log('products: ${result.data}',
            name: 'Occasions Repository -- Products');
        return Success<List<ProductEntity>?>(data: products);
      case Fail():
        return Fail(exception: result.exception);
    }
  }
}
