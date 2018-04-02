declare variable $bib := "biblio.xml" ;

declare option saxon:output "indent=yes";

<bib>
   {
   for $b in doc($bib)//book
   where $b/publisher = "Addison-Wesley" and
       $b/@year > 1991
   return
      <book year="{$b/@year}">
         {$b/title}
      </book>
   }
</bib>
