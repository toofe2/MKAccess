# MKAccess

Standalone iOS ARM64 runtime bridge for the MK test build.

Phase 1 is intentionally diagnostic: build and load the dylib without modifying the protected libloader binary. After load verification, feature-specific runtime integration can be tested separately.

Minimum iOS: 15.0
Architecture: arm64
