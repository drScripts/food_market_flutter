part of './widgets.dart';

class FormControl extends StatelessWidget {
  final String? title;
  final bool obsecure;
  final String? placeHolder;
  final TextEditingController? controller;
  final double? marginBottom;
  final Widget? icon;
  final TextInputType? type;
  final bool enabled;
  const FormControl({
    Key? key,
    this.title,
    this.obsecure = false,
    this.placeHolder,
    this.controller,
    this.marginBottom,
    this.icon,
    this.type,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    title!,
                    style: formTitleStyle,
                  ),
                )
              : const SizedBox(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff020202),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              enabled: enabled,
              obscureText: obsecure,
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                hintText: placeHolder,
                border: InputBorder.none,
                hintStyle: formHintStyle,
                icon: icon,
              ),
              cursorColor: Colors.black,
              obscuringCharacter: "*",
            ),
          ),
        ],
      ),
    );
  }
}
