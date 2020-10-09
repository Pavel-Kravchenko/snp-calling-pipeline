# snp-calling-pipeline
A simple snp calling pipeline for monogeneous and WGAS analysis. 
</br></br>

INPUT: raw fastq reads;</br>
OUTPUT: report with SNP hits in refgene, 1000g, gwas, clinvar.</br>

## Before you start

Make sure that you have installed:
<ul>
<li>Trimmomatic http://www.usadellab.org/cms/?page=trimmomatic
<li>Hisat2 https://ccb.jhu.edu/software/hisat2/index.shtml
<li>Samtools http://samtools.sourceforge.net/
<li>Annovar http://annovar.openbioinformatics.org/en/latest/
</ul>

## Getting started

First of all you have to ```clone``` this directory</br></br>
```git clone https://github.com/Pavel-Kravchenko/snp-calling-pipeline/```</br></br>
Then ```cd``` in snp-calling-pipeline </br></br>
```cd snp-calling-pipeline```</br></br>
You have to run a builder.sh script in /Human with your reference chromosomes.</br></br>
Now you are ready to start.</br></br>
Put your .fastq reads in /reads and run script.sh</br></br>

## Contact me

Feel free to contact me for any suggestions or critique.

Email: pavel-kravchenk0@yandex.ru 

Site: http://kodomo.fbb.msu.ru/~pavel-kravchenko/index.html 
