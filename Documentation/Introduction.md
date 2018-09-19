# Introduction 

## Motivation 

Noise is problematic. During data communication, various kinds of noise interfere with the transmission medium and garbles the data being transmitted (creates errors in the data). This results in ineffective communication, since the intended message is not transmitted. To counter this problem, we need to _detect_ errors and _correct_ them. 

There are many schemes by which we can detect and correct errors in the data. But the simplest and most common way uses a concept called Forward Error Correction (FEC). The idea behind FEC is, add extra information to the data that would allow us to detect and correct the data. Thus, the detection and correction can be deferred to the recipient and would not require retransmission of the data.

Richard Hamming in 1950 introduced a correction scheme where the redundant bits added included parity information. Hamming codes are a class of binary linear codes. For each integer r ≥ 2 there is a code with block length n = 2r − 1 and message length k = 2r − r − 1. Hence the rate of Hamming codes is R = k / n = 1 − r / (2r − 1), which is the highest possible for codes with minimum distance of three (i.e., the minimal number of bit changes needed to go from any code word to any other code word is three) and block length 2r − 1. 

Due to the limited redundancy that Hamming codes add to the data, they can only detect and correct errors when the error rate is low. This is the case in computer memory (ECC memory), where bit errors are extremely rare and Hamming codes are widely used. In this context, an _extended Hamming code_ having one extra parity bit is often used. Extended Hamming codes achieve a Hamming distance of four, which allows the decoder to distinguish between when at most one one-bit error occurs and when any two-bit errors occur. In this sense, extended Hamming codes are single-error correcting and double-error detecting, abbreviated as SECDED. 

In High Reliability applicaions, SECDED may not provide adequate protection against burst errors. To correct burst errors we need very large hamming distances, which means more number of redundant bits. We need a code that can correct bursts, while minimizing the redundant information added. The paper explores a new way to improve the burst error correction capabilities of the Extended Hamming Code with the target objective of minimizing redundancy and maximizing code rate.
