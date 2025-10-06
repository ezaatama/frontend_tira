import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tira_fe/component/button/custom_button.dart';
import 'package:tira_fe/component/textfield/custom_text_field.dart';
import 'package:tira_fe/data/atasan/data_atasan_cubit.dart';
import 'package:tira_fe/data/member/data_member_cubit.dart';
import 'package:tira_fe/model/atasan/atasan_model.dart';
import 'package:tira_fe/model/member/request_member.dart';
import 'package:tira_fe/utils/constant.dart';

class UpdateMember extends StatefulWidget {
  const UpdateMember({super.key, required this.mRepId});

  final String mRepId;

  @override
  State<UpdateMember> createState() => _UpdateMemberState();
}

class _UpdateMemberState extends State<UpdateMember> {
  final _formKey = GlobalKey<FormState>();
  Atasan? _selectedValue;
  Atasan? existingManager;
  final TextEditingController _repIdController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DataAtasanCubit>().fetchAtasans();
    context.read<DataMemberCubit>().detailMember(widget.mRepId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Member", style: TEXT_STYLE.copyWith(fontSize: 20)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Lengkapi data dibawah ini untuk mengubah data member.",
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
    return BlocConsumer<DataMemberCubit, DataMemberState>(
      listener: (context, state) {
        if (state is DataMemberUpdateSuccess) {
          Navigator.pop(context);
          context.read<DataMemberCubit>().fetchMembers();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Success update member", style: WHITE_TEXT_STYLE),
            ),
          );
        } else if (state is DataMemberUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed update member", style: WHITE_TEXT_STYLE),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DataMemberDetail) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DataMemberDetailSuccess) {
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
                        ..text = state.newMember.m_rep_id,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                  ],
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
                        ..text = state.newMember.m_branch_id,
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
                        ..text = state.newMember.m_name,
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
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  hintText: "EPC",
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
                BlocBuilder<DataAtasanCubit, DataAtasanState>(
                  builder: (context, stateAtasan) {
                    if (stateAtasan is DataAtasanLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (stateAtasan is DataAtasanLoaded) {
                      final atasans = stateAtasan.dataAtasan;

                      // Set nilai awal existingManager jika belum diset
                      existingManager ??= atasans.firstWhere(
                        (atasan) =>
                            atasan.m_rep_id == state.newMember.m_manager_id,
                        orElse: () => atasans.first, // fallback biar gak null
                      );

                      // Pastikan _selectedValue ada di dalam list items
                      final currentValue = atasans.firstWhere(
                        (a) =>
                            a.m_rep_id ==
                            (_selectedValue?.m_rep_id ??
                                existingManager?.m_rep_id),
                        orElse: () => existingManager!,
                      );
                      return DropdownButtonFormField2<Atasan>(
                        hint: Text(
                          "Manager",
                          style: HINT_TEXT_STYLE.copyWith(fontSize: 14),
                        ),
                        isExpanded: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorUI.TEXT_HINT,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorUI.PINK),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorUI.RED),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorUI.RED),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          filled: true,
                          fillColor: ColorUI.WHITE,
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "Manager is required";
                          }
                          return null;
                        },
                        value: currentValue,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedValue = newValue;
                          });
                        },
                        items: stateAtasan.dataAtasan.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              "${e.m_name} | ${e.m_rep_id}",
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                      );
                    } else if (stateAtasan is DataAtasanError) {
                      return Center(
                        child: Text(
                          stateAtasan.message,
                          style: const TextStyle(color: ColorUI.RED),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                //Submit
                const SizedBox(height: 30),

                CustomButton(
                  text: "Update Member",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final selectedManager = _selectedValue ?? existingManager;

                      if (selectedManager == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select a manager first"),
                            backgroundColor: ColorUI.RED,
                          ),
                        );
                        return;
                      }

                      CreateMemberRequest payload = CreateMemberRequest(
                        mRepId: _repIdController.text.toUpperCase(),
                        mBranchId: _branchIdController.text.toUpperCase(),
                        mName: _nameController.text.toUpperCase(),
                        mCurrentPosition: "EPC",
                        mManagerId: selectedManager.m_rep_id!,
                      );

                      debugPrint("rep id: ${payload.mRepId}");
                      debugPrint("branch id: ${payload.mBranchId}");
                      debugPrint("name: ${payload.mName}");
                      debugPrint(
                        "current position: ${payload.mCurrentPosition}",
                      );
                      debugPrint("manager id: ${payload.mManagerId}");

                      await context.read<DataMemberCubit>().updateMember(
                        widget.mRepId,
                        payload,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        } else if (state is DataMemberDetailError) {
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
