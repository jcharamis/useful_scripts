use strict;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
use warnings;

my @f = ();
my %fasta=();
my $seq=();
my $id = ();
my @filter=();
my %filter=();
my @inputs=();


open ( IN, $ARGV[0] ) or die "USAGE: perl filter_fasta.pl 2-LINE_FASTA_FILE ID_TO_REMOVE]" ;
open ( IN1, $ARGV[1]);


sub FastaParser {

    @inputs = @_;

    my $line=$inputs[0];
    chomp $line;

    if ( $line =~ />/ ) {
        $line =~ s/>| .*//g;
        $id = $line;
    }

    elsif ( $line =~ /\--/ ) {
        next;
    }

    else {
        $line =~ s/\*$|\.$//g;
        $fasta{$id}=$line;
    }

}


#fasta hash, genes to remove                                                                                                                                                                                                                                                                                                                                                                                                                                                               
sub FilternPrint {
    @filter=@_;
    chomp $filter[0];
    $filter{$filter[0]}=1;
}


while ( my $line = <IN> ) {
    FastaParser ($line);
}

while ( my $line=<IN1> ) {
    FilternPrint($line);
}

close (IN);


my %seen=();

for my $head ( keys %fasta ) {
    unless ( exists $filter{$head} ) {
        print ">","$head\n$fasta{$head}\n";
    }
}



