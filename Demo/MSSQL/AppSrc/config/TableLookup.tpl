Use Windows.pkg
Use DFClient.pkg
Use DFSellst.pkg
Use cSelectionListOkButton.pkg
Use cSelectionListCancelButton.pkg
Use cSelectionListSearchButton.pkg

Object oLookUp_pnl is a dbModalPanel
    Set Size to 133 292
    Set Location to 4 5
    Set Border_Style to Border_Thick

    Object oSelList is a dbList
        Set peAnchors to anAll
        Set Size to 105 280
        Set Location  to 6 6
    End_Object

    Object oOkButton is a cSelectionListOkButton
        Set Location to 115 127
		Set phoList to oSelList
    End_Object

    Object oCancelButton is a cSelectionListCancelButton
        Set Location to 115 181
		Set phoList to oSelList
    End_Object

    Object oSearch_bn is a cSelectionListSearchButton
        Set Location to 115 236
		Set phoList to oSelList
    End_Object
End_Object

