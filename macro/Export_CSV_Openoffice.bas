Sub Export_to_CSV
Dim oDoc as Object, oFeuilles() as Variant, pieces() as String, oURL as String, i as Integer
Dim args(1) As New com.sun.star.beans.PropertyValue
   oDoc = ThisComponent
   args(0).name = "FilterName"
   args(0).value = "Text - txt - csv (StarCalc)"
   args(1).name = "FilterOptions"
   args(1).value = "59,39,ANSI,,0,false"
   
   
   'le tableau oFeuilles correspond à l'indice des onglets à exporter
   oFeuilles = ThisComponent.Sheets
   
 
  For i = 0 to oFeuilles.getCount()-1
 oDoc.CurrentController.ActiveSheet = oDoc.Sheets(i)
  	If StrComp(oFeuilles.getByIndex(i).Name,"Matrice_Agent_Comp")<>0 Then 	  
      pieces = Split(oDoc.URL,"/")
      pieces(UBound(pieces)) = oFeuilles.getByIndex(i).Name & ".csv"
      oURL = Join(pieces,"/")
      oDoc.StoreToURL(oURL,args)
    
	End If
   Next i 
 MsgBox "Les fichiers ont été crées avec succés !"  
End Sub
