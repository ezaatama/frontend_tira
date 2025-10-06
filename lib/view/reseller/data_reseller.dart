import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:tira_fe/data/auth/auth_cubit.dart';
import 'package:tira_fe/data/data_reseller/data_reseller_cubit.dart';
import 'package:tira_fe/data/data_reseller/download_data_cubit.dart';
import 'package:tira_fe/utils/constant.dart';

class DataReseller extends StatefulWidget {
  const DataReseller({super.key});

  @override
  State<DataReseller> createState() => _DataResellerState();
}

class _DataResellerState extends State<DataReseller> {
  @override
  void initState() {
    super.initState();
    context.read<DataResellerCubit>().fetchDataReseller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Data Reseller", style: TEXT_STYLE.copyWith(fontSize: 20)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: BlocBuilder<DataResellerCubit, DataResellerState>(
            builder: (context, state) {
              if (state is DataResellerLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataResellerLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthAuthenticated) {
                          final role = state.user.role;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (role == 'ADMIN') ...[
                                _downloadButton(),
                              ] else ...[
                                Text(
                                  'User role only view data reseller',
                                  style: BLACK_TEXT_STYLE.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontUI.WEIGHT_BOLD,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListView.builder(
                          itemCount: state.dataReseller.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final dt = state.dataReseller[index];
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
                                        Text("GPED Name:", style: CARD_TEXT),
                                        Text("GEPD ID:", style: CARD_TEXT),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(dt.namaGepd, style: TEXT_STYLE),
                                        Text(dt.mMstGepd, style: TEXT_STYLE),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("EPD Name:", style: CARD_TEXT),
                                        Text("EPD ID:", style: CARD_TEXT),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(dt.namaEpd, style: TEXT_STYLE),
                                        Text(
                                          dt.mMstEpd.toString(),
                                          style: TEXT_STYLE,
                                        ),
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
                        ),
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }

  Widget _downloadButton() {
    return BlocConsumer<DownloadDataCubit, DownloadDataState>(
      listener: (context, state) {
        if (state is DownloadDataSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'File saved: ${state.file.path.split('/').last}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Open',
                onPressed: () => OpenFile.open(state.filePath),
              ),
            ),
          );
        } else if (state is DownloadDataError) {
          // Show error snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Download Sales Data Excel',
              style: TextStyle(fontSize: 18, fontWeight: FontUI.WEIGHT_BOLD),
            ),
            Text(
              'Export all sales data to Excel format',
              style: TextStyle(color: ColorUI.TEXT),
            ),
            const SizedBox(height: 8),
            if (state is DownloadDataLoading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Downloading Excel file...'),
                ],
              )
            else
              ElevatedButton(
                onPressed: () {
                  context.read<DownloadDataCubit>().downloadSalesExcel();
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
                  "Download Data",
                  style: WHITE_TEXT_STYLE.copyWith(fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
