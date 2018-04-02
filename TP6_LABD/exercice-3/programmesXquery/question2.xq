xquery version "1.0";

declare option saxon:output "indent=yes";
declare variable $catalog :="../plant_catalog.xml";

<CATALOG>
{
for $l in distinct-values(doc($catalog)//LIGHT)
return
<LIGHT>
  <EXPOSURE>
    {fn:data($l)}
  </EXPOSURE>
  {
    for $p in doc($catalog)//PLANT
    where $p/LIGHT=$l
    return
    <PLANT>
      {$p/*[name()!="LIGHT"]}
    </PLANT>
  }
</LIGHT>
}
</CATALOG>
