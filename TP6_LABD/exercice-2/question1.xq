xquery version "1.0";

declare option saxon:output "indent=yes";
declare variable $maisons :="maisons.xml";

<html>
  <table border="1">
    <tr>
      <th>Maisons</th>
      <th>Surfaces(m2)</th>
    </tr>
    {
    for $maison in doc($maisons)//maison
    return
      <tr>
        <td> Maison {data($maison/@id)}</td>
        <td> {sum($maison/*/*/@surface-m2)}</td>
      </tr>
    }
  </table>
</html>
