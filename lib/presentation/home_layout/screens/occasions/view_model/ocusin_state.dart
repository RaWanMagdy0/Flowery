import '../../../../../data/models/home/occasions/occasions_response_model.dart';
import '../../../../../domain/entities/home_layout/product_details_entity.dart';

abstract class OccasionState {}

class InitialState extends OccasionState {}

class OccasionLoadingState extends OccasionState {}

class OccasionErrorState extends OccasionState {
  final Exception? exception;

  OccasionErrorState(this.exception);
}

class OccasionSuccessState extends OccasionState {
  final List<Occasions>? occasions;

  OccasionSuccessState(this.occasions);
}

class GetOccasionPrudactLoadingState extends OccasionState {}

class GetOccasionPrudactErrorState extends OccasionState {
  final Exception? exception;

  GetOccasionPrudactErrorState(this.exception);
}

class GetOccasionPrudactSuccessState extends OccasionState {
  final List<ProductEntity?>? prudact;

  GetOccasionPrudactSuccessState(this.prudact);
}
