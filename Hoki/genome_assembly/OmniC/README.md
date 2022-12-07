# OmniC data processing

Species: M. novaezelandiae


Notes:
* OmniC does’t use digestion enzyme as the traditional HiC library preparation method
* Currently (as in July 2021) almost all the tools developed for HiC data requires enzyme name and its overhang sequence
* Using all the OmniC data (1,069 million pairs of reads), no node and no edge is found; hence no way to do scaffolding.
* The latest Dovetail/Pairtools (omni-c/04734cc) could process ~200 million read pairs. Randomly sub-sampling of 200M pairs of reads from the raw OmniC data, the analysis workflow discovered >6% valid pairs, created a sparse contact map with 788 nodes and 394 edges. However, Salsa2 exited without scaffolding as not enough nodes/edges after the 2nd round of iteration.
* Since current HiC scaffolding tools failed, we turned to HiCSuite for manual curation.
