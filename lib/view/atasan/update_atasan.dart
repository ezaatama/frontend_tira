import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tira_fe/component/button/custom_button.dart';
import 'package:tira_fe/component/textfield/custom_text_field.dart';
import 'package:tira_fe/data/atasan/data_atasan_cubit.dart';
import 'package:tira_fe/data/member/data_member_cubit.dart';
import 'package:tira_fe/model/atasan/atasan_model.dart';
import 'package:tira_fe/model/atasan/request_atasan.dart';
import 'package:tira_fe/model/member/request_member.dart';
import 'package:tira_fe/utils/constant.dart';

class UpdateAtasan extends StatefulWidget {
  const UpdateAtasan({super.key, required this.mRepId});

  final String mRepId;

  @override
  State<UpdateAtasan> createState() => _UpdateAtasanState();
}

class _UpdateAtasanState extends State<UpdateAtasan> {
  final _formKey = GlobalKey<FormState>();
  Atasan? existingManager;
  final TextEditingController _repIdController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DataAtasanCubit>().detailAtasan(widget.mRepId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Atasan", style: TEXT_STYLE.copyWith(fontSize: 20)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Lengkapi data dibawah ini untuk mengubah data atasan.",
                  textAlign: TextAlign.center,
                  style: TEXT_STYLE.copyWith(
                    fontSize: 14,
                    fontWeight: FontUI.WEIGHT_SEMI_BOLD,
                  ),
                ),
                const SizedBox(height: 10),
                _formContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formContent() {
    return BlocConsumer<DataAtasanCubit, DataAtasanState>(
      listener: (context, state) {
        if (state is DataAtasanUpdateSuccess) {
          Navigator.pop(context);
          context.read<DataAtasanCubit>().fetchAtasans();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Success update atasan", style: WHITE_TEXT_STYLE),
            ),
          );
        } else if (state is DataAtasanUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed update atasan", style: WHITE_TEXT_STYLE),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DataAtasanDetail) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DataAtasanDetailSuccess) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //REP
                Text(
                  "Rep ID",
                  style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 15,
                    fontWeight: FontUI.WEIGHT_NORMAL,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller:
                      _repIdController.text.isEmpty
                            ? _repIdController
                            : _repIdController
                        ..text = state.newAtasan.m_rep_id!,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                  ],
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Rep ID is required";
                    }
                    if (value.length != 7) {
                      return "Rep ID must be exactly 7 characters";
                    }
                    return null;
                  },
                  hintText: "Rep Id",
                ),

                //BRANCH
                const SizedBox(height: 10),
                Text(
                  "Branch ID",
                  style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 15,
                    fontWeight: FontUI.WEIGHT_NORMAL,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller:
                      _branchIdController.text.isEmpty
                            ? _branchIdController
                            : _branchIdController
                        ..text = state.newAtasan.m_branch_id!,
                  inputFormatters: [LengthLimitingTextInputFormatter(3)],
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Branch ID is required";
                    }
                    if (value.length != 3) {
                      return "Branch ID must be exactly 3 characters";
                    }
                    return null;
                  },
                  hintText: "Branch Id",
                ),

                //NAME
                const SizedBox(height: 10),
                Text(
                  "Name",
                  style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 15,
                    fontWeight: FontUI.WEIGHT_NORMAL,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller:
                      _nameController.text.isEmpty
                            ? _nameController
                            : _nameController
                        ..text = state.newAtasan.m_name!,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  hintText: "Name",
                ),

                //POSITION
                const SizedBox(height: 10),
                Text(
                  "Position",
                  style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 15,
                    fontWeight: FontUI.WEIGHT_NORMAL,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller:
                      _positionController.text.isEmpty
                            ? _positionController
                            : _positionController
                        ..text = state.newAtasan.m_current_position!,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  hintText: "Position",
                  hintStyle: BLACK_TEXT_STYLE,
                ),

                //Manager
                const SizedBox(height: 10),
                Text(
                  "Manager",
                  style: BLACK_TEXT_STYLE.copyWith(
                    fontSize: 15,
                    fontWeight: FontUI.WEIGHT_NORMAL,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  controller: TextEditingController(
                    text:
                        '${state.newAtasan.manager!.m_name} (${state.newAtasan.manager!.m_rep_id})',
                  ),
                  hintText: "Manager",
                  hintStyle: BLACK_TEXT_STYLE,
                ), //Submit
                const SizedBox(height: 30),

                CustomButton(
                  text: "Update Atasan",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UpdateAtasanRequest payload = UpdateAtasanRequest(
                        mBranchId: _branchIdController.text.toUpperCase(),
                        mName: _nameController.text.toUpperCase(),
                      );

                      await context.read<DataAtasanCubit>().updateAtasan(
                        widget.mRepId,
                        payload,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        } else if (state is DataAtasanDetailError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: ColorUI.RED),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
