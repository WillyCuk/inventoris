import 'dart:io';

import 'package:atk_inventoris/provider/itemlist.dart';
import 'package:atk_inventoris/utils/itemtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../utils/mypagebutton.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'Please choose media to upload',
              style: GoogleFonts.quicksand(),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * .13,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.image),
                        Text(
                          'From Gallery',
                          style: GoogleFonts.quicksand(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.camera),
                        Text(
                          'From Camera',
                          style: GoogleFonts.quicksand(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemBrandController = TextEditingController();
  final TextEditingController _itemTypeController = TextEditingController();
  final TextEditingController _itemDescController = TextEditingController();
  final TextEditingController _itemQtyController = TextEditingController();
  final TextEditingController _itemUnitController = TextEditingController();

  // String _dropDownValue = "1";
  // var _items = ['1', 'Pcs', 'Rim'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Add Item")),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              ItemTextField(text: "Item Name", controller: _itemNameController),
              const SizedBox(height: 25),
              ItemTextField(
                  text: "Item Brand", controller: _itemBrandController),
              const SizedBox(height: 25),
              ItemTextField(text: "Item Type", controller: _itemTypeController),
              const SizedBox(height: 25),
              ItemTextField(
                  text: "Item Description", controller: _itemDescController),
              const SizedBox(height: 25),
              ItemTextField(
                  text: "Item Quantity", controller: _itemQtyController),
              const SizedBox(height: 15),
              ItemTextField(text: "Item Unit", controller: _itemUnitController),
              const SizedBox(height: 15),
              Center(
                child: MyPageButton(
                    width: MediaQuery.of(context).size.width * .7,
                    height: 50,
                    text: "UPLOAD IMAGE",
                    onPressed: () {
                      myAlert();
                    }),
              ),
              const SizedBox(height: 15),
              image == null
                  ? Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      width: MediaQuery.of(context).size.width * .7,
                      height: MediaQuery.of(context).size.height * .15,
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      height: MediaQuery.of(context).size.height * .15,
                      child: Center(
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyPageButton(
                      width: MediaQuery.of(context).size.width * .25,
                      height: 50,
                      text: "CONFIRM",
                      onPressed: () {
                        context.read<ItemList>().addItem(
                            itemName: _itemNameController.text,
                            itemBrand: _itemBrandController.text,
                            itemType: _itemTypeController.text,
                            itemDesc: _itemDescController.text,
                            itemQty: int.parse(_itemQtyController.text),
                            itemUnit: _itemUnitController.text,
                            itemImg: image != null
                                ? image!
                                : "assets/whitebackground.jpeg");
                        Navigator.pop(context);
                      }),
                  const SizedBox(width: 20),
                  MyPageButton(
                      width: MediaQuery.of(context).size.width * .25,
                      height: 50,
                      text: "CANCEL",
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          )),
    );
  }
}
