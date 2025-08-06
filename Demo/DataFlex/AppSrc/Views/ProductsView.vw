Use Windows.pkg
Use DFClient.pkg
Use DFEntry.pkg
Use cCJStandardCommandBarSystem.pkg
Use cCJCommandBarSystem.pkg

Use Classes\cWSDbImageContainer.pkg

Use cProductDataDictionary.dd

Deferred_View Activate_oProductsView for ;
Object oProductsView is a dbView
    Object oProduct_DD is a cProductDataDictionary
    End_Object

    Set Main_DD to oProduct_DD
    Set Server to oProduct_DD

    Set Border_Style to Border_Normal
    Set Size to 263 369
    Set Location to 2 2
    Set Label to "Products"
    Set Icon to "Default.Ico"

    Object oProduct_ID is a dbForm
        Entry_Item Product.ID
        Set Location to 5 55
        Set Size to 13 30
        Set Label to "ID:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
    End_Object

    Object oProduct_Name is a dbForm
        Entry_Item Product.Name
        Set Location to 20 55
        Set Size to 13 306
        Set Label to "Name:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
    End_Object

    Object oProductsContainer is a dbContainer3d
        Set Size to 224 306
        Set Location to 35 55
        Set Border_Style to Border_None

        Object oProductPhotoCommandBarSystem is a cCJCommandBarSystem
            Object oPhotosToolbar is a cCJToolbar
                Set pbCustomizable to False
                Set pbCloseable to False
                Set peStretched to stStretch
                Set pbGripper to False

                Object oAddPhotoMenuItem is a cCJMenuItem
                    Set psCaption to "Add"
                    Set psToolTip to "Add Photo"
                    Set psDescription to "Add Photo"
                    Set psImage to "ActionOpen.ico"

                    Procedure OnExecute Variant vCommandBarControl
                        Send SelectImage of oProduct_Image
                    End_Procedure
                End_Object

                Object oCopyPhotoMenuItem is a cCJCopyMenuItem
                    Set pbControlBeginGroup to True

                    Procedure OnExecute Variant vCommandBarControl
                        Send Copy of oProduct_Image
                    End_Procedure

                    Function IsEnabled Returns Boolean
                        Boolean bEnabled

                        Get CanCopy of oProduct_Image to bEnabled

                        Function_Return bEnabled
                    End_Function
                End_Object

                Object oPastePhotoMenuItem is a cCJMenuItem
                    Set psImage to "ActionPaste.ico"
                    Set psCaption to "Paste"
                    Set psDescription to "Paste image from Clipboard"
                    Set psToolTip to "Paste image from Clipboard"

                    Procedure OnExecute Variant vCommandBarControl
                        Send Paste of oProduct_Image
                    End_Procedure

                    Function IsEnabled Returns Boolean
                        Boolean bEnabled

                        Get CanPaste of oProduct_Image to bEnabled

                        Function_Return bEnabled
                    End_Function
                End_Object
            End_Object
        End_Object

        Object oProduct_Image is a cWSDbImageContainer
            Entry_Item Product.FileName
            Set Location to 18 0
            Set Size to 205 306
            Set Server to oProduct_DD
            Set psToolTip to "Product image. Select a different image by clicking the select image button in the toolbar"
            Set pbAutoTooltip to False
            Set pbShowScrollBars to False
            Set peImageStyle to ifOriginal
        End_Object
    End_Object
Cd_End_Object
