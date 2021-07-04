class ApiResponse<T> {
  final bool success;
  final T data;

  ApiResponse(this.success, this.data);

  factory ApiResponse.createErrorResponse() {
    return ApiResponse(false, null);
  }

  factory ApiResponse.createSuccessResponse(T data) {
    return ApiResponse(true, data);
  }

  @override
  String toString() {
    return 'ApiResponse{success: $success, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ApiResponse && success == other.success && data == other.data);

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
