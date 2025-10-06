part of 'data_reseller_cubit.dart';

sealed class DataResellerState extends Equatable {
  const DataResellerState();

  @override
  List<Object> get props => [];
}

final class DataResellerInitial extends DataResellerState {}

class DataResellerLoading extends DataResellerState {}

class DataResellerLoaded extends DataResellerState {
  final List<DataReseller> dataReseller;

  const DataResellerLoaded(this.dataReseller);

  @override
  List<Object> get props => [dataReseller];
}

class DataResellerError extends DataResellerState {
  final String message;

  const DataResellerError(this.message);

  @override
  List<Object> get props => [message];
}
