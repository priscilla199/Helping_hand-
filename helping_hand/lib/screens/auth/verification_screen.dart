import 'package:flutter/material.dart';
// import 'dart:io';
import '../../widgets/custom_button.dart';
import '../../utils/constants.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _bioController = TextEditingController();
  
  bool _isLoading = false;
  bool _isUploading = false;
  String? _selectedDocumentType;
  // File? _nationalIdImage;
  // File? _selfieImage;
  String? _uploadedNationalIdUrl;
  String? _uploadedSelfieUrl;

  @override
  void dispose() {
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isNationalId) async {
    // TODO: Implement image picker
    // For now, we'll simulate image selection
    setState(() {
      _isUploading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate upload
      
      if (mounted) {
        setState(() {
          if (isNationalId) {
            _uploadedNationalIdUrl = 'https://example.com/national_id.jpg';
          } else {
            _uploadedSelfieUrl = 'https://example.com/selfie.jpg';
          }
          _isUploading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image: ${e.toString()}'),
            backgroundColor: AppConstants.errorColor,
          ),
        );
      }
    }
  }

  Future<void> _handleVerification() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDocumentType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a document type'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
      return;
    }
    if (_uploadedNationalIdUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your ID document'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
      return;
    }
    if (_uploadedSelfieUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your selfie'),
          backgroundColor: AppConstants.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement verification submission
      await Future.delayed(const Duration(seconds: 3)); // Simulate API call
      
      if (mounted) {
        // Show success message and navigate
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification submitted successfully! We\'ll review and get back to you soon.'),
            backgroundColor: AppConstants.successColor,
          ),
        );
        
        // Navigate to home screen
        Navigator.pushReplacementNamed(context, AppConstants.routeHome);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${e.toString()}'),
            backgroundColor: AppConstants.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Identity Verification',
          style: TextStyle(color: AppConstants.textPrimaryColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppConstants.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryLightColor,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusXL),
                        border: Border.all(color: AppConstants.primaryColor, width: 2),
                      ),
                      child: Icon(
                        Icons.verified_user,
                        size: 40,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingL),
                    Text(
                      'Verify Your Identity',
                      style: AppConstants.headingStyle.copyWith(
                        fontSize: 24,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingS),
                    Text(
                      'Complete verification to access all features',
                      style: AppConstants.captionStyle.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.spacingXXL),

                // Document Type Selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Document Type *',
                      style: AppConstants.subheadingStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: AppConstants.spacingM),
                    DropdownButtonFormField<String>(
                      value: _selectedDocumentType,
                      decoration: InputDecoration(
                        labelText: 'Select document type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                          borderSide: const BorderSide(color: AppConstants.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
                        ),
                      ),
                      items: AppConstants.verificationDocuments.map((String document) {
                        return DropdownMenuItem<String>(
                          value: document,
                          child: Text(document),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDocumentType = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a document type';
                        }
                        return null;
                      },
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.spacingL),

                // National ID Upload
                _buildImageUploadSection(
                  title: 'Upload ID Document *',
                  subtitle: 'Upload a clear photo of your ${_selectedDocumentType ?? 'ID document'}',
                  icon: Icons.credit_card,
                  imageUrl: _uploadedNationalIdUrl,
                  onTap: () => _pickImage(true),
                  isUploading: _isUploading,
                ),

                const SizedBox(height: AppConstants.spacingL),

                // Selfie Upload
                _buildImageUploadSection(
                  title: 'Upload Selfie *',
                  subtitle: 'Take a clear photo of yourself holding your ID',
                  icon: Icons.camera_alt,
                  imageUrl: _uploadedSelfieUrl,
                  onTap: () => _pickImage(false),
                  isUploading: _isUploading,
                ),

                const SizedBox(height: AppConstants.spacingL),

                // Address Field
                TextFormField(
                  controller: _addressController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter your current address',
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                      borderSide: const BorderSide(color: AppConstants.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                      borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppConstants.spacingL),

                // Bio Field
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Bio (Optional)',
                    hintText: 'Tell us a bit about yourself...',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                      borderSide: const BorderSide(color: AppConstants.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                      borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.spacingL),

                // Info Box
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacingM),
                  decoration: BoxDecoration(
                    color: AppConstants.infoColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                    border: Border.all(color: AppConstants.infoColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppConstants.infoColor,
                        size: 24,
                      ),
                      const SizedBox(width: AppConstants.spacingM),
                      Expanded(
                        child: Text(
                          'Your verification will be reviewed within 24-48 hours. We\'ll notify you once approved.',
                          style: TextStyle(
                            color: AppConstants.infoColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.spacingL),

                // Submit Button
                PrimaryButton(
                  text: 'Submit Verification',
                  onPressed: _handleVerification,
                  isLoading: _isLoading,
                  isFullWidth: true,
                ),

                const SizedBox(height: AppConstants.spacingL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection({
    required String title,
    required String subtitle,
    required IconData icon,
    String? imageUrl,
    required VoidCallback onTap,
    required bool isUploading,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppConstants.subheadingStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(height: AppConstants.spacingS),
        Text(
          subtitle,
          style: AppConstants.captionStyle,
        ),
        const SizedBox(height: AppConstants.spacingM),
        GestureDetector(
          onTap: isUploading ? null : onTap,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: imageUrl != null ? AppConstants.successColor.withOpacity(0.1) : AppConstants.surfaceColor,
              border: Border.all(
                color: imageUrl != null ? AppConstants.successColor : AppConstants.borderColor,
                width: imageUrl != null ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            child: isUploading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : imageUrl != null
                    ? Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppConstants.successColor,
                                  size: 32,
                                ),
                                const SizedBox(height: AppConstants.spacingS),
                                Text(
                                  'Uploaded Successfully',
                                  style: TextStyle(
                                    color: AppConstants.successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: AppConstants.spacingS,
                            right: AppConstants.spacingS,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: onTap,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 32,
                              color: AppConstants.textSecondaryColor,
                            ),
                            const SizedBox(height: AppConstants.spacingS),
                            Text(
                              'Tap to upload',
                              style: TextStyle(
                                color: AppConstants.textSecondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ],
    );
  }
} 