xquery version "1.0";

declare option saxon:output "indent=yes";
declare variable $catalog :="../plant_catalog.xml";
declare variable $family :="../plant_families.xml";

<CATALOG>
{
for $l in distinct-values(doc($catalog)//LIGHT)
order by $l
return
<LIGHT>
  <EXPOSURE>
    {fn:data($l)}
  </EXPOSURE>
  {
    for $p in doc($catalog)//PLANT
    where $p/LIGHT=$l
    order by $p/COMMON
    return
    <PLANT>
      {$p/*[name()!="LIGHT"]}
      <FAMILY>
        {data(doc($family)//SPECIES[.=$p/BOTANICAL]/../NAME)}
      </FAMILY>
    </PLANT>
  }
</LIGHT>
}
</CATALOG>
