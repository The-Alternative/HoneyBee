import '../../model/MedicineInfo.dart';
import 'package:flutter/material.dart';

import 'medicine_card.dart';

class MedicinesList extends StatelessWidget {
  final List<MedicineInfo> listOfMedicines;
  final Function setData;
  MedicinesList(this.listOfMedicines,this.setData);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => MedicineCard(listOfMedicines[index],setData),
      itemCount: listOfMedicines.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
