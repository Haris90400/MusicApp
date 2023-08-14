import 'package:flutter/material.dart';

import 'colors.dart';

ourStyle({family = "bold", double? size = 14.0, color = whiteColor}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}
