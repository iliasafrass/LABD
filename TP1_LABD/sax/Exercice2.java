package labd ;

import org.xml.sax.*;
import org.xml.sax.helpers.* ;
import java.io.IOException;

/**
 * @author yves.roos
 *
 * Exemple d'implementation d'un ContentHandler.
 */



public class Exercice2 extends DefaultHandler {

	private float surface = 0;
  private boolean lock = false;

	public void startElement(String nameSpaceURI, String localName, String rawName, Attributes attributs) throws SAXException {

  	for (int index = 0; index < attributs.getLength(); index++) { // on parcourt la liste des attributs
			if(attributs.getLocalName(index).equals("id"))
				System.out.println("Maison "+attributs.getValue(index)+":");
			if (attributs.getLocalName(index) == "surface-m2"){
				if(!lock){
        	surface += Float.valueOf(attributs.getValue(index));
					lock = true;
					}
			}
		}
  }

  public void endElement(String nameSpaceURI, String localName, String rawName) throws SAXException {
		if (localName == "maison"){
			System.out.println("\tSuperficie Totale : "+ surface + " m2");
      surface = 0;
		}
		lock = false;
	}




	public static void main(String[] args) {
		try {
			XMLReader saxReader = XMLReaderFactory.createXMLReader();
			saxReader.setContentHandler(new Exercice2());
			saxReader.parse(args[0]);
		} catch (Exception t) {
			t.printStackTrace();
		}
	}


}
