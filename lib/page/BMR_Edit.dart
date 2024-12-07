import 'package:calories_remake/Language/lang.dart';
import 'package:calories_remake/domain/entities/user_info.dart';
import 'package:calories_remake/domain/usecases/get_userInfo_byId.dart';
import 'package:calories_remake/page/Edit_Index_Infomation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMR_Edit extends StatefulWidget {
  late UserInfoEntity userInfoEntity;
  BMR_Edit({required this.userInfoEntity, super.key});

  @override
  State<BMR_Edit> createState() => _BMR_EditState();
}

class _BMR_EditState extends State<BMR_Edit> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  double? bmr;
  double? TDEE;
  double? targetWeight;

  void getUserInfo() async {
    double canNang = widget.userInfoEntity.userWeight;
    double chieuCao = widget.userInfoEntity.userHeight;
    int age = widget.userInfoEntity.age;
    double tinhBMR =
        88.362 + (13.397 * canNang) + (4.799 * chieuCao) - (5.677 * age);
    String formattedBmr = tinhBMR.toStringAsFixed(1);
    setState(() {
      bmr = double.parse(formattedBmr);
      if (widget.userInfoEntity.exerciseIntensity == 'khongTap') {
        TDEE = double.parse((bmr! * 1.2).toStringAsFixed(1));
      } else if (widget.userInfoEntity.exerciseIntensity == 'It') {
        TDEE = double.parse((bmr! * 1.375).toStringAsFixed(1));
      } else if (widget.userInfoEntity.exerciseIntensity == 'Vua') {
        TDEE = double.parse((bmr! * 1.55).toStringAsFixed(1));
      } else {
        TDEE = double.parse((bmr! * 1.725).toStringAsFixed(1));
      }
      //
      if (widget.userInfoEntity.target == 'GiamCan') {
        targetWeight =double.parse((TDEE! - (TDEE! * 0.10)).toStringAsFixed(1)) ;
      } else if (widget.userInfoEntity.exerciseIntensity == 'DuyTri') {
        targetWeight = TDEE;
      } else if (widget.userInfoEntity.exerciseIntensity == 'TangCan') {
        targetWeight =double.parse((TDEE! + 450).toStringAsFixed(1)) ;
      } else {
        targetWeight = TDEE;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25, right: 25, top: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 2.0,
                    spreadRadius: 0.3)
              ],
              color: Theme.of(context).colorScheme.onSecondary),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFE5CAFF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5C0187),
                        ),
                      ),
                    )),
                Text(
                  lang("subHeading2", "BMR"),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        leading: Container(width: 0.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Edit_BMR_Information()));
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
                  child: Text(
                    lang('EditBMR', 'data'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.onSecondary,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0.5, 0.5),
                      blurRadius: 2.0,
                      spreadRadius: 0.7,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            child: Text(
                              'BMR',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0,
                              ),
                            )),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            children: [
                              Text(
                                '$bmr/day',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color(0xFF8915E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade700,
                        )),
                    Container(
                      child: Text(
                        lang('BMRdetail', 'Basal Metabolic Rate'),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.onSecondary,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0.5, 0.5),
                      blurRadius: 2.0,
                      spreadRadius: 0.7,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            child: Text(
                              'TDEE',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0,
                              ),
                            )),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            children: [
                              Text(
                                '$TDEE/day',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color(0xFF8915E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade700,
                        )),
                    Container(
                      child: Text(
                        lang("TDEEdetail", "Total Daily Energy Expenditure"),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.onSecondary,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0.5, 0.5),
                      blurRadius: 2.0,
                      spreadRadius: 0.7,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 7, left: 5),
                            child: Text(
                              'Target',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.0,
                              ),
                            )),
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15, left: 20),
                          child: Column(
                            children: [
                              Text(
                                '$targetWeight/day',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30.0,
                                  color: Color(0xFF8915E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade700,
                        )),
                    Container(
                      child: Text(
                        lang("TargetDetail", "Target"),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
