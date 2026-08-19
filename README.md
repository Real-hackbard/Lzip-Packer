# :computer: Lzip-Packer

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) <img src="https://github.com/user-attachments/assets/061618cd-aae7-48e7-8f63-27d35f6338de" />  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) <img src="https://github.com/user-attachments/assets/729da1b9-8168-4acc-bb43-6a5e27da2db8" />  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

lzip is a free, [command-line tool](https://en.wikipedia.org/wiki/Command-line_interface) for the compression of data; it employs the [Lempel–Ziv–Markov chain algorithm](https://en.wikipedia.org/wiki/LZMA) (LZMA) with a user interface that is familiar to users of usual Unix compression tools, such as [gzip](https://en.wikipedia.org/wiki/Gzip) and [bzip2](https://en.wikipedia.org/wiki/Bzip2).

Like gzip and bzip2, concatenation is supported to compress multiple files, but the convention is to bundle a file that is an archive itself, such as those created by the [tar](https://en.wikipedia.org/wiki/Tar_(computing)) or cpio Unix programs. Lzip can split the output for the creation of multivolume archives.

The file that is produced by lzip is usually given .lz as its filename extension, and the data is described by the media type application/lzip.

The lzip suite of programs was written in C++ and C by Antonio Diaz Diaz and is being distributed as free software under the terms of version 2 or later of the [GNU General Public License (GPL)](https://en.wikipedia.org/wiki/GNU_General_Public_License).

</br>

<img width="629" height="511" alt="Lzip" src="https://github.com/user-attachments/assets/0fb8634b-04a4-451d-92af-5f3540549771" />

</br>
</br>

# Lzip

The functions and variables forming the interface of the compression library are declared in the file ```lzlib.h```. Usage examples of the library are given in the files ```bbexample.c```, ```ffexample.c```, and ```minilzip.c``` from the source distribution.

All the library functions are thread safe. The library does not install any signal handler. The decoder checks the consistency of the compressed data, so the library should never crash even in case of corrupted input.

Compression/decompression is done by repeatedly calling a couple of read/write functions until all the data have been processed by the library. This interface is safer and less error prone than the traditional zlib interface.

Compression/decompression is done when the read function is called. This means the value returned by the position functions is not updated until a read call, even if a lot of data are written. If you want the data to be compressed in advance, just call the read function with a size equal to 0.

If all the data to be compressed are written in advance, lzlib automatically adjusts the header of the compressed data to use the largest dictionary size that does not exceed neither the data size nor the limit given to 'LZ_compress_open'. This feature reduces the amount of memory needed for decompression and allows minilzip to produce identical compressed output as lzip.

Lzlib correctly decompresses a data stream which is the concatenation of two or more compressed data streams. The result is the concatenation of the corresponding decompressed data streams. Integrity testing of concatenated compressed data streams is also supported.

Lzlib is able to compress and decompress streams of unlimited size by automatically creating multimember output. The members so created are large, about 2 PiB each.

The latest released version of lzlib can be found [here](https://download.savannah.nongnu.org/releases/lzip/lzlib/) You may also subscribe to lzip-bug and receive an email every time a new version is released.

</br>

# PLzip
Plzip is a massively parallel (multithreaded) implementation of lzip. Plzip uses the compression library lzlib.

Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2. Lzip uses a simplified form of [Lempel–Ziv–Markov chain algorithm](https://en.wikipedia.org/wiki/LZMA) and is designed to achieve complete interoperability between implementations. The maximum dictionary size is 512 MiB so that any lzip file can be decompressed on 32-bit machines. Lzip provides accurate and robust 3-factor integrity checking. 'lzip -0' compresses about as fast as gzip, while 'lzip -9' compresses most files more than bzip2. Decompression speed is intermediate between gzip and bzip2. Lzip provides better data recovery capabilities than gzip and bzip2. Lzip has been designed, written, and tested with great care to replace gzip and bzip2 as general-purpose compressed format for Unix-like systems.

Plzip can compress/decompress large files on multiprocessor machines much faster than lzip, at the cost of a slightly reduced compression ratio (0.4 to 2 percent larger compressed files). Note that the number of usable threads is limited by file size; on files larger than a few GB plzip can use hundreds of processors, but on files of only a few MB plzip is no faster than lzip.

For creation and manipulation of compressed tar archives tarlz can be more efficient than using tar and plzip because tarlz is able to keep the alignment between tar members and lzip members.

When compressing, plzip divides the input file into chunks and compresses as many chunks simultaneously as worker threads are chosen, creating a multimember compressed file.

When decompressing, plzip decompresses as many members simultaneously as worker threads are chosen. Files that were compressed with lzip are not decompressed faster than using lzip (unless the option '-b' was used) because lzip usually produces single-member files, which can't be decompressed in parallel.

In this [plzip benchmark page](https://www.nongnu.org/lzip/plzip_benchmark.html) you can find some tests showing the performance of plzip on a multiprocessor machine.

The latest released version of plzip can be found [here](https://download.savannah.nongnu.org/releases/lzip/plzip/) Plzip requires lzlib to build. Lzlib is available at [http://www.nongnu.org/lzip/lzlib.html.](https://www.nongnu.org/lzip/lzlib.html) You may also subscribe to lzip-bug and receive an email every time a new version is released.

# Bzip2
bzip2 is not a [file archiver](https://en.wikipedia.org/wiki/File_archiver) and thus relies on separate external utilities such as tar for tasks such as handling multiple files, and other tools for encryption, and archive splitting.

bzip2 was initially released in 1996 (originally named bzip) by [Julian Seward](https://en.wikipedia.org/wiki/Julian_Seward). It compresses most files more effectively than older [LZW](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch) and Deflate compression algorithms but is slower. bzip2 is particularly efficient for text data, and decompression is relatively fast. The algorithm uses several layers of compression techniques, such as run-length encoding (RLE), Burrows–Wheeler transform (BWT), move-to-front transform (MTF), and [Huffman](https://en.wikipedia.org/wiki/Huffman_coding) coding. bzip2 compresses data in blocks between 100 and 900 kB and uses the Burrows–Wheeler transform to convert frequently recurring character sequences into strings of identical letters. The move-to-front transform and Huffman coding are then applied. The compression performance is asymmetric, with decompression being faster than compression.
