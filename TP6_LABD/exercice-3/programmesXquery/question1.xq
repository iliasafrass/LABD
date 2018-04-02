xquery version "1.0";

declare variable $catalog :="../plant_catalog.xml";
declare variable $family :="../plant_families.xml";

declare option saxon:output "indent=yes";

<CATALOG>
  {
    for $plant in doc($catalog)//PLANT
    return
    <PLANT>
      {$plant/*}
      <FAMILY>
        {data(doc($family)//SPECIES[.=$plant/BOTANICAL]/../NAME)}
      </FAMILY>
    </PLANT>
  }
</CATALOG>
