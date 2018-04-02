xquery version "1.0";

declare variable $catalog :="../plant_catalog.xml";
declare variable $order :="../plant_order.xml";

declare option saxon:output "indent=yes";

<PRICE>
{
  sum(for $p in doc($order)//PLANT
  return
    $p/QUANTITY*number(substring(doc($catalog)//PLANT[COMMON = $p/COMMON]/PRICE,2)))
    }
</PRICE>
