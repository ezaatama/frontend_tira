import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final String m_branch_id;
  final String m_rep_id;
  final String m_name;
  final String m_current_position;
  final String? m_manager_id;

  const Member({
    required this.m_branch_id,
    required this.m_rep_id,
    required this.m_name,
    required this.m_current_position,
    this.m_manager_id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      m_branch_id: json['m_branch_id'],
      m_rep_id: json['m_rep_id'],
      m_name: json['m_name'],
      m_current_position: json['m_current_position'],
      m_manager_id: json['m_manager_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'm_branch_id': m_branch_id,
      'm_rep_id': m_rep_id,
      'm_name': m_name,
      'm_current_position': m_current_position,
      'm_manager_id': m_manager_id,
    };
  }

  Member copyWith({
    String? m_branch_id,
    String? m_rep_id,
    String? m_name,
    String? m_current_position,
    String? m_manager_id,
  }) {
    return Member(
      m_branch_id: m_branch_id ?? this.m_branch_id,
      m_rep_id: m_rep_id ?? this.m_rep_id,
      m_name: m_name ?? this.m_name,
      m_current_position: m_current_position ?? this.m_current_position,
      m_manager_id: m_manager_id ?? this.m_manager_id,
    );
  }

  @override
  List<Object?> get props => [
    m_branch_id,
    m_rep_id,
    m_name,
    m_current_position,
    m_manager_id,
  ];
}
