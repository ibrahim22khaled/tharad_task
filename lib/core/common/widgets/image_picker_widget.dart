import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tharad_task/core/values/app_colors.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(String imagePath) onImageSelected;
  final void Function(String error) onError;
  final String? initialImageUrl;

  const ImagePickerWidget({
    super.key,
    required this.onImageSelected,
    required this.onError,
    this.initialImageUrl,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? _imagePath;
  bool _hasError = false;

  static const _maxSizeInBytes = 5 * 1024 * 1024; // 5MB
  static const _allowedExtensions = ['jpg', 'jpeg', 'png'];

  Future<void> _pickImage(ImageSource source) async {
    final tr = AppLocalizations.of(context)!;
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;

    final extension = picked.path.split('.').last.toLowerCase();
    if (!_allowedExtensions.contains(extension)) {
      setState(() => _hasError = true);
      widget.onError(tr.allowedFiles);
      return;
    }

    final file = File(picked.path);
    final sizeInBytes = await file.length();
    if (sizeInBytes > _maxSizeInBytes) {
      setState(() => _hasError = true);
      widget.onError(tr.maxSize);
      return;
    }

    setState(() {
      _imagePath = picked.path;
      _hasError = false;
    });
    widget.onImageSelected(picked.path);
  }

  void _showSourcePicker(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(tr.gallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(tr.camera),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final borderColor = _hasError ? AppColors.error : AppColors.authtextColor;
    final hasLocalImage = _imagePath != null;
    final hasNetworkImage =
        !hasLocalImage && (widget.initialImageUrl?.isNotEmpty ?? false);

    return GestureDetector(
      onTap: () => _showSourcePicker(context),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(8),
          color: borderColor,
          strokeWidth: 1.5,
          dashPattern: const [10, 8],
        ),
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.appTextFormFieldFillColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: hasLocalImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_imagePath!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : hasNetworkImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.initialImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) {
                      debugPrint(
                        'Profile image load failed: $error, url: $url',
                      );
                      return _placeholder(tr, borderColor);
                    },
                  ),
                )
              : _placeholder(tr, borderColor),
        ),
      ),
    );
  }

  Widget _placeholder(AppLocalizations tr, Color borderColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.icons.camera,
          colorFilter: ColorFilter.mode(borderColor, BlendMode.srcIn),
        ),
        const SizedBox(height: 8),
        Text(
          tr.allowedFiles,
          style: TextStyle(
            fontSize: 12,
            color: _hasError ? AppColors.error : AppColors.gray300,
          ),
        ),
        Text(
          tr.imageSize,
          style: TextStyle(
            fontSize: 12,
            color: _hasError ? AppColors.error : AppColors.gray300,
          ),
        ),
      ],
    );
  }
}
