import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tira_fe/data/atasan/data_atasan_cubit.dart';
import 'package:tira_fe/utils/constant.dart';

class DataAtasan extends StatefulWidget {
  const DataAtasan({super.key});

  @override
  State<DataAtasan> createState() => _DataAtasanState();
}

class _DataAtasanState extends State<DataAtasan> {
  @override
  void initState() {
    super.initState();
    context.read<DataAtasanCubit>().fetchAtasans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Data Atasan", style: TEXT_STYLE.copyWith(fontSize: 20)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: BlocConsumer<DataAtasanCubit, DataAtasanState>(
            listener: (context, state) {
              if (state is DataAtasanDeleteSuccess) {
                context.read<DataAtasanCubit>().fetchAtasans();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Success delete atasan")),
                );
              } else if (state is DataAtasanDeleteError) {
                context.read<DataAtasanCubit>().fetchAtasans();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Failed delete atasan")));
              }
            },
            builder: (context, state) {
              if (state is DataAtasanLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataAtasanLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add-atasan').then((_) {
                          context.read<DataAtasanCubit>().fetchAtasans();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorUI.PRIMARY,
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        "Tambah Atasan +",
                        style: WHITE_TEXT_STYLE.copyWith(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListView.builder(
                          itemCount: state.dataAtasan.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final dt = state.dataAtasan[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Branch ID:", style: CARD_TEXT),
                                        Text("Rep ID:", style: CARD_TEXT),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dt.m_branch_id ?? "",
                                          style: TEXT_STYLE,
                                        ),
                                        Text(
                                          dt.m_rep_id ?? "",
                                          style: TEXT_STYLE,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text("Name:", style: CARD_TEXT),
                                        Text("Manager ID:", style: CARD_TEXT),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dt.m_name ?? "",
                                          style: TEXT_STYLE,
                                        ),
                                        Text(
                                          dt.m_manager_id.toString(),
                                          style: TEXT_STYLE,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Current Position:",
                                              style: CARD_TEXT,
                                            ),
                                            Text(
                                              dt.m_current_position ?? "",
                                              style: TEXT_STYLE,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/update-atasan',
                                                  arguments: dt.m_rep_id,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: ColorUI.GREEN,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                bool?
                                                shouldDelete = await showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                    title: Text(
                                                      "Delete Atasan",
                                                    ),
                                                    content: Text(
                                                      "Are you sure you want to delete ${dt.m_name}?",
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(false),
                                                        child: Text("Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(true),
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                            color: ColorUI.RED,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );

                                                if (shouldDelete == true) {
                                                  await context
                                                      .read<DataAtasanCubit>()
                                                      .deleteAtasan(
                                                        dt.m_rep_id!,
                                                      );
                                                }
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: ColorUI.RED,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
