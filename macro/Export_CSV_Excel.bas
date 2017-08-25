Rem Attribute VBA_ModuleType=VBAModule
Option VBASupport 1
Sub Export_CSV_Excel()
'
' Export_CSV_Excel Macro
'

'
Dim wbk As Workbook
Dim chemin As String
Set wbk = ThisWorkbook
Dim wb As Workbook

chemin = ThisWorkbook.Path
For Each sh In ThisWorkbook.Sheets

    If StrComp(sh.Name, "Matrice_Agent_Comp") <> 0 Then
    Set wb = Workbooks.Add(xlWBATWorksheet)
     wbk.Activate 'Fichier sélectionné activé
            sh.Select 'Onglet activé
            Cells.Select 'Feuille entièrement sélectionnée
            Selection.Copy
            wb.Activate 'Fichier Onglet numéro 2 activé
            Selection.PasteSpecial Paste:=xlPasteValues 'Collage spécial valeurs
    wb.SaveAs Filename:=ThisWorkbook.Path & "/" & sh.Name, FileFormat:=xlCSV, CreateBackup:=False, Local:=True
    wb.Close savechanges:=False
    End If
 Next
     MsgBox "Fichiers crées avec succés !"
     wbk.Activate
End Sub

