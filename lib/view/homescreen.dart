import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tira_fe/data/atasan/data_atasan_cubit.dart';
import 'package:tira_fe/data/auth/auth_cubit.dart';
import 'package:tira_fe/data/data_reseller/data_reseller_cubit.dart';
import 'package:tira_fe/data/member/data_member_cubit.dart';
import 'package:tira_fe/utils/constant.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<DataMemberCubit>().fetchMembers();
    context.read<DataAtasanCubit>().fetchAtasans();
    context.read<DataResellerCubit>().fetchDataReseller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final role = state.user.role;
                return Column(
                  children: [
                    Center(
                      child: Text(
                        "Halo ${state.user.name}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontUI.WEIGHT_BOLD,
                        ),
                      ),
                    ),
                    if (role == 'ADMIN') ...[
                      _administrator(),
                    ] else ...[
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Data Reseller",
                                    style: TextStyle(
                                      fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/reseller');
                                    },
                                    child: Text(
                                      "Lihat Semua",
                                      style: PINK_TEXT_STYLE.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _resellerView(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _administrator() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data Member",
                  style: TextStyle(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/member');
                  },
                  child: Text(
                    "Lihat Semua",
                    style: PINK_TEXT_STYLE.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            _memberView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data Atasan",
                  style: TextStyle(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/atasan');
                  },
                  child: Text(
                    "Lihat Semua",
                    style: PINK_TEXT_STYLE.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            _atasanView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data Reseller",
                  style: TextStyle(
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reseller');
                  },
                  child: Text(
                    "Lihat Semua",
                    style: PINK_TEXT_STYLE.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            _resellerView(),
          ],
        ),
      ),
    );
  }

  Widget _atasanView() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: BlocBuilder<DataAtasanCubit, DataAtasanState>(
        builder: (context, state) {
          if (state is DataAtasanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataAtasanLoaded) {
            return ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final dt = state.dataAtasan[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Branch ID:", style: CARD_TEXT),
                            Text("Rep ID:", style: CARD_TEXT),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dt.m_branch_id ?? "", style: TEXT_STYLE),
                            Text(dt.m_rep_id ?? "", style: TEXT_STYLE),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("Name:", style: CARD_TEXT),
                            Text("Manager ID:", style: CARD_TEXT),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dt.m_name ?? "", style: TEXT_STYLE),
                            Text(dt.m_manager_id.toString(), style: TEXT_STYLE),
                          ],
                        ),
                        Text("Current Position:", style: CARD_TEXT),
                        Text(dt.m_current_position ?? "", style: TEXT_STYLE),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is DataAtasanError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: ColorUI.RED),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _memberView() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: BlocBuilder<DataMemberCubit, DataMemberState>(
        builder: (context, state) {
          if (state is DataMemberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataMemberLoaded) {
            return ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final dt = state.dataMember[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Branch ID:", style: CARD_TEXT),
                            Text("Rep ID:", style: CARD_TEXT),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dt.m_branch_id, style: TEXT_STYLE),
                            Text(dt.m_rep_id, style: TEXT_STYLE),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("Name:", style: CARD_TEXT),
                            Text("Manager ID:", style: CARD_TEXT),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dt.m_name, style: TEXT_STYLE),
                            Text(dt.m_manager_id ?? "", style: TEXT_STYLE),
                          ],
                        ),
                        Text("Current Position:", style: CARD_TEXT),
                        Text(dt.m_current_position, style: TEXT_STYLE),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is DataMemberError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: ColorUI.RED),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _resellerView() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: BlocBuilder<DataResellerCubit, DataResellerState>(
        builder: (context, state) {
          if (state is DataResellerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataResellerLoaded) {
            return ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final dt = state.dataReseller[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GPED Name:", style: CARD_TEXT),
                            Text("GEPD ID:", style: CARD_TEXT),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dt.namaGepd, style: TEXT_STYLE),
                            Text(dt.mMstGepd, style: TEXT_STYLE),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("EPD Name:", style: CARD_TEXT),
                            Text("EPD ID:", style: CARD_TEXT),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dt.namaEpd, style: TEXT_STYLE),
                            Text(dt.mMstEpd.toString(), style: TEXT_STYLE),
                          ],
                        ),
                        Text("Reseller Name", style: CARD_TEXT),
                        Text(dt.mName, style: TEXT_STYLE),
                        Text("Branch ID", style: CARD_TEXT),
                        Text(dt.mBranchId, style: TEXT_STYLE),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is DataResellerError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: ColorUI.RED),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
