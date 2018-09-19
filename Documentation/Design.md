# Design

As mentioned in the abstract our objectives are as follows:  

 * Implement the three algorithms proposed by the paper namely: the encoding module, the decoding module and the coding module which acts like an auxiliary module to the two primary ones.
 * Compare the efficiency and accuracy of the novel method proposed against traditional Hamming coding schemes by plotting graphs and measuring error rate. 
 * Contrast the advantages and disadvantages of the novel scheme against existing error detection and correction methods.

## Algorithm for Construction of the Extended Hamming Code

Consider a data word with k bits and let there be   redundant bits. The code will be k+r bits long and n = k + r +1 (one extra bit to find overall parity). Firstly we have to create the identity matrix.  
For any integer p there exists a (n,k,r) extended Hamming code, where:  

`n = 2^p - 1 ; k = 2^p - 1 - p`

Follow the following steps:  
 * Create a matrix with dimension p x (2^p -1), which each column is to be different , ie, all binary combinations should be used, except all zeros one.
 * Reorder the column in order to achieve an identity matrix in the right hand side.
 * Take the first (2^p - 1) - p columns of the matrix (all columns except those creating the identity part) and then add a zero column to the left side.
 * Append this matrix with an overall parity check column  to an identity matrix with dimensions p xp .
 * Add a row of all 1’s to the matrix with dimensions (p+1) x 2^p on the top
 * The check code is equal; to the value of each row of the extended identity check matrix.

## Algorithm for Encoding 

Let the length of the original data block be 11 bytes. The length of the extended hamming code to encode 11 bytes original data is 16 bytes. The algorithm is:

 * Take out the 11 bytes data from the original dta and get 8 data with 11 bit width by simply meriging
 * Compute the values of even check bits and overall even check bit from the check codes determined by the extended identifying matrix and put them at the parity positions.
 * Repeat step 2. Process other 11 bits data until all data are encoded.
 * Reorganize the hamming codewords by the use of interleaving technique that a byte access fetches one bit from each of the extended Hamming code codeword.

## Algorithm for Decoding 

The algorithm is as follows:
 
 * Restore the encoded data block by the use of de-interleaving technique
 * Fetch a code word into buffer and reset the error flag bit
 * Extract the overall parity bit from a code word.
 * Compute the value of the check code of received code word.
 * If the value of the overall parity bit is equal to zero, then set up an error flag.
 * Locate and fix a bad nit from the value of the check code of received codeword. A bad bit is located by using lookup table method.
 * Output 8 bits data and the error flag.
 * Repeat 2-8. Process other code words until all codewords are decoded.

We plan to use MATLAB for the implementation and testing  of the first three algorithms. Testing of the code will be done by running a small simulation  on MATLAB.  
The comparison of the efficiency and accuracy of the novel method proposed against traditional Hamming coding schemes will be achieved by plotting graphs between time taken for transmission between both schemes and  also by measuring error rates.  

