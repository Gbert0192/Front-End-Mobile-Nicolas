import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_front_end_nicolas/utils/index.dart';
import 'package:tugas_front_end_nicolas/utils/snackbar.dart';

class ResponsiveAvatarPicker extends StatefulWidget {
  ResponsiveAvatarPicker({
    super.key,
    this.initValue,
    this.onChanged,
    this.isLoading,
  });

  final File? initValue;
  final Function(File?)? onChanged;
  final bool? isLoading;

  @override
  State<ResponsiveAvatarPicker> createState() => _ResponsiveAvatarPickerState();
}

class _ResponsiveAvatarPickerState extends State<ResponsiveAvatarPicker> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          if (widget.onChanged != null) {
            widget.onChanged!(_selectedImage!);
          }
        });
      }
    } catch (e) {
      showFlexibleSnackbar(
        context,
        translate(
          context,
          "Failed to pick image",
          "Gagal memilih gambar",
          "选择图片失败",
        ),
      );
    }
  }

  Widget _buildImageSourceOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    final Color iconColor =
        isDestructive ? Colors.red : const Color(0xFF2C39B8);
    final Color textColor = isDestructive ? Colors.red : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isSmall ? 8 : 10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: isSmall ? 24 : 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isSmall ? 16 : 18,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isSmall ? 12 : 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: isSmall ? 20 : 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showImageSourceBottomSheet(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
            top: 24,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translate(
                    context,
                    "Select Image Source",
                    "Pilih Sumber Gambar",
                    "选择图片来源",
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmall ? 20 : 26,
                  ),
                ),
                SizedBox(height: isSmall ? 16 : 20),
                _buildImageSourceOption(
                  context: context,
                  icon: Icons.camera_alt,
                  title: translate(context, "Camera", "Kamera", "相机"),
                  subtitle: translate(
                    context,
                    "Take a new photo",
                    "Ambil foto baru",
                    "拍摄新照片",
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera, context);
                  },
                ),
                SizedBox(height: isSmall ? 8 : 16),
                _buildImageSourceOption(
                  context: context,
                  icon: Icons.photo_library,
                  title: translate(context, "Gallery", "Galeri", "图库"),
                  subtitle: translate(
                    context,
                    "Choose from gallery",
                    "Pilih dari galeri",
                    "从图库选择",
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery, context);
                  },
                ),
                if (_selectedImage != null) ...[
                  SizedBox(height: 8),
                  const Divider(height: 16),
                  _buildImageSourceOption(
                    context: context,
                    icon: Icons.delete_outline,
                    title: translate(
                      context,
                      "Remove Photo",
                      "Hapus Foto",
                      "删除照片",
                    ),
                    subtitle: translate(
                      context,
                      "Delete current image",
                      "Hapus gambar saat ini",
                      "删除当前图片",
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _selectedImage = null;
                        if (widget.onChanged != null) {
                          widget.onChanged!(null);
                        }
                      });
                    },
                    isDestructive: true,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.height < 700;

    return GestureDetector(
      onTap: () => _showImageSourceBottomSheet(context),
      child: Stack(
        children: [
          CircleAvatar(
            radius: isSmall ? 70 : 100,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
            child:
                _selectedImage == null
                    ? Icon(
                      Icons.person,
                      size: isSmall ? 80 : 100,
                      color: Colors.grey[400],
                    )
                    : null,
          ),
          !(widget.isLoading ?? false)
              ? Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  height: isSmall ? 30 : 45,
                  width: isSmall ? 30 : 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1E5B),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 16,
                    onPressed: () => _showImageSourceBottomSheet(context),
                    icon: Icon(
                      _selectedImage == null ? Icons.photo_camera : Icons.edit,
                    ),
                    color: Colors.white,
                  ),
                ),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
