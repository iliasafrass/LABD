xquery version "1.0";
declare default element namespace "http://www.inria.fr/2007/09/11/humans.rdfs#";
declare option saxon:output "omit-xml-declaration=yes";

<results>
{
let $humans := "human_2007_09_11.rdf"
for $person in doc($humans)//Person[shirtsize/text()]
  return <result>
		<name>{$person/name/text()}</name>
		<shirtsize>{$person/shirtsize/text()}</shirtsize>
  </result>
}
</results>