
#include "EI_Image.h"

OSErr CompressRLE(Ptr baseAddr, long rowBytes, int depth, int width, int height, Ptr compressBuffer, Size *compressBufferSizePtr);
OSErr CompressPixMapRLE(PixMapHandle pixMapHdl, Ptr compressBuffer, Size *compressBufferSizePtr);
void  CompressRLE8(UInt8 *srcPtr, Size srcSize, Ptr compressBuffer, Size *compressBufferSizePtr);
void  CompressRLE16(UInt16 *srcPtr, Size srcSize, Ptr compressBuffer, Size *compressBufferSizePtr);
void  CompressRLE32(UInt32 *srcPtr, Size srcSize, Ptr compressBuffer, Size *compressBufferSizePtr);
