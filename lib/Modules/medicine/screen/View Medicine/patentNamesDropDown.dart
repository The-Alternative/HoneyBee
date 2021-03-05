import '../../../../utils/notifiredb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDropDown extends StatefulWidget {
  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ChangeNotifierProvider<CountryProvider>(
        create: (context) => CountryProvider(),
        child: Container(
          width: 215,
          child: Consumer<CountryProvider>(builder: (_, provider, __) {
            return DropdownButton<String>(
              hint: Text("Not selected"),
              icon: Icon(Icons.flight),
              value: dropdownValue,
              onChanged: (String newValue) {
                provider.setSelectedItem(newValue);
                dropdownValue = provider.selected;
                print(newValue);
              },
              items:
                  provider.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          }),
        ));
  }
}
