part of 'data_member_cubit.dart';

sealed class DataMemberState extends Equatable {
  const DataMemberState();

  @override
  List<Object> get props => [];
}

final class DataMemberInitial extends DataMemberState {}

class DataMemberLoading extends DataMemberState {}

class DataMemberLoaded extends DataMemberState {
  final List<Member> dataMember;

  const DataMemberLoaded(this.dataMember);

  @override
  List<Object> get props => [dataMember];
}

class DataMemberError extends DataMemberState {
  final String message;

  const DataMemberError(this.message);

  @override
  List<Object> get props => [message];
}

class DataMemberDetail extends DataMemberState {}

class DataMemberDetailSuccess extends DataMemberState {
  final String message;
  final Member newMember;

  const DataMemberDetailSuccess(this.message, this.newMember);

  @override
  List<Object> get props => [message, newMember];
}

class DataMemberDetailError extends DataMemberState {
  final String message;

  const DataMemberDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DataMemberCreating extends DataMemberState {}

class DataMemberCreateSuccess extends DataMemberState {
  final String message;
  final Member newMember;

  const DataMemberCreateSuccess(this.message, this.newMember);

  @override
  List<Object> get props => [message, newMember];
}

class DataMemberCreateError extends DataMemberState {
  final String message;

  const DataMemberCreateError(this.message);

  @override
  List<Object> get props => [message];
}

class DataMemberUpdating extends DataMemberState {}

class DataMemberUpdateSuccess extends DataMemberState {
  final String message;
  final Member updatedMember;

  const DataMemberUpdateSuccess(this.message, this.updatedMember);

  @override
  List<Object> get props => [message, updatedMember];
}

class DataMemberUpdateError extends DataMemberState {
  final String message;

  const DataMemberUpdateError(this.message);

  @override
  List<Object> get props => [message];
}

class DataMemberDeleting extends DataMemberState {}

class DataMemberDeleteSuccess extends DataMemberState {
  final String deletedMemberId;

  const DataMemberDeleteSuccess(this.deletedMemberId);

  @override
  List<Object> get props => [deletedMemberId];
}

class DataMemberDeleteError extends DataMemberState {
  final String message;

  const DataMemberDeleteError(this.message);

  @override
  List<Object> get props => [message];
}
