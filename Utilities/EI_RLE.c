
#include "EI_RLE.h"

OSErr CompressRLE(Ptr baseAddr, long rowBytes, int depth, int width, int height, Ptr compressBuffer, Size *compressBufferSizePtr)
{
	Handle hdl;
	Ptr    tempPtr;
	int  i;
	Size   widthByteSize = (depth * (long)width + 7) >> 3;
	OSErr  err;

	// Make a temp buffer for the source
	hdl = NewHandleClear(height * widthByteSize);
	err = MemError();
	if (err) goto bail;
	
	HLock(hdl);
	
	tempPtr = *hdl;
	
	// Get rid of row bytes padding
	for (i = 0; i < height; i++) {
		BlockMoveData(baseAddr, tempPtr, widthByteSize);
		
		tempPtr += widthByteSize;
		baseAddr += rowBytes;
	}

	// Compress
	switch (depth) {
	case 1:
		CompressRLE8((UInt8 *)*hdl, height * widthByteSize, compressBuffer, compressBufferSizePtr);
		break;
	case 8:
		CompressRLE8((UInt8 *)*hdl, height * widthByteSize, compressBuffer, compressBufferSizePtr);
		break;
	case 16:
		CompressRLE16((UInt16 *)*hdl, height * (widthByteSize >> 1), compressBuffer, compressBufferSizePtr);
		break;
	case 32:
		CompressRLE32((UInt32 *)*hdl, height * (widthByteSize >> 2), compressBuffer, compressBufferSizePtr);
		break;
	}
	
bail:
	if (hdl)
		DisposeHandle(hdl);

	return err;
}

// CompressRLE
//		Main compress routine, this function will call the appropriate RLE compression
// method depending on the pixel depth of the source image.
OSErr CompressPixMapRLE(PixMapHandle pixMapHdl, Ptr compressBuffer, Size *compressBufferSizePtr)
{
	Handle hdl = NULL;
	Ptr	   tempPtr = NULL,srcData;
	Ptr	   pixBaseAddr = GetPixBaseAddr(pixMapHdl);
	OSType pixelFormat = GETPIXMAPPIXELFORMAT(*pixMapHdl);
	int		depth = QTGetPixelSize(pixelFormat);
	long   rowBytes = QTGetPixMapHandleRowBytes(pixMapHdl);
	int		width = (**pixMapHdl).bounds.right - (**pixMapHdl).bounds.left;
	int		i, height = (**pixMapHdl).bounds.bottom - (**pixMapHdl).bounds.top;
	Size   widthByteSize = (depth * (long)width + 7) >> 3;
	OSErr  err = noErr;

	// need to remove padding between rows?
	if(widthByteSize != rowBytes){
		// Make a temp buffer for the source
		hdl = NewHandle(height * widthByteSize);
		err = MemError();
		if (err) goto bail;
		
		HLock(hdl);
		
		srcData = tempPtr = *hdl;
		
		// Get rid of row bytes padding
		for (i = 0; i < height; i++) {
			BlockMoveData(pixBaseAddr, tempPtr, widthByteSize);
			tempPtr += widthByteSize;
			pixBaseAddr += rowBytes;
		}
	}else
		srcData = pixBaseAddr;

	// Compress
	switch (depth) {
	case 1:
		CompressRLE8((UInt8*)srcData, height * widthByteSize, compressBuffer, compressBufferSizePtr);
		break;
	case 8:
		CompressRLE8((UInt8*)srcData, height * widthByteSize, compressBuffer, compressBufferSizePtr);
		break;
	case 16:
		CompressRLE16((UInt16*)srcData, height * (widthByteSize >> 1), compressBuffer, compressBufferSizePtr);
		break;
	case 32:
		CompressRLE32((UInt32*)srcData, height * (widthByteSize >> 2), compressBuffer, compressBufferSizePtr);
		break;
	}
	
bail:
	if (hdl)
		DisposeHandle(hdl);

	return err;
}

// CompressRLE8
void CompressRLE8(UInt8 *srcPtr, Size srcSize, Ptr compressBuffer, Size *compressBufferSizePtr)
{
	UInt8	   prevPixel, currentPixel;
	UInt8	   sameCharCount;
	UInt8	   diffCharCount;
	RLE8Packet *packetPtr;
		
	// Initialize some stuff
	sameCharCount = 1;
	diffCharCount = 0;

	packetPtr = (RLE8Packet *)compressBuffer;

	prevPixel = *srcPtr++;

	while (srcSize >= 2 ) {
		currentPixel = *srcPtr++;
		
		if (prevPixel == currentPixel) {
			// If diffCharCount > 0, we are holding pixels which should be read literally
			if (diffCharCount > 0) {
				packetPtr->opcode = 127 + diffCharCount;
				
				packetPtr = (RLE8Packet *)((Ptr)packetPtr + offsetof(RLE8Packet, pixelData[diffCharCount]));
				diffCharCount = 0;
			}
			
			if (sameCharCount < 128) {
				sameCharCount++;
			} else {
				packetPtr->opcode = sameCharCount - 1;
				packetPtr->pixelData[0] = prevPixel;
				
				packetPtr = (RLE8Packet *)((Ptr)packetPtr + offsetof(RLE8Packet, pixelData[1]));
				sameCharCount = 1;
			}
		} else {
			// If sameCharCount > 1, we are holding pixels which should be read repeatedly
			if (sameCharCount > 1) {
				packetPtr->opcode = sameCharCount - 1;
				packetPtr->pixelData[0] = prevPixel;
								
				packetPtr = (RLE8Packet *)((Ptr)packetPtr + offsetof(RLE8Packet, pixelData[1]));
				sameCharCount = 1;
			} else {
				packetPtr->pixelData[diffCharCount++] = prevPixel;
				
				if (diffCharCount == 128) {
					packetPtr->opcode = 127 + diffCharCount;
					
					packetPtr = (RLE8Packet *)((Ptr)packetPtr + offsetof(RLE8Packet, pixelData[diffCharCount]));
					diffCharCount = 0;
				}
			}
			
			prevPixel = currentPixel;
		}
		
		srcSize--;
	}
	
	// If sameCharCount > 1, we are holding pixels which should be read repeatedly
	// If not so, we are holding pixels which should be read literally
	if (sameCharCount > 1) {
		packetPtr->opcode = sameCharCount - 1;
		packetPtr->pixelData[0] = prevPixel;

		packetPtr = (RLE8Packet *)((Ptr)packetPtr + offsetof(RLE8Packet, pixelData[1]));
	} else {
		packetPtr->pixelData[diffCharCount++] = prevPixel;
		packetPtr->opcode = 127 + diffCharCount;
		
		packetPtr = (RLE8Packet *)((Ptr)packetPtr + offsetof(RLE8Packet, pixelData[diffCharCount]));
	}
		
	*compressBufferSizePtr = (Ptr)packetPtr - compressBuffer;
}

// CompressRLE16
void CompressRLE16(UInt16 *srcPtr, Size srcSize, Ptr compressBuffer, Size *compressBufferSizePtr)
{
	UInt16		prevPixel, currentPixel;
	UInt8		sameCharCount;
	UInt8		diffCharCount;
	RLE16Packet	*packetPtr;
		
	// Initialize some stuff
	sameCharCount = 1;
	diffCharCount = 0;

	packetPtr = (RLE16Packet *)compressBuffer;

	prevPixel = *srcPtr++;

	while (srcSize >= 2) {
		currentPixel = *srcPtr++;
		
		if (prevPixel == currentPixel) {
			// If diffCharCount > 0, we are holding pixels which should be read literally
			if (diffCharCount > 0) {
				packetPtr->opcode = 127 + diffCharCount;
				
				packetPtr = (RLE16Packet *)((Ptr)packetPtr + offsetof(RLE16Packet, pixelData[diffCharCount]));
				diffCharCount = 0;
			}
			
			if (sameCharCount < 128) {
				sameCharCount++;
			} else {
				packetPtr->opcode = sameCharCount - 1;
				packetPtr->pixelData[0] = prevPixel;

				packetPtr = (RLE16Packet *)((Ptr)packetPtr + offsetof(RLE16Packet, pixelData[1]));
				sameCharCount = 1;
			}
		} else {
			// If sameCharCount > 1, we are holding pixels which should be read repeatedly
			if (sameCharCount > 1)
			{
				packetPtr->opcode = sameCharCount - 1;
				packetPtr->pixelData[0] = prevPixel;

				packetPtr = (RLE16Packet *)((Ptr)packetPtr + offsetof(RLE16Packet, pixelData[1]));
				sameCharCount = 1;
			} else {
				packetPtr->pixelData[diffCharCount++] = prevPixel;
				
				if (diffCharCount == 128)
				{
					packetPtr->opcode = 127 + diffCharCount;
	
					packetPtr = (RLE16Packet *)((Ptr)packetPtr + offsetof(RLE16Packet, pixelData[diffCharCount]));
					diffCharCount = 0;
				}
			}
			
			prevPixel = currentPixel;
		}
		
		srcSize--;
	}
	
	// If sameCharCount > 1, we are holding pixels which should be read repeatedly
	// If not so, we are holding pixels which should be read literally
	if (sameCharCount > 1) {
		packetPtr->opcode = sameCharCount - 1;
		packetPtr->pixelData[0] = prevPixel;

		packetPtr = (RLE16Packet *)((Ptr)packetPtr + offsetof(RLE16Packet, pixelData[1]));
	} else {
		packetPtr->pixelData[diffCharCount++] = prevPixel;
		packetPtr->opcode = 127 + diffCharCount;

		packetPtr = (RLE16Packet *)((Ptr)packetPtr + offsetof(RLE16Packet, pixelData[diffCharCount]));
	}
		
	*compressBufferSizePtr = (Ptr)packetPtr - compressBuffer;
}

// CompressRLE32
void CompressRLE32(UInt32 *srcPtr, Size srcSize, Ptr compressBuffer, Size *compressBufferSizePtr)
{
	UInt32		prevPixel, currentPixel;
	UInt8		sameCharCount;
	UInt8		diffCharCount;
	RLE32Packet	*packetPtr;
		
	// Initialize some stuff
	sameCharCount = 1;
	diffCharCount = 0;

	packetPtr = (RLE32Packet *)compressBuffer;

	prevPixel = *srcPtr++;

	while (srcSize >= 2) {
		currentPixel = *srcPtr++;
		
		if (prevPixel == currentPixel) {
			// If diffCharCount > 0, we are holding pixels which should be read literally
			if (diffCharCount > 0) {
				packetPtr->opcode = 127 + diffCharCount;

				packetPtr = (RLE32Packet *)((Ptr)packetPtr + offsetof(RLE32Packet, pixelData[diffCharCount]));
				diffCharCount = 0;
			}
			
			if (sameCharCount < 128) {
				sameCharCount++;
			} else {
				packetPtr->opcode = sameCharCount - 1;
				packetPtr->pixelData[0] = prevPixel;

				packetPtr = (RLE32Packet *)((Ptr)packetPtr + offsetof(RLE32Packet, pixelData[1]));
				sameCharCount = 1;
			}
		} else {
			// If sameCharCount > 1, we are holding pixels which should be read repeatedly
			if (sameCharCount > 1) {
				packetPtr->opcode = sameCharCount - 1;
				packetPtr->pixelData[0] = prevPixel;

				packetPtr = (RLE32Packet *)((Ptr)packetPtr + offsetof(RLE32Packet, pixelData[1]));
				sameCharCount = 1;
			} else {
				packetPtr->pixelData[diffCharCount++] = prevPixel;
				
				if (diffCharCount == 128) {
					packetPtr->opcode = 127 + diffCharCount;

					packetPtr = (RLE32Packet *)((Ptr)packetPtr + offsetof(RLE32Packet, pixelData[diffCharCount]));
					diffCharCount = 0;
				}
			}
			
			prevPixel = currentPixel;
		}
		
		srcSize--;
	}
	
	// If sameCharCount > 1, we are holding pixels which should be read repeatedly
	// If not so, we are holding pixels which should be read literally
	if (sameCharCount > 1) {
		packetPtr->opcode = sameCharCount - 1;
		packetPtr->pixelData[0] = prevPixel;

		packetPtr = (RLE32Packet *)((Ptr)packetPtr + offsetof(RLE32Packet, pixelData[1]));
	} else {
		packetPtr->pixelData[diffCharCount++] = prevPixel;
		packetPtr->opcode = 127 + diffCharCount;
		
		packetPtr = (RLE32Packet *)((Ptr)packetPtr + offsetof(RLE32Packet, pixelData[diffCharCount]));
	}
		
	*compressBufferSizePtr = (Ptr)packetPtr - compressBuffer;
}
