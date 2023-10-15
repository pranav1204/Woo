import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo/providers/user_provider.dart';
import 'package:woo/utils/global_variables.dart';

class Responsive_Layout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const Responsive_Layout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  State<Responsive_Layout> createState() => _Responsive_LayoutState();
}

class _Responsive_LayoutState extends State<Responsive_Layout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData()async{
      UserProvider _userProvider = Provider.of(context, listen: false);
      await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint){
          if(constraint.maxHeight > webScreenSize){
            return widget.webScreenLayout;
          }
          else{
            return widget.mobileScreenLayout;
          }
        }
    );
  }
}
