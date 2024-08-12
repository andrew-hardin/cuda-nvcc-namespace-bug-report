# NVCC: ignores global namespace prefix
An intermediate file product by `nvcc` resolves to the
incorrect type when the same type exists in the global and
local namespace.

- Command
  ```bash
  nvcc --keep bug.cu
  ```
- Output
  ```text
  In file included from bug.cudafe1.stub.c:1:
  bug.cu:22:38: error: ‘void gpu::Fails(gpu::Type)’ should have been declared inside ‘gpu’
     22 |   __global__ void Fails(::Type t) {
        |                                      ^
  In file included from bug.cudafe1.stub.c:1:
  bug.cu: In function ‘void gpu::Fails(gpu::Type)’:
  bug.cu:22:37: error: invalid initialization of reference of type ‘Type&’ from expression of type ‘gpu::Type’
     22 |   __global__ void Fails(::Type t) {
        |                                     ^
  In file included from bug.cudafe1.stub.c:1:
  bug.cudafe1.stub.c:1:53: note: in passing argument 1 of ‘void __device_stub__ZN3gpu5FailsE4Type(Type&)’
      1 | #pragma GCC diagnostic push
        |                                                     ^
  ```
- Details
  ```bash
  nvcc --version
  # nvcc: NVIDIA (R) Cuda compiler driver
  # Copyright (c) 2005-2024 NVIDIA Corporation
  # Built on Fri_Jun_14_16:34:21_PDT_2024
  # Cuda compilation tools, release 12.6, V12.6.20
  # Build cuda_12.6.r12.6/compiler.34431801_0

  gcc --version
  # gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)
  ```