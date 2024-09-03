import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_parllete.dart';
import 'package:task_manager/core/ui/widgets/feedback/app_loader.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    this.onPressed,
    this.child,
    this.loading = false,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
          onPressed: onPressed == null || loading
              ? null
              : () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor:
                loading ? AppPallete.greyColor : AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
            foregroundColor: AppPallete.whiteColor,
          ),
          child: loading ? AppLoader.circularLoader : child),
    );
  }
}
