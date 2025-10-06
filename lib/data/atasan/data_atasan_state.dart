part of 'data_atasan_cubit.dart';

sealed class DataAtasanState extends Equatable {
  const DataAtasanState();

  @override
  List<Object> get props => [];
}

final class DataAtasanInitial extends DataAtasanState {}

class DataAtasanLoading extends DataAtasanState {}

class DataAtasanLoaded extends DataAtasanState {
  final List<Atasan> dataAtasan;

  const DataAtasanLoaded(this.dataAtasan);

  @override
  List<Object> get props => [dataAtasan];
}

class DataAtasanError extends DataAtasanState {
  final String message;

  const DataAtasanError(this.message);

  @override
  List<Object> get props => [message];
}

class DataGepdLoading extends DataAtasanState {}

class DataGepdLoaded extends DataAtasanState {
  final List<Atasan> dataAtasan;

  const DataGepdLoaded(this.dataAtasan);

  @override
  List<Object> get props => [dataAtasan];
}

class DataGepdError extends DataAtasanState {
  final String message;

  const DataGepdError(this.message);

  @override
  List<Object> get props => [message];
}

class DataAtasanDetail extends DataAtasanState {}

class DataAtasanDetailSuccess extends DataAtasanState {
  final String message;
  final Atasan newAtasan;

  const DataAtasanDetailSuccess(this.message, this.newAtasan);

  @override
  List<Object> get props => [message, newAtasan];
}

class DataAtasanDetailError extends DataAtasanState {
  final String message;

  const DataAtasanDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DataAtasanCreating extends DataAtasanState {}

class DataAtasanCreateSuccess extends DataAtasanState {
  final String message;
  final Atasan newAtasan;

  const DataAtasanCreateSuccess(this.message, this.newAtasan);

  @override
  List<Object> get props => [message, newAtasan];
}

class DataAtasanCreateError extends DataAtasanState {
  final String message;

  const DataAtasanCreateError(this.message);

  @override
  List<Object> get props => [message];
}

class DataAtasanUpdating extends DataAtasanState {}

class DataAtasanUpdateSuccess extends DataAtasanState {
  final String message;
  final Atasan updatedAtasan;

  const DataAtasanUpdateSuccess(this.message, this.updatedAtasan);

  @override
  List<Object> get props => [message, updatedAtasan];
}

class DataAtasanUpdateError extends DataAtasanState {
  final String message;

  const DataAtasanUpdateError(this.message);

  @override
  List<Object> get props => [message];
}

class DataAtasanDeleting extends DataAtasanState {}

class DataAtasanDeleteSuccess extends DataAtasanState {
  final String deletedAtasanId;

  const DataAtasanDeleteSuccess(this.deletedAtasanId);

  @override
  List<Object> get props => [deletedAtasanId];
}

class DataAtasanDeleteError extends DataAtasanState {
  final String message;

  const DataAtasanDeleteError(this.message);

  @override
  List<Object> get props => [message];
}
