Use Windows.pkg
Use DFClient.pkg

Use cDbCJGridPromptList.pkg
Use cdbCJGridColumn.pkg

Use cPersonDataDictionary.dd

Use Classes\cSelectionListOkButton.pkg
Use Classes\cSelectionListCancelButton.pkg
Use Classes\cSelectionListSearchButton.pkg

CD_Popup_Object oPersonLookup is a dbModalPanel
    Set Location to 5 5
    Set Size to 134 380
    Set Label To "Person Lookup List"
    Set Border_Style to Border_Thick
    Set Minimize_Icon to False
    Set Icon to "Default.Ico"
    Set piMinSize to 134 380
    Set piMaxSize to 300 500

    Object oPerson_DD Is A cPersonDataDictionary
    End_Object

    Set Main_DD To oPerson_DD
    Set Server to oPerson_DD

    Object oSellist is a cDbCJGridPromptList
        Set Size to 100 370
        Set Location to 5 5

        Object oPerson_LastName is a cDbCJGridColumn
            Entry_Item Person.LastName
            Set piWidth to 251
            Set psCaption to "Short Name"
        End_Object

        Object oPerson_FirstName is a cDbCJGridColumn
            Entry_Item Person.FirstName
            Set piWidth to 252
            Set psCaption to "FirstName"
        End_Object

        Object oPerson_Birthdate is a cDbCJGridColumn
            Entry_Item Person.Birthdate
            Set piWidth to 114
            Set psCaption to "Birthdate"
        End_Object
    End_Object

    Object oOkButton is a cSelectionListOkButton
        Set Location to 115 217
        Set phoList to oSellist
    End_Object

    Object oCancelButton is a cSelectionListCancelButton
        Set Location to 115 271
        Set phoList to oSellist
    End_Object

    Object oSearch_bn is a cSelectionListSearchButton
        Set Location to 115 325
        Set phoList to oSellist
    End_Object
CD_End_Object
