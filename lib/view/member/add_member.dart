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

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  Atasan? _selectedValue;
  final TextEditingController _repIdController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DataAtasanCubit>().fetchAtasans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        title: Text("Add Member", style: TEXT_STYLE.copyWith(fontSize: 20)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Lengkapi data dibawah ini untuk menambahkan data member.",
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
            controller: _repIdController,
            inputFormatters: [LengthLimitingTextInputFormatter(7)],
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
            controller: _branchIdController,
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
            controller: _nameController,
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
            builder: (context, state) {
              if (state is DataAtasanLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataAtasanLoaded) {
                return DropdownButtonFormField2<Atasan>(
                  hint: Text(
                    "Manager",
                    style: HINT_TEXT_STYLE.copyWith(fontSize: 14),
                  ),
                  isExpanded: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: ColorUI.TEXT_HINT),
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
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
                    iconSize: 24,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Manager is required";
                    }
                    return null;
                  },
                  value: _selectedValue,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                  items: state.dataAtasan.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        "${e.m_name} | ${e.m_rep_id}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
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

          //Submit
          const SizedBox(height: 30),
          BlocConsumer<DataMemberCubit, DataMemberState>(
            listener: (context, state) {
              if (state is DataMemberCreateSuccess) {
                Navigator.pop(context);
                context.read<DataMemberCubit>().fetchMembers();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Success create member",
                      style: WHITE_TEXT_STYLE,
                    ),
                  ),
                );
              } else if (state is DataMemberCreateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Failed create member",
                      style: WHITE_TEXT_STYLE,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: "Create Member",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    CreateMemberRequest payload = CreateMemberRequest(
                      mRepId: _repIdController.text.toUpperCase(),
                      mBranchId: _branchIdController.text.toUpperCase(),
                      mName: _nameController.text.toUpperCase(),
                      mCurrentPosition: "EPC",
                      mManagerId: _selectedValue!.m_manager_id!,
                    );

                    await context.read<DataMemberCubit>().createMember(payload);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
