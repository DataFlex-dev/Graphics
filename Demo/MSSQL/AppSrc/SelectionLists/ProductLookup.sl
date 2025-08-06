Use Windows.pkg
Use DFClient.pkg

Use cDbCJGridPromptList.pkg
Use cdbCJGridColumn.pkg

Use Classes\cSelectionListOkButton.pkg
Use Classes\cSelectionListCancelButton.pkg
Use Classes\cSelectionListSearchButton.pkg

Use cProductDataDictionary.dd

Object oProductLookup is a dbModalPanel
    Object oProduct_DD is a cProductDataDictionary
    End_Object

    Set Main_DD to oProduct_DD
    Set Server to oProduct_DD

    Set Size to 133 293
    Set Location to 4 5
    Set Border_Style to Border_Thick
    Set Label to "Select a Product"

    Object oSelList is a cDbCJGridPromptList
        Set Size to 105 280
        Set Location to 5 5

        Object oProduct_Name is a cDbCJGridColumn
            Entry_Item Product.Name
            Set piWidth to 467
            Set psCaption to "Name"
        End_Object
    End_Object

    Object oOkButton is a cSelectionListOkButton
        Set Location to 115 127
        Set phoList to oSellist
    End_Object

    Object oCancelButton is a cSelectionListCancelButton
        Set Location to 115 181
        Set phoList to oSellist
    End_Object

    Object oSearch_bn is a cSelectionListSearchButton
        Set Location to 115 236
        Set phoList to oSellist
    End_Object
End_Object
