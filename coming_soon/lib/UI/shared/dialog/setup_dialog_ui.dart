import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../utilities/enums/app_enums.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.success: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        SuccessDialog(request: request, completer: completer),
    DialogType.error: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        ErrorDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class SuccessDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const SuccessDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3))
          .then((value) => widget.completer(DialogResponse(confirmed: true)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 255, 248),
            borderRadius: BorderRadius.all(
              Radius.circular(24.r),
            )),
        height: size.height * 0.50,
        width: size.width * 0.50,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.check_circle,
                size: 150,
                color: Color(0XFF516D61),
              ),
              Text(
                'Thank you for opting into our waitlist, you will be notified when there is an early build.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: const Color(0XFF516D61)),
              ),
              Text(
                'You will be redirected to our blog site.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20.sp,
                    color: const Color(0XFF516D61)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const ErrorDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(24.r),
          ),
        ),
        height: size.height * 0.50,
        width: size.width * 0.50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.error_outline_outlined,
                size: 150.h,
                color: const Color(0XFF516D61),
              ),
              Text(
                request.title ?? 'Something went wrong, pls try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: const Color(0XFF516D61)),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.r))),
                height: 50,
                onPressed: () => completer(DialogResponse(confirmed: true)),
                child: Text(
                  'Try again',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                color: const Color(0XFF516D61),
              )
            ],
          ),
        ),
      ),
    );
  }
}
