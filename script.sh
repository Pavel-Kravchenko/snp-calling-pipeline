echo START
home=`pwd`
cd reads
a=*.fas*
export PATH=${PATH}:$home/hisat2-2.1.0
for x in $a
do  
	mkdir -p output/${x%.fa*}
	cp $x ./output/${x%.fa*}
	echo "Directory created" 
	cd ./output/${x%.fa*}
	echo ">>>Complete"
	echo Trimming...................................................................................
	java -jar $home/Trimmomatic-0.36/trimmomatic-0.36.jar SE -phred33 $x chr_outfile.fastq TRAILING:20 MINLEN:50 
	echo ">>>Complete"
	echo Hisat2.....................................................................................
	hisat2 -x $home/Human/${x%.fa*} -U chr_outfile.fastq --no-spliced-alignment --no-softclip > alignment.sam
	echo ">>>Complete"
	echo Samtools...................................................................................
	samtools view alignment.sam -b -o alignment.bam
	echo OK1
	samtools sort alignment.bam -T out_sort.txt -o alignment_sorted.bam
	echo OK2
	samtools index alignment_sorted.bam
	echo OK3
	samtools idxstats alignment_sorted.bam > out.txt
	echo OK4
	samtools mpileup -uf $home/Human/${x%.fa*}.fasta alignment_sorted.bam > snp.bcf
	echo OK5
	bcftools call -cv snp.bcf -o snp.vcf
	echo OK6
	samtools depth alignment_sorted.bam >depth_sorted.tsv
	echo OK7
	perl `pwd`/annovar/convert2annovar.pl -format vcf4 snp.vcf > snp.avinput
	echo OK7.1
	perl `pwd`/annovar/annotate_variation.pl -filter -out snp.rs.${x%.fa*} -build hg19 -dbtype snp138 snp.avinput $home/annovar/humandb/
	echo rs_OK8
	perl /nfs/srv/databases/annovar/annotate_variation.pl -out snp.refgene.${x%.fa*} -build hg19 snp.avinput $home/annovar/humandb/ 
	echo refgene_OK9
	perl /nfs/srv/databases/annovar/annotate_variation.pl -filter -out snp.1000g.${x%.fa*} -buildver hg19 -dbtype 1000g2014oct_all snp.avinput $home/annovar/humandb/ 
	echo 1000g_OK10
	perl /nfs/srv/databases/annovar/annotate_variation.pl -regionanno -out snp.gwas.${x%.fa*} -build hg19 -dbtype gwasCatalog snp.avinput $home/annovar/humandb/
	echo gwas_OK11
	perl /nfs/srv/databases/annovar/annotate_variation.pl -filter -out snp.clin.${x%.fa*} -dbtype clinvar_20150629 -buildver hg19 snp.avinput $home/annovar/humandb/
	echo clin_OK12
	cd ..
	cd ..
	echo Complete.....................................................................................
done

cd ./output
a=`ls`
for x in $a
do
	cat ./$x/snp.gwas.$x.hg19_gwasCatalog >> log_SNP.csv	
done

echo END
