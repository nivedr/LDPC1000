# LDPC1000
An implementation of the LDPC SPA decoder in matlab for small code lengths 1000,2000,4000
The structure of the repository is as below:

root/
 |
 ├───main.m		main
 |
 ├───gen_Lambda.m	generates the optimal lambda (bit node edge dist.) from rho.
 |			rho is found by trial and error
 |
 ├───gen_degreeDist.m	Generates the degree distributions from computed edge distributions
 |
 ├───decimate.m		Rounds lambda, rho to make the degree distributions have an integer
 |			count for every degree.
 |
 ├───gen_LDPCM.m	generates the LDPC matrix from the computed rho and lambda
 |
 ├───gen_decoder.m	generates the bit-node, check-node and edge object instantiation
 |			for a given LDPC matrix.
 |
 ├───SPA.m		Implements the sum-product decoder for BEC
 |
 ├───LDPC_report.pdf	Report containing results and implementation choices for the LDPC code
 |
 ├───figures/
 |	└───*.fig	contains the results of the implementation in .fig format
 |
 ├─────PNG/
 |      └───*.png	contains the results of the implementation in .png format
 |
 └─────temp/
        └───*.m		contains temporary files used for plotting various graphs
