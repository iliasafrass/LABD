xquery version "1.0";


declare default element namespace "http://www.expression.org";
declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "indent=yes";

(:================================ QUESTION1 =======================================:)

declare function local:printRec($name){
  if(name($name)='op')then
    concat("(",local:printRec($name/*[1]),$name/@val,local:printRec($name/*[2]),")")
  else
    ($name)
};

declare function local:print($name as xs:string) as xs:string{
  local:printRec(doc($name)/expr/*)
};
(:====================================================================================:)

(:================================ QUESTION2 =========================================:)

declare function local:evalExpression($name as node()) as xs:integer{
  if(name($name)="op")then
    let $filsG := xs:integer(local:evalExpression($name/*[1]))
    let $filsD := xs:integer(local:evalExpression($name/*[2]))
    return local:evalCalcul($name,$filsG,$filsD)
  else if (name($name) = "cons") then
    xs:integer($name/text())
  else
    fn:error(xs:QName("Error"), "l'expression ne doit pas contenir une variable!")
};

declare function local:evalCalcul($noeud as node(), $filsG as xs:integer, $filsD as xs:integer) as xs:integer{
	if ($noeud/@val = "+") then
		$filsG + $filsD
	else if ($noeud/@val = "-") then
		$filsG - $filsD
	else if ($noeud/@val = "*") then
		$filsG * $filsD
	else
    if(xs:string($filsD) = "0")then
       fn:error(xs:QName("Error"), "impossible de diviser par 0!")
    else
      xs:integer($filsG idiv $filsD)
};

declare function local:eval($name as xs:string) as xs:integer{
  local:evalExpression(doc($name)/expr/*)
};

(:====================================================================================:)

(:================================ QUESTION3 =========================================:)

declare function local:evalVariable($name , $variables) as xs:integer{
if (name($name) = "op") then
		let $filsG := xs:integer(local:evalVariable($name/*[1], $variables))
		let $filsD := xs:integer(local:evalVariable($name/*[2], $variables))
		return local:evalCalcul($name, $filsG, $filsD)
	else if (name($name) = "cons") then
		xs:integer($name/text())
	else
		local:trouverVar($name, $variables)
};

declare function local:trouverVar($name, $variables) as xs:integer{
    if (count($variables//*[name() = $name]) = 0) then
        fn:error(xs:QName("Error"), "variable n'existe pas dans le ficher")
    else if (count($variables//*[name() = $name]) > 1) then
        fn:error(xs:QName("Error"), "variable apparaît plusieurs fois dans le fichier")
    else
        xs:integer($variables//*[name() = $name])
};

declare function local:eval-var($name as xs:string, $variables as xs:string) as xs:integer{
    local:evalVariable(doc($name)/expr/*,doc($variables)/*)
};
(:====================================================================================:)

(:================================ QUESTION4 =========================================:)

declare function local:simplifier_rec($name, $variables) as element()
{
    if(name($name)="op") then
        let $filsG := local:simplifier_rec($name/*[1],$variables)
        let $filsD := local:simplifier_rec($name/*[2],$variables)
        let $operator := $name/@val
        return local:simplifie_eval_operat($operator ,$filsG , $filsD,$variables)
    else if (name($name)="cons") then
        <cons> {fn:data($name)} </cons>
    else
        if (count($variables//*[name() = $name]) = 0) then
            <var>{$name/text()}</var>
        else if (count($variables//*[name() = $name]) > 1) then
            fn:error(xs:QName("Error"), "variable apparaît plusieurs fois dans le fichier")
        else
            <cons>{$variables//*[name() = $name]}</cons>
};

declare function local:simplifie_eval_operat( $op as xs:string ,$gauche as element(),$droit as element(), $variables) as element()
{
    if (name($gauche) = "cons" and name($droit) ="cons") then
        if ($op = "+") then
            <cons>{$gauche/text() + $droit/text()}</cons>
        else if ($op = "-") then
            <cons>{$gauche/text() - $droit/text()}</cons>
        else if ($op = "*") then
            <cons>{$gauche/text() * $droit/text()}</cons>
        else
            <cons>{$gauche/text() idiv $droit/text()}</cons>
    else
        if ($op = "+") then
            <op val="+">{$gauche} {$droit}</op>
        else if ($op = "-") then
            <op val="-">{$gauche} {$droit}</op>
        else if ($op = "*") then
            <op val="*">{$gauche} {$droit}</op>
        else
            <op val="/">{$gauche} {$droit}</op>
};

declare function local:simplifie($name as xs:string , $variables as xs:string) as element(){
<expr xsi:schemaLocation="http://www.expression.org expression.xsd"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsmlns="http://www.expression.org">
{
    xs:string(local:simplifier_rec(doc($name)/expr/*,doc($variables)/*))
}
</expr>
};

(:====================================================================================:)

(:pour generer l'expression : java -jar gen.jar -o expressionGen.xml:)
(:java -cp saxon9he.jar net.sf.saxon.Query expression.xq :)

let $exp := "expression.xml"
let $expGen := "expressionGen.xml"
let $expE1 := "expressionE1.xml"
let $var := "variables.xml"

(: Question 1 :)
(: return  local:print($expGen) :)

(: Question 2 :)
(: return  local:eval($expE1) :)

(: Question 3 :)
(: return  local:eval-var($exp,$var) :)

(: Question 4 :)
return  local:simplifie($exp,$var)
