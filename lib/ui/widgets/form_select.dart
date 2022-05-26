part of './widgets.dart';

class FormSelect extends StatelessWidget {
  final List<DropDownModel> listItems;
  final dynamic value;
  final String? placeHolder;
  final String? title;
  final EdgeInsets? margin;
  final Function(dynamic)? onChange;
  const FormSelect({
    Key? key,
    required this.listItems,
    this.value,
    this.title,
    this.placeHolder,
    this.margin,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title ?? "",
                  style: formTitleStyle,
                )
              : const SizedBox(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton(
              isExpanded: true,
              icon: const FaIcon(
                FontAwesomeIcons.angleDown,
                size: 22,
              ),
              items: listItems
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.value,
                      child: Text(e.label),
                    ),
                  )
                  .toList(),
              onChanged: onChange,
              style: formHintStyle.copyWith(
                color: Colors.black,
              ),
              hint: Text(
                placeHolder ?? "",
                style: formHintStyle,
              ),
              value: value,
            ),
          ),
        ],
      ),
    );
  }
}
