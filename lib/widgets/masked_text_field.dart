import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MaskedTextField extends StatefulWidget {
  /*
   TextFormField(
   onSaved: (val) {
     cadastroUserReq.pessoa.cpf = val;
     print(cadastroUserReq.pessoa.cpf);
   },
  validator: (val) {
    return Utils.validarCPF(val)
        ? null
        : "Digite o seu CPF valido!";
  },
  decoration: InputDecoration(
    icon: Icon(Icons.picture_in_picture),
    hintText: 'Digite o seu CPF valido',
    labelText: 'CPF',
  ),
  keyboardType: TextInputType.number,
  //maxLength: 11,
  inputFormatters: [
    LengthLimitingTextInputFormatter(11),
    WhitelistingTextInputFormatter.digitsOnly,
  ],
),*/

  final TextEditingController maskedTextFieldController;
  final String mask;
  final String escapeCharacter;
  final int maxLength;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final FocusNode focusNode;
  final ValueChanged<String> onChange;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;

  const MaskedTextField(
      {this.mask,
      this.escapeCharacter: "x",
      this.maskedTextFieldController,
      this.maxLength,
      this.keyboardType: TextInputType.text,
      this.decoration: const InputDecoration(),
      this.focusNode,
      this.onChange,
      this.onSaved,
      this.validator,
      this.inputFormatters});

  @override
  State<StatefulWidget> createState() => new _MaskedTextFieldState();
}

class _MaskedTextFieldState extends State<MaskedTextField> {
  TextEditingController _controller = new TextEditingController();
  FocusNode _textFocus = new FocusNode();
  var lastTextSize = 0; var lastTextValue ="";

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
    _textFocus.addListener(onChange);
  }

  void onChange() {
    bool hasFocus = _textFocus.hasFocus;

    //_controller.text = "45";
    // print(_controller.text);

    if (widget.mask != null) {

      if (_controller.text.length <= widget.mask.length) {

        // its deleting text
        if (_controller.text.length < lastTextSize) {
          if (widget.mask[_controller.text.length] != widget.escapeCharacter) {
            _controller.selection = new TextSelection.fromPosition(
                new TextPosition(offset: _controller.text.length));
          }
        } else {
          // its typing
          if (_controller.text.length >= lastTextSize) {
            var position = _controller.text.length;
            position = position <= 0 ? 1 : position;
            if (position < widget.mask.length - 1) {
              if ((widget.mask[position - 1] != widget.escapeCharacter) &&
                  (_controller.text[position - 1] !=
                      widget.mask[position - 1])) {
                _controller.text = _buildText(_controller.text);
              }

              if (widget.mask[position] != widget.escapeCharacter) {
                _controller.text =
                    "${_controller.text}${widget.mask[position]}";
              }
            }
          }

          // Android on change resets cursor position(cursor goes to 0)
          // so you have to check if it reset, then put in the end(just on android)
          // as IOS bugs if you simply put it in the end
          if (_controller.selection.start < _controller.text.length) {
            _controller.selection = new TextSelection.fromPosition(
                new TextPosition(offset: _controller.text.length));
          }
        }

        // update cursor position
        lastTextSize = _controller.text.length;
        lastTextValue = _controller.text;

      }else{
        _controller.text = lastTextValue;
      }
    } //mask != null

    if (widget.onChange != null) {
      widget.onChange(_controller.text);
    }

  }

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller: _controller,
      //widget.maskedTextFieldController,
      focusNode: _textFocus,
      validator: widget.validator,
      onSaved: widget.onSaved,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      decoration: widget.decoration,
      inputFormatters: widget.inputFormatters,
    );
  }

  String _buildText(String text) {
    var result = "";

    for (int i = 0; i < text.length - 1; i++) {
      result += text[i];
    }

    result += widget.mask[text.length - 1];
    result += text[text.length - 1];

    return result;
  }
}
