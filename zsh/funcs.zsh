echo "Loading $0"

function cdll {
  cd $1
  ll
}
function myenc {
  openssl enc -aes-256-cbc -salt -in "$1" -out "$2"
}
function mydec {
  openssl enc -aes-256-cbc -d -salt -in "$1" -out "$2"
}
function ldupe { # List files with duplicate content.
  find . -type f -print0|xargs -0 md5sum|sort|perl -ne 'chomp;$ph=$h;$pf=$f;($h,$f)=split(/\s+/,$_,2);print "$pf = $f"."\x00\n" if ($h eq $ph)'
}
function longestline {
  awk ' { if ( length > L ) { L=length ;s=$0 } }END{ print L,"\""s"\"" }' $1
}
function mdupe { # Remove files with duplicate content.
  find . -type f -print0|xargs -0 md5sum -r|sort|perl -ne 'use File::Copy;chomp;$ph=$h;$pf=$f;($h,$f)=split(/\s+/,$_,2); $t = length $f > length $pf ? $f : $pf; unlink($t) if ($h eq $ph)'
}
function ext-ip {
  curl http://whatismyip.org; echo;
}
function recent {
  find . -type f -mmin "-$1" -not -wholename '*.svn*' -exec ls -la {} \;
}
