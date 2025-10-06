class CreateAtasanRequest {
  final String mRepId;
  final String mBranchId;
  final String mName;
  final String mCurrentPosition;
  final String? mManagerId;

  CreateAtasanRequest({
    required this.mRepId,
    required this.mBranchId,
    required this.mName,
    required this.mCurrentPosition,
    this.mManagerId,
  });

  Map<String, dynamic> toMap() => {
    "m_rep_id": mRepId,
    "m_branch_id": mBranchId,
    "m_name": mName,
    "m_current_position": mCurrentPosition,
    if (mManagerId != null) 'm_manager_id': mManagerId,
  };
}

class UpdateAtasanRequest {
  final String mBranchId;
  final String mName;

  UpdateAtasanRequest({required this.mBranchId, required this.mName});

  Map<String, dynamic> toMap() => {"m_branch_id": mBranchId, "m_name": mName};
}
