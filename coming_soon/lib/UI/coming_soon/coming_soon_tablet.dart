part of coming_soon_view;

class _ComingSoonTablet extends StatelessWidget {
  final ComingSoonViewModel viewModel;

  const _ComingSoonTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(834, 1194),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) => OverflowBox(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              const TabletTopBar(),
              Column(
                children: [
                  const TabletSubLongText(),
                  SizedBox(
                    height: 45.h,
                  ),
                  const TabletCountDownTimer(),
                  SizedBox(
                    height: 45.h,
                  ),
                  TabletTextFieldAndSubmitButton(viewModel: viewModel),
                ],
              ),
              const TabletBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class TabletTopBar extends StatelessWidget {
  const TabletTopBar({
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
                  height: 300.h,
                  child: Image.asset(
                    'assets/images/png/Group 1028.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  'assets/images/png/Mind-Spa-Logo-Green.png',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  height: 172.h,
                  width: 196.67.w,
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
                style: TextStyle(
                  fontSize: 94.sp,
                  letterSpacing: 5.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabletSubLongText extends StatelessWidget {
  const TabletSubLongText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 127.w,
      ),
      child: SelectableText(
        'We are creating an avenue to provide access to holistic health and promote mental wellbeing towards the eradication of mental health problems in Africa by connecting users to the most relevant resources tailored to their mental health needs.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.sp,
          height: 2,
          color: const Color(0XFF516D61),
        ),
      ),
    );
  }
}

class TabletTextFieldAndSubmitButton extends StatefulWidget {
  const TabletTextFieldAndSubmitButton({Key? key, required this.viewModel})
      : super(key: key);
  final ComingSoonViewModel viewModel;
  @override
  State<TabletTextFieldAndSubmitButton> createState() =>
      _TabletTextFieldAndSubmitButtonState();
}

class _TabletTextFieldAndSubmitButtonState
    extends State<TabletTextFieldAndSubmitButton> {
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
            padding: EdgeInsets.symmetric(horizontal: 57.w),
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
            margin: EdgeInsets.symmetric(horizontal: 57.w),
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
                          style:
                              TextStyle(color: Colors.white, fontSize: 24.sp),
                        ),
            ),
          ),
        ),
      ],
    );
  }
}

class TabletCountDownTimer extends ViewModelWidget<ComingSoonViewModel> {
  const TabletCountDownTimer({Key? key}) : super(key: key);

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
                padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0XFF516D61),
                  ),
                ),
                child: SelectableText(
                  countDownText[i] ?? '',
                  style: TextStyle(
                    fontSize: 28.22.sp,
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

class TabletBottomBar extends StatelessWidget {
  const TabletBottomBar({
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
            'assets/images/png/Group 667.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
