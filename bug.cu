#include <iostream>

// Type in global namspace.
struct Type{
  int from_global_type;
};

namespace gpu {

  // Another *different* type that shares the same name.
  struct Type{
    int from_local_type;
  };

  // Kernel that uses the "gpu::Type".
  __global__ void Works(::gpu::Type t) {
    printf("%i", t.from_local_type);
  }

  // Kernel that uses the global ::Type.
  // This won't compile, but it's valid C++.
  // (e.g. remove the __global__ attribute and it'll compile just fine).
  __global__ void Fails(::Type t) {
    printf("%i", t.from_global_type);
  }
}
