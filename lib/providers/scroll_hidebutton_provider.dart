import 'package:flutter/material.dart';

class ScrollHideButton with ChangeNotifier {
  ScrollController _hideButtonCtrl = new ScrollController();
  bool _isVisible = true;

//getter
  get hidebuttonCtrl => _hideButtonCtrl;

//setter

//functions
  hideFAB(ScrollController hideButtonCtrl) {
    hideButtonCtrl.addListener(() {
      if (_hideButtonCtrl.position.atEdge) {
        if (_hideButtonCtrl.position.pixels > 0) if (_isVisible) {
          _isVisible = false;
        }
      } else {
        if (!_isVisible) {
          _isVisible = true;
        }
      }
    });
    notifyListeners();
  }
}
