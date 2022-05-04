part of coming_soon_view;

class _ComingSoonMobile extends StatelessWidget {
  final ComingSoonViewModel viewModel;

  const _ComingSoonMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) => OverflowBox(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const MobileTopBar(),
              Column(
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  const MobileSubLongText(),
                  SizedBox(
                    height: 45.h,
                  ),
                  const MobileCountDownTimer(),
                  SizedBox(
                    height: 45.h,
                  ),
                  MobileTextFieldAndSubmitButton(viewModel: viewModel),
                ],
              ),
              const MobileBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileTopBar extends StatelessWidget {
  const MobileTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200.h,
                  child: Image.asset(
                    'assets/images/png/Group mobile 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 70.h,
                  left: 0.w,
                  right: 100.w,
                  top: 0.h,
                  child: SizedBox(
                    child: Image.asset(
                      'assets/images/png/Mind-Spa-Logo-Green.png',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                      height: 172.h,
                      width: 196.67.w,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SelectableText(
                'Coming Soon',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48.sp, letterSpacing: 5.w),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileSubLongText extends StatelessWidget {
  const MobileSubLongText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
      ),
      child: SelectableText(
        'We are creating an avenue to provide access to holistic health and promote mental wellbeing towards the eradication of mental health problems in Africa by connecting users to the most relevant resources tailored to their mental health needs.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          height: 2,
          color: const Color(0XFF516D61),
        ),
      ),
    );
  }
}

class MobileTextFieldAndSubmitButton extends StatefulWidget {
  const MobileTextFieldAndSubmitButton({Key? key, required this.viewModel})
      : super(key: key);
  final ComingSoonViewModel viewModel;
  @override
  State<MobileTextFieldAndSubmitButton> createState() =>
      _MobileTextFieldAndSubmitButtonState();
}

class _MobileTextFieldAndSubmitButtonState
    extends State<MobileTextFieldAndSubmitButton> {
  final _formKey = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();
  final OutlineInputBorder textFieldStyling = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: BorderSide(
      color: const Color(0XFF516D61),
      width: 2.0.w,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: TextFormField(
              showCursor: true,
              validator: context.validateEmailAddress,
              controller: emailAddressController,
              cursorColor: const Color(0XFF516D61),
              cursorRadius: const Radius.circular(10),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: textFieldStyling,
                enabledBorder: textFieldStyling.copyWith(
                    borderSide: BorderSide(width: 1.w)),
                focusedBorder: textFieldStyling,
                errorBorder: textFieldStyling.copyWith(
                    borderSide: const BorderSide(
                  color: Colors.red,
                )),
                filled: true,
                hintText: ' johndoe@gmail.com',
                hintStyle: const TextStyle(
                    fontSize: 18, decorationStyle: TextDecorationStyle.wavy),
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.only(left: 33.w),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 45.h,
        ),
        GestureDetector(
          onTap: () => widget.viewModel.subscribeUserToMailingList(
            email: emailAddressController.text,
          ),
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 21.w),
            duration: const Duration(seconds: 10),
            decoration: BoxDecoration(
              color: const Color(0XFF516D61),
              borderRadius: BorderRadius.circular(15.r),
            ),
            constraints: BoxConstraints.tightFor(
              height: 50,
              width: MediaQuery.of(context).size.width.clamp(240.0.w, 560.0.w),
            ),
            child: FittedBox(
              child: widget.viewModel.isBusy
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : widget.viewModel.subscriptionSuccessful
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Text(
                          'Join Waitlist',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16.31.sp),
                        ),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileCountDownTimer extends ViewModelWidget<ComingSoonViewModel> {
  const MobileCountDownTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ComingSoonViewModel viewModel) {
    final countDownText = [
      viewModel.days,
      viewModel.hours,
      viewModel.minutes,
      viewModel.seconds,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i <= 3; i++)
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0XFF516D61),
                  ),
                ),
                child: SelectableText(
                  countDownText[i] ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0XFF516D61),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SelectableText(
                countDownDays[i],
                style: TextStyle(
                  fontSize: 18.62.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0XFF516D61),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class MobileBottomBar extends StatelessWidget {
  const MobileBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/png/Group mobile 3.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
