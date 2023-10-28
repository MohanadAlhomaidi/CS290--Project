class CourseDetails {
  String courseId; // Unique ID for each course
  String courseName; // Name of the course
  String description; // Description of the course
  String instructor; // Name of the instructor
  List<String> categories; // List of categories
  String imageUrl; // URL of the image
  String videoUrl; // URL of the video
  bool isFavrate = false; // Is the course in the favorite list?
  int rating = 0; // Rating of the course

  CourseDetails({
    required this.courseId,
    required this.courseName,
    required this.description,
    required this.instructor,
    required this.categories,
    required this.imageUrl,
    required this.videoUrl,
    required this.isFavrate,
    this.rating = 0,
  });

  // Create a factory constructor to convert a map into a CourseDetails object
  factory CourseDetails.fromMap(Map<String, dynamic> map) {
    return CourseDetails(
      courseId: map['courseId'],
      courseName: map['courseName'],
      description: map['description'],
      instructor: map['instructor'],
      categories: List<String>.from(map['categories']),
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
      isFavrate: map['isFavrate'],
      rating: map['rating'],
    );
  }

  // Convert a CourseDetails object into a map for Firebase Firestore
  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'description': description,
      'instructor': instructor,
      'categories': categories,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'isFavrate': isFavrate,
    };
  }
}
