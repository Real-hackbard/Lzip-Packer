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

<img src="https://github.com/user-attachments/assets/0fb8634b-04a4-451d-92af-5f3540549771" />

</br>
</br>

### Small tutorial & examples

WARNING! Even if lzip is bug-free, other causes may result in a corrupt compressed file (bugs in the system libraries, memory errors, etc). Therefore, if the data you are going to compress are important, give the option --keep to lzip and don't remove the original file until you check the compressed file with a command like 'lzip -cd file.lz | cmp file -'. Most RAM errors happening during compression can only be detected by comparing the compressed file with the original because the corruption happens before lzip compresses the RAM contents, resulting in a valid compressed file containing wrong data.


**Example 1:** Extract all the files from archive foo.tar.lz.

       tar -xf foo.tar.lz
     or
       lzip -cd foo.tar.lz | tar -xf -

**Example 2:** Replace a regular file with its compressed version file.lz and show the compression ratio.

     lzip -v file

**Example 3:** Like example 2 but the created file.lz is multimember with a member size of 1 MiB. The compression ratio is not shown.

     lzip -b 1MiB file

**Example 4:** Restore a regular file from its compressed version file.lz. If the operation is successful, file.lz is removed.

     lzip -d file.lz

**Example 5:** Check the integrity of the compressed file file.lz and show status.

     lzip -tv file.lz

**Example 6:** The right way of concatenating the decompressed output of two or more compressed files. See Trailing data.

     Don't do this
       cat file1.lz file2.lz file3.lz | lzip -d -
     Do this instead
       lzip -cd file1.lz file2.lz file3.lz

**Example 7:** Decompress file.lz partially until 10 KiB of decompressed data are produced.

     lzip -cd file.lz | dd bs=1024 count=10

**Example 8:** Decompress file.lz partially from decompressed byte at offset 10_000 to decompressed byte at offset 14_999 (5000 bytes are produced).

     lzip -cd file.lz | dd bs=1000 skip=10 count=5

**Example 9:** Compress a whole device in /dev/sdc and send the output to file.lz.

       lzip -c /dev/sdc > file.lz
     or
       lzip /dev/sdc -o file.lz

**Example 10:** Create a multivolume compressed tar archive with a volume size of 1440 KiB.

     tar -c some_directory | lzip -S 1440KiB -o volume_name -

**Example 11:** Extract a multivolume compressed tar archive.

     lzip -cd volume_name*.lz | tar -xf -

Example 12: Create a multivolume compressed backup of a large database file with a volume size of 650 MB, where each volume is a multimember file with a member size of 32 MiB.

     lzip -b 32MiB -S 650MB big_db




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

</br>

# Bzip2
bzip2 is not a [file archiver](https://en.wikipedia.org/wiki/File_archiver) and thus relies on separate external utilities such as tar for tasks such as handling multiple files, and other tools for encryption, and archive splitting.

bzip2 was initially released in 1996 (originally named bzip) by [Julian Seward](https://en.wikipedia.org/wiki/Julian_Seward). It compresses most files more effectively than older [LZW](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch) and Deflate compression algorithms but is slower. bzip2 is particularly efficient for text data, and decompression is relatively fast. The algorithm uses several layers of compression techniques, such as run-length encoding (RLE), Burrows–Wheeler transform (BWT), move-to-front transform (MTF), and [Huffman](https://en.wikipedia.org/wiki/Huffman_coding) coding. bzip2 compresses data in blocks between 100 and 900 kB and uses the Burrows–Wheeler transform to convert frequently recurring character sequences into strings of identical letters. The move-to-front transform and Huffman coding are then applied. The compression performance is asymmetric, with decompression being faster than compression.

### Download

Description		Download		Size		Last change		Md5sum  
• Complete package, except sources	 	[Setup](https://sourceforge.net/projects/gnuwin32/files/bzip2/1.0.5/bzip2-1.0.5-setup.exe/download?use_mirror=deac-riga&download)	 	828397	 	20 March 2008	 	: ddea95e9a0920c88051b4e3071e0b9b7  
• Sources	 	[Setup](https://sourceforge.net/projects/gnuwin32/files/bzip2/1.0.5/bzip2-1.0.5-src-setup.exe/download?use_mirror=master&download)	 	612147	 	20 March 2008	 	: f0719946c2af47a675c8eaa3a9408a96  
• Binaries	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/bzip2/1.0.5/bzip2-1.0.5-bin.zip/download?use_mirror=deac-fra&download)	 	158416	 	20 March 2008	 	: a1155c41b1954a2f6da1014c7c1a1263  
• Developer files	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/bzip2/1.0.5/bzip2-1.0.5-lib.zip/download?use_mirror=master&download)	 	36170	 	20 March 2008	 	: 795cd55e072d6e31b3ad00707994f566  
• Documentation	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/bzip2/1.0.5/bzip2-1.0.5-doc.zip/download?use_mirror=master&download)	 	574603	 	20 March 2008	 	: 3374f2d968ebcee4b8f0c0073d6ad680  
• Sources	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/bzip2/1.0.5/bzip2-1.0.5-src.zip/download?use_mirror=master&download)	 	416587	 	20 March 2008	 	: 6db7a1af112189d060ac0a538199ff06  
• Original source		http://www.bzip.org/1.0.5/bzip2-1.0.5.tar.gz

</br>

# Gzip
gzip is a file format and a file compression program. The program uses the Deflate algorithm to compress and decompress a single file using the [gzip file format](https://en.wikipedia.org/wiki/Gzip#File_format).

gzip was released in 1992 as a free software replacement for the compress program because its compression algorithm, LZW, was covered by patents from [Unisys](https://en.wikipedia.org/wiki/Unisys) and IBM,[4] which did not expire until 2003 and 2004. Jean-Loup Gailly designed the gzip file format,[6] which was later specified by RFC 1952, and originally wrote the gzip program. [Mark Adler](https://en.wikipedia.org/wiki/Mark_Adler) wrote the decompression part. gzip is now developed by the GNU project.

As the file format can be decompressed via a [streaming algorithm](https://en.wikipedia.org/wiki/Streaming_algorithm), it is commonly used in stream-based technology such as Web protocols, data interchange and ETL (in standard pipes).

### Download
 
Description		Download		Size		Last change		Md5sum  
• Complete package, except sources	 	[Setup](https://sourceforge.net/projects/gnuwin32/files/gzip/1.3.12-1/gzip-1.3.12-1-setup.exe/download?use_mirror=deac-fra&download)	 	815096	 	15 October 2007	 	: ff19a6203e8111bedff29c3bc150eaf1  
• Sources	 	[Setup](https://sourceforge.net/projects/gnuwin32/files/gzip/1.3.12-1/gzip-1.3.12-1-src-setup.exe/download?use_mirror=master&download)	 	684179	 	15 October 2007	 	: 71feb720f926cf9f231606ac34dea344  
• Binaries	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/gzip/1.3.12-1/gzip-1.3.12-1-bin.zip/download?use_mirror=altushost-net&download)	 	135350	 	15 October 2007	 	: b24802293f74ab11aaa5786f36c59819  
• Documentation	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/gzip/1.3.12-1/gzip-1.3.12-1-doc.zip/download?use_mirror=master&download)	 	461664	 	23 June 2007	 	: aa7564e3619ae00cea9197f562a444b8  
• Sources	 	[Zip](https://sourceforge.net/projects/gnuwin32/files/gzip/1.3.12-1/gzip-1.3.12-1-src.zip/download?use_mirror=excellmedia&download)	 	717550	 	15 October 2007	 	: 7c692445c3ed191d5807f19764144be0  
• Original source		http://ftp.gnu.org/gnu/gzip/gzip-1.3.12.tar.gz

</br>

# Parameters

If no file names are specified, lzip compresses (or decompresses) from standard input to standard output. A hyphen '-' used as a file argument means standard input. It can be mixed with other files and is read just once, the first time it appears in the command line. Remember to prepend ./ to any file name beginning with a hyphen, or use '--'. It is the responsibility of the caller to check that the file names in the command line are valid. (For example, that they do not contain unprintable characters).

lzip supports the following options: [See Argument syntax](https://www.nongnu.org/lzip/manual/lzip_manual.html#Argument-syntax).

```
-h
```  
Print an informative help message describing the options and exit.
```--help```  
Print the full help and exit.
```
-V
--version
```  
Print the version number of lzip on the standard output and exit. This version number should be included in all bug reports.

```
-a
--trailing-error
````
Exit with error status 2 if any remaining input is detected after decompressing the last member. Such remaining input is usually trailing garbage that can be safely ignored. See concat example.
```-b bytes
--member-size=bytes
````
When compressing, set the member size limit to bytes. If bytes is smaller than the compressed size, a multimember file is produced. It is advisable to keep members smaller than RAM size so that they can be repaired with lziprecover in case of corruption. A small member size may degrade compression ratio, so use it only when needed. Valid values range from 100 kB to 2 PiB. Defaults to 2 PiB.
```
-c
--stdout
```
Compress or decompress to standard output; keep input files unchanged. If compressing several files, each file is compressed independently. (The output consists of a sequence of independently compressed members). This option (or -o) is needed when reading from a named pipe (fifo) or from a device. Use it also to recover as much of the decompressed data as possible when decompressing a corrupt file. -c overrides -o and -S. -c has no effect when testing or listing.
```
-d
--decompress
```
Decompress the files specified. The integrity of the files specified is checked. If a file does not exist, can't be opened, or the destination file already exists and --force has not been specified, lzip continues decompressing the rest of the files and exits with error status 1. If a file fails to decompress, or is a terminal, lzip exits immediately with error status 2 without decompressing the rest of the files. A terminal is considered an uncompressed file, and therefore invalid. A multimember file with one or more empty members is accepted if redirected to standard input.
```
-f
--force
```
Force overwrite of output files.
```
-F
--recompress
```
When compressing, force re-compression of files whose name already has the .lz or .tlz suffix.
```
-k
--keep
```
Keep (don't delete) input files during compression or decompression.
```
-l
--list
```
Print the uncompressed size, compressed size, and percentage saved of the files specified. Trailing data are not counted. The values produced are correct even for multimember files. If more than one file is given, a final line containing the cumulative sizes is printed. With -v, the dictionary size, the number of members in the file, and '+t' to indicate the presence of trailing data are also printed. With -vv, the positions and sizes of each member in multimember files, and the amount of trailing data (if any) are also printed. A multimember file with one or more empty members is accepted if redirected to standard input.
If any file is damaged, does not exist, can't be opened, or is not regular, the final exit status is > 0. -lq can be used to check quickly (without decompressing) the structural integrity of the files specified. (Use --test to check the data integrity). -alq additionally checks that none of the files specified contain trailing data.

```
-m bytes
--match-length=bytes
```
When compressing, set the match length limit in bytes. After a match this long is found, the search is finished. Valid values range from 5 to 273. Larger values usually give better compression ratios but longer compression times. A match is a Lempel-Ziv back-reference coded as a distance-length pair.
```
-o file
--output=file
```
If -c has not been also specified, write the (de)compressed output to file, automatically creating any missing parent directories; keep input files unchanged. If compressing several files, each file is compressed independently. (The output consists of a sequence of independently compressed members). This option (or -c) is needed when reading from a named pipe (fifo) or from a device. -o - is equivalent to -c. -o has no effect when testing or listing.
When compressing and splitting the output in volumes, file is used as a prefix, and several files named file00001.lz, file00002.lz, etc, are created. In this case, only one input file is allowed.

-q
--quiet
Quiet operation. Suppress all messages.
-s bytes
--dictionary-size=bytes
When compressing, set the dictionary size limit in bytes. Lzip uses for each file the largest dictionary size that does not exceed neither the file size nor this limit. Valid values range from 4 KiB to 512 MiB. Values 12 to 29 are interpreted as powers of two, meaning 2^12 to 2^29 bytes. Dictionary sizes are quantized so that they can be coded in just one byte (see coded dict size). If the size specified does not match one of the valid sizes, it is rounded upwards by adding up to (bytes / 8) to it.
For maximum compression you should use a dictionary size limit as large as possible, but keep in mind that the decompression memory requirement is affected at compression time by the choice of dictionary size limit.

-S bytes
--volume-size=bytes
When compressing, and -c has not been also specified, split the compressed output into several volume files with names original_name00001.lz, original_name00002.lz, etc, and set the volume size limit to bytes. Input files are kept unchanged. Each volume is a complete, maybe multimember, lzip file. A small volume size may degrade compression ratio, so use it only when needed. Valid values range from 100 kB to 4 EiB.
-t
--test
Check integrity of the files specified, but don't decompress them. This really performs a trial decompression and throws away the result. Use it together with -v to see information about the files. If a file fails the test, does not exist, can't be opened, or is a terminal, lzip continues testing the rest of the files. A final diagnostic is shown at verbosity level 1 or higher if any file fails the test when testing multiple files. A multimember file with one or more empty members is accepted if redirected to standard input.
-v
--verbose
Verbose mode.
When compressing, show the compression ratio and size for each file processed.
When decompressing or testing, further -v's (up to 4) increase the verbosity level, showing status, compression ratio, dictionary size, trailer contents (CRC, data size, member size), and up to 6 bytes of trailing data (if any) both in hexadecimal and as a string of printable ASCII characters.
Two or more -v options show the progress of (de)compression.
-0 .. -9
Compression level. Set the compression parameters (dictionary size and match length limit) as shown in the table below. The default compression level is -6, equivalent to -s8MiB -m36. Note that -9 can be much slower than -0. These options have no effect when decompressing, testing, or listing.
