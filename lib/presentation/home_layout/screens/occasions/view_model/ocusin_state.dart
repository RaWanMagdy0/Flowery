// sealed class OccasionState {}

// class InitialState extends OccasionState {}

// class OccasionLoadingState extends OccasionState {}

// class OccasionErrorState extends OccasionState {
//   Exception? exception;

//   OccasionErrorState(this.exception);
// }

// class OccasionSuccessState extends OccasionState {
//   String? string;
//   OccasionSuccessState(this.string);
// }

import '../../../../../data/models/occasions/occasions_response_model.dart';

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
