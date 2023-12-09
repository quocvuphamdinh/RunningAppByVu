import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/config/res/app_color.dart';
import 'package:running_app_flutter/config/res/app_dimen.dart';

class RunTextDropDownModel {
  String name;
  dynamic value;

  RunTextDropDownModel({required this.name, required this.value});
}

class RunTextDropDown extends StatefulWidget {
  const RunTextDropDown(
      {super.key,
      required this.onSelectedValue,
      this.initValue,
      required this.listOptions,
      this.backgroundColor});

  final Function(dynamic selectedValue) onSelectedValue;
  final dynamic initValue;
  final List<RunTextDropDownModel> listOptions;
  final Color? backgroundColor;

  @override
  State<RunTextDropDown> createState() => _RunTextDropDownState();
}

class _RunTextDropDownState extends State<RunTextDropDown> {
  late dynamic selectedValue;

  @override
  void initState() {
    super.initState();

    selectedValue = widget.initValue ?? widget.listOptions[0].value;
    widget.onSelectedValue(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width,
        padding: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: widget.backgroundColor ?? Colors.grey[300]),
        height: 50.h,
        child: Center(
          child: DropdownButton<dynamic>(
              //itemHeight: 50.h,
              style: TextStyle(fontSize: 16.sp, color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(10.r),
              isExpanded: true,
              items: widget.listOptions
                  .map((e) => DropdownMenuItem<dynamic>(
                      child: Text(e.name), value: e.value))
                  .toList(),
              onChanged: dropDownCallBack,
              value: selectedValue,
              iconSize: AppDimens.iconLargeSize),
        ),
        margin: EdgeInsets.only(bottom: AppDimens.smallSpacingVer));
  }

  void dropDownCallBack(dynamic selectedValue) {
    setState(() {
      this.selectedValue = selectedValue;
      widget.onSelectedValue(this.selectedValue);
    });
  }
}
