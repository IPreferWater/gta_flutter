import 'package:flutter/material.dart';
import 'package:gta_flutter/model/parameter.dart';

//TODO: to create somewhere else
typedef void BoolCallback(bool value);

class SwitchHave extends StatefulWidget{

  final BoolCallback onSwitch;
   final bool switchBool;

  SwitchHave({@required this.onSwitch, @required this.switchBool});
  _SwitchHaveState createState() => _SwitchHaveState();

}
class _SwitchHaveState extends State<SwitchHave> {
  bool _switch;

  @override
  void initState(){
    _switch = widget.switchBool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SwitchListTile (
      title: Text("Do you have it ?"),
      subtitle: Text(_switch ? "yes":"no"),
      value: _switch,
      onChanged: (value) {
        setState(() {
          _switch = value;
                  });
        widget.onSwitch(value);
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}