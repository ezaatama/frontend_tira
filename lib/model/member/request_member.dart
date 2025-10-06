class CreateMemberRequest {
  final String mRepId;
  final String mBranchId;
  final String mName;
  final String mCurrentPosition;
  final String mManagerId;

  CreateMemberRequest({
    required this.mRepId,
    required this.mBranchId,
    required this.mName,
    required this.mCurrentPosition,
    required this.mManagerId,
  });

  Map<String, dynamic> toMap() => {
    "m_rep_id": mRepId,
    "m_branch_id": mBranchId,
    "m_name": mName,
    "m_current_position": mCurrentPosition,
    "m_manager_id": mManagerId,
  };
}
