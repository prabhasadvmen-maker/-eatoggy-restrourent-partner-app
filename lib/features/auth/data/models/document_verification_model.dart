class DocumentItem {
  const DocumentItem({
    required this.id,
    required this.title,
    required this.isRequired,
    this.isUploaded = false,
    this.filePath,
    this.fileType,
    required this.uploadNote,
  });

  final String id;
  final String title;
  final bool isRequired;
  final bool isUploaded;
  final String? filePath;
  final String? fileType;
  final String uploadNote;

  DocumentItem copyWith({
    String? id,
    String? title,
    bool? isRequired,
    bool? isUploaded,
    String? filePath,
    String? fileType,
    String? uploadNote,
  }) {
    return DocumentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isRequired: isRequired ?? this.isRequired,
      isUploaded: isUploaded ?? this.isUploaded,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      uploadNote: uploadNote ?? this.uploadNote,
    );
  }
}

class DocumentVerificationModel {
  const DocumentVerificationModel({
    required this.screenTitle,
    required this.stepText,
    required this.headingText,
    required this.buttonText,
    required this.defaultDocuments,
  });

  final String screenTitle;
  final String stepText;
  final String headingText;
  final String buttonText;
  final List<DocumentItem> defaultDocuments;

  static const dummy = DocumentVerificationModel(
    screenTitle: 'Verify Documents',
    stepText: 'Step 2 of 4',
    headingText: 'Upload Business Documents',
    buttonText: 'Continue',
    defaultDocuments: [
      DocumentItem(
        id: 'gst',
        title: 'GST Certificate',
        isRequired: true,
        isUploaded: false,
        uploadNote: 'Max 5MB • PDF, JPG, PNG',
      ),
      DocumentItem(
        id: 'fssai',
        title: 'FSSAI Food License',
        isRequired: false,
        isUploaded: true,
        uploadNote: 'Max 5MB • PDF, JPG, PNG',
      ),
    ],
  );
}
