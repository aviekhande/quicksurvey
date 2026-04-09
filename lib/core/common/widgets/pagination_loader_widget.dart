import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class PaginationLoaderWidget extends StatelessWidget {
  const PaginationLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kColorPrimaryBg,
      child: Center(
        child: CircularProgressIndicator(color: AppColors.kColorPrimary),
      ),
    );
  }
}
