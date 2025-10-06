import 'package:equatable/equatable.dart';

class Atasan extends Equatable {
  final String? m_branch_id;
  final String? m_rep_id;
  final String? m_name;
  final String? m_current_position;
  final String? m_manager_id;
  final Manager? manager;

  const Atasan({
    this.m_branch_id,
    this.m_rep_id,
    this.m_name,
    this.m_current_position,
    this.m_manager_id,
    this.manager,
  });

  factory Atasan.fromJson(Map<String, dynamic> json) {
    return Atasan(
      m_branch_id: json['m_branch_id'],
      m_rep_id: json['m_rep_id'],
      m_name: json['m_name'],
      m_current_position: json['m_current_position'],
      m_manager_id: json['m_manager_id'],
      manager: json["manager"] != null
          ? Manager.fromJson(json["manager"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'm_branch_id': m_branch_id,
      'm_rep_id': m_rep_id,
      'm_name': m_name,
      'm_current_position': m_current_position,
      'm_manager_id': m_manager_id,
      'manager': manager?.toJson(),
    };
  }

  Atasan copyWith({
    String? m_branch_id,
    String? m_rep_id,
    String? m_name,
    String? m_current_position,
    String? m_manager_id,
    Manager? manager,
  }) {
    return Atasan(
      m_branch_id: m_branch_id ?? this.m_branch_id,
      m_rep_id: m_rep_id ?? this.m_rep_id,
      m_name: m_name ?? this.m_name,
      m_current_position: m_current_position ?? this.m_current_position,
      m_manager_id: m_manager_id ?? this.m_manager_id,
      manager: manager ?? this.manager,
    );
  }

  @override
  List<Object?> get props => [
    m_branch_id,
    m_rep_id,
    m_name,
    m_current_position,
    m_manager_id,
    manager,
  ];
}

class Manager extends Equatable {
  final String? m_branch_id;
  final String? m_rep_id;
  final String? m_name;
  final String? m_current_position;
  final String? m_manager_id;

  const Manager({
    this.m_branch_id,
    this.m_rep_id,
    this.m_name,
    this.m_current_position,
    this.m_manager_id,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
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

  Manager copyWith({
    String? m_branch_id,
    String? m_rep_id,
    String? m_name,
    String? m_current_position,
    String? m_manager_id,
  }) {
    return Manager(
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

final List<Map<String, dynamic>> dropdownManager = [
  {"kode": "GEPD", "name": "General Manager"},
  {"kode": "EPD", "name": "Manager"},
];
