import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tira_fe/component/button/custom_button.dart';
import 'package:tira_fe/component/textfield/custom_text_field.dart';
import 'package:tira_fe/data/atasan/data_atasan_cubit.dart';
import 'package:tira_fe/model/atasan/atasan_model.dart';
import 'package:tira_fe/model/atasan/request_atasan.dart';
import 'package:tira_fe/utils/constant.dart';

class AddAtasan extends StatefulWidget {
  const AddAtasan({super.key});

  @override
  State<AddAtasan> createState() => _AddAtasanState();
}

class _AddAtasanState extends State<AddAtasan> {
  final _formKey = GlobalKey<FormState>();
  Atasan? _selectedValue;
  String? _selectPosition;
  final TextEditingController _repIdController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DataAtasanCubit>().fetchAtasans();
    context.read<DataAtasanCubit>().getAtasanGEPD();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorUI.WHITE,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Atasan", style: TEXT_STYLE.copyWith(fontSize: 20)),
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
          DropdownButtonFormField2<String>(
            hint: Text(
              "Position",
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
                return "Position is required";
              }
              return null;
            },
            value: _selectPosition,
            onChanged: (newValue) {
              setState(() {
                _selectPosition = newValue!;
              });
            },
            items: dropdownManager.map((e) {
              return DropdownMenuItem<String>(
                value: e['kode'],
                child: Text(e['name'], style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
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
          _selectPosition == "GEPD"
              ? CustomTextField(readOnly: true, hintText: "Manager")
              : BlocBuilder<DataAtasanCubit, DataAtasanState>(
                  builder: (context, state) {
                    if (state is DataGepdLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DataGepdLoaded) {
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
                    } else if (state is DataGepdError) {
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
          BlocConsumer<DataAtasanCubit, DataAtasanState>(
            listener: (context, state) {
              if (state is DataAtasanCreateSuccess) {
                Navigator.pop(context);
                context.read<DataAtasanCubit>().fetchAtasans();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Success create Atasan",
                      style: WHITE_TEXT_STYLE,
                    ),
                  ),
                );
              } else if (state is DataAtasanCreateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Failed create Atasan",
                      style: WHITE_TEXT_STYLE,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: "Create Atasan",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    CreateAtasanRequest payload = CreateAtasanRequest(
                      mRepId: _repIdController.text.toUpperCase(),
                      mBranchId: _branchIdController.text.toUpperCase(),
                      mName: _nameController.text.toUpperCase(),
                      mCurrentPosition: _selectPosition!,
                      mManagerId: _selectedValue?.m_manager_id,
                    );
                    CreateAtasanRequest payloadGEPD = CreateAtasanRequest(
                      mRepId: _repIdController.text.toUpperCase(),
                      mBranchId: _branchIdController.text.toUpperCase(),
                      mName: _nameController.text.toUpperCase(),
                      mCurrentPosition: _selectPosition!,
                    );

                    _selectedValue == null
                        ? await context.read<DataAtasanCubit>().createAtasan(
                            payloadGEPD,
                          )
                        : await context.read<DataAtasanCubit>().createAtasan(
                            payload,
                          );
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
