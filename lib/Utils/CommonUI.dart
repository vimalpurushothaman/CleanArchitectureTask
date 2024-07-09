import 'Allimports.dart';


class CommonUI{

  Widget text({
    required String? text,
    double fontSize = 15,
    double letterSpacing = 15,
    TextAlign? textAlign = TextAlign.start,
    fontWeight = FontWeight.w500,
    color = Colors.black,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 0,
    TextDecoration decoration=TextDecoration.none,
    double lineHeight = 0.0,
  }) {
    return MediaQuery(
      data: MediaQuery.of(AppDataHelper.rootContext!).copyWith(textScaleFactor: 1.0),

      child: Text(
        text!,
        overflow: overflow,
        textAlign: textAlign, maxLines: maxLines == 0 ? null : maxLines,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: AppThemeManager.defaultFont,
            decoration:decoration ,
            fontWeight: fontWeight,
            overflow: overflow,
            height: lineHeight,

            letterSpacing: 0.1),
      ),
    );
  }

  Widget headertext({
    required String? text,
    double fontSize = 15,
    double letterSpacing = 15,
    TextAlign? textAlign = TextAlign.start,
    fontWeight = FontWeight.w500,
    color = Colors.black,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 0,
    TextDecoration decoration=TextDecoration.none,
    double lineHeight = 0.0,
  }) {
    return MediaQuery(
      data: MediaQuery.of(AppDataHelper.rootContext!).copyWith(textScaleFactor: 1.0),

      child: Text(
        text!,
        overflow: overflow,
        textAlign: textAlign, maxLines: maxLines == 0 ? null : maxLines,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            decoration:decoration ,
            fontWeight: fontWeight,
            overflow: overflow,
            height: lineHeight,

            letterSpacing: 0.1),
      ),
    );
  }

  static Widget formField({
    required TextEditingController editingController,
    required String hinttext,
    Key? key,
    String? prefix = "",
    bool? enabled = true,
    bool readOnly = false,
    TextStyle hintstyle = const TextStyle(color: Colors.black),
    bool? isBorder = false,
    AutovalidateMode? autovalidateMode,
    List? inputFormatters,
    TextInputType? keyboardType,
    textInputAction,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    textAlign,
    focusNode,
    int? maxLength,
    onEditingComplete,
    onFieldSubmitted,
    TextCapitalization? textCapitalization,
    bool obscureText = false,
    Color? fillColor = AppTheme.textFillColor,
    void Function(String?)? onChanged,
    // int? maxLines,

    style,
    OutlineInputBorder? disabledBorder,
    Widget? sIcon,
    double contentpadding = 15.0,
  }) {
    bool pref = prefix == "";
    return TextFormField(
      // maxLines: maxLines,
      onChanged: onChanged,
      enabled: enabled,
      key: key,
      readOnly: readOnly,
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: editingController,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      obscureText: obscureText,
      inputFormatters: keyboardType == TextInputType.number
      // ?[FilteringTextInputFormatter.allow(RegExp(r'\d'))]:
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : keyboardType == TextInputType.name
          ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))]
          : [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9.,@\-\s]'))
      ],
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentpadding),
        // border: InputBorder.none,

        filled: true,
        fillColor: fillColor!.withOpacity(0.8),
        hoverColor: AppTheme.primaryColor1,
        isDense: true,
        hintText: hinttext,
        hintStyle: hintstyle,
        counterText: "",
        suffixIcon: sIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: isBorder!
                ? const BorderSide(
              color: AppTheme.textFillColor,
            )
                : BorderSide.none),
        // prefix: Text(prefix!),
      ),
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontFamily: AppThemeManager.defaultFontMetro,
          fontSize: 11.0.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3.sp),
      // style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  static Widget buttonContainer({
    required VoidCallback onPressed,
    //   required String text,
    required Widget file,
    double width = 30,
    double height = 6.5,
    double fontsize = 10,
    double letterspacing = 2,
    Color color=AppTheme.primaryColor1,
    Color gradientfirst = AppTheme.primaryColor1,
    Color gradientsecond = AppTheme.primaryColor2,
    double radius=6.0,
}){
    return  GestureDetector(
      onTap: onPressed,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientfirst, gradientsecond],
              begin: Alignment.centerLeft,
              end: Alignment.topRight,
            ),
            border: Border.all(color:color ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: file),
    );
  }
  Widget buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: (Colors.grey[300])!,
      highlightColor: (Colors.grey[100])!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5, // Number of shimmering items
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              width: double.infinity,
              height: 15.h,
              color: Colors.white, // Placeholder color
            ),
          );
        },
      ),
    );
  }

}