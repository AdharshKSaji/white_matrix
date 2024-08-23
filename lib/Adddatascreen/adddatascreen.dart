import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:white_matrix/model/productmodel.dart';


class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  XFile? _file;
  String? _imageUrl;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection("products");

  Future<void> _uploadImage() async {
    if (_file == null) return;
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("images/${_file!.name}");
      await imageRef.putFile(File(_file!.path));
      _imageUrl = await imageRef.getDownloadURL();
      print("Image URL: $_imageUrl"); // For debugging
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> _addProduct() async {
    if (_titleController.text.isEmpty ||
        _reviewController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _sellerController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields and upload an image!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _collectionRef.add(ProductModel(
        title: _titleController.text,
        review: _reviewController.text,
        description: _descriptionController.text,
        image: _imageUrl!,
        price: double.parse(_priceController.text),
        seller: _sellerController.text,
        rate: double.parse(_rateController.text),
        quantity: int.parse(_quantityController.text),
      ).toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Successfully added!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 1),
        ),
      );

      // Clear form fields
      _clearForm();
    } catch (e) {
      print("Error adding product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Error adding product. Please try again.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearForm() {
    _titleController.clear();
    _reviewController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _sellerController.clear();
    _rateController.clear();
    _quantityController.clear();
    setState(() {
      _file = null;
      _imageUrl = null;
    });
  }

  Future<void> _pickImage() async {
    // Request storage permission
    final status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Storage permission is required to pick an image.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final picker = ImagePicker();

    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choose Image Source"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: const Text("Gallery"),
          ),
        ],
      ),
    );

    if (imageSource != null) {
      final pickedFile = await picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        setState(() {
          _file = pickedFile;
        });
        await _uploadImage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: _pickImage,
                child: _file != null
                    ? Container(
                        height: 130,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: FileImage(File(_file!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                      )
                    : Container(
                        height: 130,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.add_a_photo, size: 40),
                      ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_titleController, "Enter title"),
              const SizedBox(height: 10),
              _buildTextField(_reviewController, "Enter review"),
              const SizedBox(height: 10),
              _buildTextField(_descriptionController, "Enter description"),
              const SizedBox(height: 10),
              _buildTextField(_sellerController, "Enter seller"),
              const SizedBox(height: 10),
              _buildTextField(_priceController, "Enter price", keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField(_rateController, "Enter rating", keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField(_quantityController, "Enter quantity", keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: const Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
