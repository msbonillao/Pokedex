class APIResource<T> {
  final String id;
  final String resource;

  const APIResource({
    required this.id,
    required this.resource,
  });

  factory APIResource.fromUrl(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments.reversed.toList();
    return APIResource(
      id: segments[1],
      resource: segments[2],
    );
  }
}
