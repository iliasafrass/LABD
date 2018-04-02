
declare option saxon:output "indent=yes";

let $bib := "biblio.xml"
return
<bib>
   {
 for $b in doc($bib)//book
   where count($b/author) > 0
   return
      <book>
      {$b/title}
      { for $a in $b/author[position() <= 2]
        return $a }
      { if (count($b/author) > 2)
        then <et-al/> else () }
  </book>
}
</bib>
