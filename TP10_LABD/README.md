Binôme : AFRASS ILIAS & TAIBI ANAS


==================== TP10 LABD : Initiation à SPARQL ===========================

-------------- Exercice 1 : Interrogation de l'instance rdf seule --------------
1.
La requête sélectionne tous les x qui ont un type.
Il y en a 33 réponses.
John est de type Personne.

select ?x ?t where {
  ?x rdf:type ?t
  FILTER regex(?x,"John")
}

2.
Cette requete demande toutes les personnes qui sont mariées.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT (COUNT(* ) as ?count) WHERE {
  ?x humans:hasSpouse ?y
}
On obtient 6 réponses.

3.
la propriété utilisée pour donner l'age des personnes est age.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x ?y WHERE{
  ?x humans:age ?y
  FILTER (xsd:integer(?y)>20)
}

4.
la propriété utilisée pour donner la pointure des chaussures des personnes est shoesize.

4.1
PREFIX humans <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x ?y WHERE
{
    ?x humans:shoesize ?y
}

4.2
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?person ?size WHERE
{
    ?person a humans:Person
    OPTIONAL {?person humans:shoesize ?size}
}

4.3
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?person ?size WHERE
{
    ?person a humans:Person
    OPTIONAL {?person humans:shoesize ?size
        FILTER (xsd:integer(?size) > 8)
    }
}

4.4
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?person ?shirtsize ?shoesize WHERE
{
    ?person a humans:Person
    {
        ?person humans:shoesize ?shoesize
        FILTER (xsd:integer(?shoesize) > 8)
    } UNION
    {
        ?person humans:shirtsize ?shirtsize
        FILTER (xsd:integer(?shirtsize) > 12)
    }
}

5.1
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?y WHERE {
  ?x a humans:Person
  ?x  ?y ?z
  FILTER regex(?x , "John")
}

5.2
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
DESCRIBE ?x WHERE {
  ?x a humans:Person
  FILTER regex(?x , "John")
}

6.1
Propriété hasFather :
John est le père de Mark.

Propriété hasMother :
Catherine est la mère de Lucas.

Propriété hasChild nous avons :
Harry est le père de John.
Jack est le père de Harry.
Flora est la mère de Pierre.
Gaston est le père de Pierre.
Gaston est le père de Jack.
Laura est la mère de Catherine.

6.2
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT ?x ?t WHERE
{
 ?x humans:hasChild ?t
OPTIONAL {
{?x humans:hasChild ?t
?t humans:hasFather ?x}
UNION
{?x humans:hasChild ?t
?t humans:hasMother ?x}
}
}

6.3
<?xml version="1.0" ?>
<sparql xmlns='http://www.w3.org/2005/sparql-results#'>
<head>
<variable name='x'/>
<variable name='t'/>
</head>
<results>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Harry</uri></binding>
<binding name='t'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#John</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Gaston</uri></binding>
<binding name='t'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Jack</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Gaston</uri></binding>
<binding name='t'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Pierre</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Jack</uri></binding>
<binding name='t'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Harry</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Flora</uri></binding>
<binding name='t'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Pierre</uri></binding>
</result>
</results>
</sparql>

On obtient 5 réponses dont 1 doublon (gaston).

6.4
on ajoute le mot DISTINCT.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT distinct ?x  WHERE
{
 ?x humans:hasChild ?t
OPTIONAL {
{?x humans:hasChild ?t
?t humans:hasFather ?x}
UNION
{?x humans:hasChild ?t
?t humans:hasMother ?x}
}
}

<?xml version="1.0" ?>
<sparql xmlns='http://www.w3.org/2005/sparql-results#'>
<head>
<variable name='x'/>
</head>
<results>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Harry</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Gaston</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Jack</uri></binding>
</result>
<result>
<binding name='x'><uri>http://www.inria.fr/2007/09/11/humans.rdfs-instances#Flora</uri></binding>
</result>
</results>
</sparql>

On obtient 4 réponses.

6.5
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT ?x WHERE {
  ?x a humans:Man
  FILTER NOT EXISTS {
    {?x humans:hasChild ?y}
    UNION
    {?y humans:hasFather ?x}}
}

6.6
Flora est mariée, elle a un enfant : Pierre. Jennifer est mariée également.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT DISTINCT ?x ?z WHERE {
  ?x a humans:Woman
  ?y humans:hasSpouse ?x
  OPTIONAL{
  {?x humans:hasChild ?z}
  UNION
  {?z humans:hasMother ?x}
}
}

7.


PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT ?x ?y WHERE {
?x a humans:Person
?y a humans:Person
?x humans:shirtsize ?yz
?y humans:shirtsize ?zy

FILTER (?x > ?y)
FILTER (xsd:integer(?yz) = xsd:integer(?zy))
}

8.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
CONSTRUCT {
     ?y humans:hasFriend ?x
}
WHERE {
     ?x humans:hasFriend ?y
     FILTER NOT EXISTS {?y humans:hasFriend ?x}
}

9.
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT DISTINCT * WHERE
{
  ?x a humans:Person
  FILTER NOT EXISTS {?x a humans:Man}
}

-------------- Exercice 2 : Interrogation du schéma RDFS seul ------------------

1.
L'espace de nom est le suivant : http://www.inria.fr/2007/09/11/humans.rdfs

<#hasAncestor> rdfs:domain <#Animal>
<#hasAncestor> rdfs:range <#Animal>
<#hasFather> rdfs:range <#Male>
<#hasMother> rdfs:range <#Female>
<#hasBrother> rdfs:domain <#Animal>
<#hasBrother> rdfs:range <#Male>
<#hasSister> rdfs:domain <#Animal>
<#hasSister> rdfs:range <#Female>
<#hasFriend> rdfs:domain <#Person>
<#hasFriend> rdfs:range <#Person>
<#shoesize> rdfs:domain <#Person>
<#shirtsize> rdfs:domain <#Person>
<#trouserssize> rdfs:domain <#Person>
<#hasSpouse> rdfs:domain <#Person>
<#hasSpouse> rdfs:range <#Person>

La propriété age peut porter sur toutes les classes de l'espace de nom humans.

2.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>

SELECT ?x WHERE {
  ?x a rdfs:Class
}

3.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x ?y WHERE {
  ?x rdfs:subClassOf ?y
}

4.

PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?y ?x WHERE {
  humans:shoesize rdfs:label ?y
  humans:shoesize rdfs:comment ?x
  FILTER regex(?y, "shoe size")
}

5.
PREFIX humans: <http://www.inria.fr/2007/09/11/humans.rdfs#>
SELECT ?x WHERE {
     humans:Person rdfs:label ?x
     FILTER (LANG(?x) = "" || LANGMATCHES(LANG(?x), "fr"))
}

<?xml version="1.0" ?>
<sparql xmlns='http://www.w3.org/2005/sparql-results#'>
<head>
<variable name='x'/>
</head>
<results>
<result>
<binding name='x'><literal xml:lang='fr'>homme</literal></binding>
</result>
<result>
<binding name='x'><literal xml:lang='fr'>personne</literal></binding>
</result>
<result>
<binding name='x'><literal xml:lang='fr'>être humain</literal></binding>
</result>
<result>
<binding name='x'><literal xml:lang='fr'>humain</literal></binding>
</result>
</results>
</sparql>
