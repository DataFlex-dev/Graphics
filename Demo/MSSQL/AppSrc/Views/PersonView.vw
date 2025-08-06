Use Windows.pkg
Use DFClient.pkg
Use DFEntry.pkg
Use Dfspnent.pkg
Use cDbTextEdit.pkg
Use dfTabDlg.pkg
Use cCJGridColumnRowIndicator.pkg
Use cCJStandardCommandBarSystem.pkg
Use cCJCommandBarSystem.pkg
Use cDbCJGrid.pkg
Use File_dlg.pkg

Use Dialogs\Histogram.dg

Use cDbImageContainer.pkg

Use cPersonDataDictionary.dd
Use cPersonPhotoDataDictionary.dd
Use cProductDataDictionary.dd
Use cPersonProductDataDictionary.dd

Activate_View Activate_oPersonView for oPersonView
Object oPersonView is a dbView
    Object oProduct_DD is a cProductDataDictionary
    End_Object

    Object oPerson_DD is a cPersonDataDictionary
        Set Allow_Foreign_New_Save_State to True
    End_Object

    Object oPersonProduct_DD is a cPersonProductDataDictionary
        Set Constrain_file to Person.File_number
        Set DDO_Server to oPerson_DD
        Set DDO_Server to oProduct_DD
    End_Object

    Object oPersonPhoto_DD is a cPersonPhotoDataDictionary
        Set Constrain_file to Person.File_number
        Set DDO_Server to oPerson_DD
    End_Object

    Set Main_DD to oPerson_DD
    Set Server to oPerson_DD

    Set Border_Style to Border_Normal
    Set Size to 342 521
    Set Location to 2 2
    Set Label to "Persons"
    Set Icon to "Default.Ico"
    Set pbAutoActivate to True

    Object oPerson_ID is a dbForm
        Entry_Item Person.ID
        Set Location to 5 65
        Set Size to 13 42
        Set Label to "ID:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
    End_Object

    Object oFullName is a dbForm
        Entry_Item (Person.LastName - ',' - Person.FirstName)
        Set Location to 5 157
        Set Size to 13 356
        Set Label to "Full Name:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
    End_Object

    Object oPersonTabDialog is a dbTabDialog
        Set Size to 311 508
        Set Location to 26 7

        Object oInformationTabPage is a dbTabPage
            Set Label to "Information"

            Object oPerson_LastName is a dbForm
                Entry_Item Person.LastName
                Set Location to 5 65
                Set Size to 13 186
                Set Label to "Last Name:"
                Set Label_Justification_Mode to JMode_Right
                Set Label_Col_Offset to 2
            End_Object

            Object oPerson_FirstName is a dbForm
                Entry_Item Person.FirstName
                Set Location to 20 65
                Set Size to 13 186
                Set Label to "First Name:"
                Set Label_Justification_Mode to JMode_Right
                Set Label_Col_Offset to 2
            End_Object

            Object oPerson_MiddleInitials is a dbForm
                Entry_Item Person.MiddleInitials
                Set Location to 35 65
                Set Size to 13 86
                Set Label to "Middle Initials:"
                Set Label_Justification_Mode to JMode_Right
                Set Label_Col_Offset to 2
            End_Object

            Object oPerson_Birthdate is a dbForm
                Entry_Item Person.Birthdate
                Set Location to 50 65
                Set Size to 13 66
                Set Label to "Birth Date:"
                Set Label_Justification_Mode to JMode_Right
                Set Label_Col_Offset to 2
            End_Object

            Object oPerson_StartedWithDF is a dbSpinForm
                Entry_Item Person.StartedWithDF
                Set Location to 65 65
                Set Size to 13 41
                Set Label to "Started with DF:"
                Set Label_Justification_Mode to JMode_Right
                Set Label_Col_Offset to 2
            End_Object

            Object oPerson_Comments is a cDbTextEdit
                Entry_Item Person.Comments
                Set Location to 94 5
                Set Size to 196 494
                Set Label to "Comments:"
                Set peAnchors to anAll
            End_Object
        End_Object

        Object oProductTabPage is a dbTabPage
            Set Label to "Products"
            Set Server to oPersonProduct_DD

            Object oProductsGrid is a cDbCJGrid
                Set Size to 285 224
                Set Location to 5 5
                Set peAnchors to anTopBottomLeft

                Function DeleteThisProductReference Returns Boolean
                    Boolean bDoNotDelete

                    Get Confirm (SFormat ("Delete '%1' Product Reference From '%2'", Trim (Product.Name), Trim (Person.LastName - ',' - Person.FirstName))) to bDoNotDelete

                    Function_Return bDoNotDelete
                End_Function

                Set Verify_Delete_msg to (RefFunc (DeleteThisProductReference))

                Object oProduct_Name is a cDbCJGridColumn
                    Entry_Item Product.Name
                    Set piWidth to 215
                    Set psCaption to "Name"
                End_Object
            End_Object

            Object oProduct_Image is a cDbImageContainer
                Entry_Item Product.Image
                Set Location to 5 234
                Set Size to 285 266
                Set peAnchors to anAll
                Set pbAutoTooltip to False
                Set peImageStyle to ifOriginal
                Set pcBackColor to (GetSysColor (clBtnFace iand $FFFFFF))
                Set psToolTip to "Photo of the products that the current person is familiar with"
            End_Object
        End_Object

        Object oPhotosTabPage is a dbTabPage
            Set Label to "Photos"
            Set Server to oPersonPhoto_DD
            Set Auto_Clear_DEO_State to False

            Object oImageContainer is a dbContainer3d
                Set Location to 5 238
                Set Border_Style to Border_None
                Set Size to 285 262

                Object oPhotosCommandBarSystem is a cCJCommandBarSystem
                    Object oPhotosToolbar is a cCJToolbar
                        Set pbCustomizable to False
                        Set pbCloseable to False
                        Set peBarPosition to xtpBarTop
                        Set peStretched to stStretch
                        Set pbGripper to False

                        Object oAddPhotoMenuItem is a cCJMenuItem
                            Set psCaption to "Add"
                            Set psToolTip to "Add Photo"
                            Set psDescription to "Add Photo"
                            Set psImage to "ActionOpen.ico"
                            Set pbActiveUpdate to True

                            Function IsEnabled Returns Boolean
                                Boolean bEnabled

                                Get HasRecord of oPersonPhoto_DD to bEnabled
                                If (not (bEnabled)) Begin
                                    Get Should_Save of oPersonPhoto_DD to bEnabled
                                End

                                Function_Return bEnabled
                            End_Function

                            Procedure OnExecute Variant vCommandBarControl
                                Send SelectImage of oPersonPhoto_Displayer
                            End_Procedure
                        End_Object

                        Object oSavePhotoMenuItem is a cCJMenuItem
                            Set psImage to "ActionSave.ico"
                            Set psCaption to "Save"
                            Set psDescription to "Save image to disk"
                            Set psToolTip to "Save image to disk"
                            Set pbActiveUpdate to True

                            Function IsEnabled Returns Boolean
                                Boolean bEnabled

                                Get CanCopy of oPersonPhoto_Displayer to bEnabled

                                Function_Return bEnabled
                            End_Function

                            Procedure OnExecute Variant vCommandBarControl
                                Handle hoSaveAsDialog hoWorkspace
                                String sBitmapPaths sFolder sFileName
                                Boolean bSelected
                                Integer iResult

                                Get Create (RefClass (SaveAsDialog)) to hoSaveAsDialog
                                Get phoWorkspace of ghoApplication to hoWorkspace
                                Get psBitmapPath of hoWorkspace to sBitmapPaths
                                Get PathAtIndex of hoWorkspace sBitmapPaths 1 to sFolder
                                Set Initial_Folder of hoSaveAsDialog to sFolder
                                Set Filter_String of hoSaveAsDialog to "Portable Network Graphics|*.png|Bitmaps|*.bmp|Joint Photographic Experts|*.jpg|Graphics Interchange Format|*.gif|Tagged Image File Format|*.tif;*.tiff"
                                Get Show_Dialog of hoSaveAsDialog to bSelected
                                If (bSelected) Begin
                                    Get File_Name of hoSaveAsDialog to sFileName
                                    Get SaveImageToFile of oPersonPhoto_Displayer sFileName to iResult
                                End
                                Send Destroy of hoSaveAsDialog
                            End_Procedure
                        End_Object

                        Object oCopyPhotoMenuItem is a cCJCopyMenuItem
                            Set pbControlBeginGroup to True

                            Procedure OnExecute Variant vCommandBarControl
                                Send Copy of oPersonPhoto_Displayer
                            End_Procedure

                            Function IsEnabled Returns Boolean
                                Boolean bEnabled

                                Get CanCopy of oPersonPhoto_Displayer to bEnabled

                                Function_Return bEnabled
                            End_Function
                        End_Object

                        Object oPastePhotoMenuItem is a cCJPasteMenuItem
                            Procedure OnExecute Variant vCommandBarControl
                                Send Paste of oPersonPhoto_Displayer
                            End_Procedure

                            Function IsEnabled Returns Boolean
                                Boolean bEnabled

                                Get CanPaste of oPersonPhoto_Displayer to bEnabled

                                Function_Return bEnabled
                            End_Function
                        End_Object

                        Object oRotateMenuItem is a cCJMenuItem
                            Set psCaption to "Rotate"
                            Set psImage to "Rotate.ico"
                            Set peControlType to xtpControlButtonPopup
                            Set pbControlBeginGroup to True
                            Set peControlStyle to xtpButtonIcon
                            Set pbActiveUpdate to True
                            Set psToolTip to "Rotate the image"

                            Function IsEnabled Returns Boolean
                                Boolean bEnabled

                                Get CanCopy of oPersonPhoto_Displayer to bEnabled

                                Function_Return bEnabled
                            End_Function

                            Procedure RotateImage Integer eRotateMode
                                Integer iRetval
                                String sStatusText

                                Get RotateImage of oPersonPhoto_Displayer eRotateMode to iRetval
                                If (iRetval <> gpOk) Begin
                                    Get GpStatusText of ghoGDIPlusHandler iRetval to sStatusText
                                    Send Info_Box ("Could not rotate the image (" - sStatusText - ")")
                                End
                            End_Procedure

                            Object oRotate90MenuItem is a cCJMenuItem
                                Set psCaption to "90"
                                Set psTooltip to "90"
                                Set peControlType to xtpControlPopup

                                Object oRotate90FlipNoneMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip None"
                                    Set psTooltip to "Flip None"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate90FlipNone
                                    End_Procedure
                                End_Object

                                Object oRotate90FlipXMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip X"
                                    Set psTooltip to "Flip X"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate90FlipX
                                    End_Procedure
                                End_Object

                                Object oRotate90FlipYMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip Y"
                                    Set psTooltip to "Flip Y"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate90FlipY
                                    End_Procedure
                                End_Object
                            End_Object

                            Object o180MenuItem is a cCJMenuItem
                                Set psCaption to "180"
                                Set psTooltip to "180"
                                Set peControlType to xtpControlPopup

                                Object oRotate180FlipNoneMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip None"
                                    Set psTooltip to "Flip None"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate180FlipNone
                                    End_Procedure
                                End_Object

                                Object oRotate180FlipXMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip X"
                                    Set psTooltip to "Flip X"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate180FlipX
                                    End_Procedure
                                End_Object

                                Object oRotate180FlipYMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip Y"
                                    Set psTooltip to "Flip Y"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate180FlipY
                                    End_Procedure
                                End_Object
                            End_Object

                            Object o270MenuItem is a cCJMenuItem
                                Set psCaption to "270"
                                Set psTooltip to "270"
                                Set peControlType to xtpControlPopup

                                Object oRotate270FlipNoneMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip None"
                                    Set psTooltip to "Flip None"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate270FlipNone
                                    End_Procedure
                                End_Object

                                Object oRotate270FlipXMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip X"
                                    Set psTooltip to "Flip X"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate270FlipX
                                    End_Procedure
                                End_Object

                                Object oRotate270FlipYMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip Y"
                                    Set psTooltip to "Flip Y"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotate270FlipY
                                    End_Procedure
                                End_Object
                            End_Object

                            Object oFlipMenuItem is a cCJMenuItem
                                Set psCaption to "Flip"
                                Set psTooltip to "Flip"
                                Set peControlType to xtpControlPopup

                                Object oFlipXMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip X"
                                    Set psTooltip to "Flip X"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotateNoneFlipX
                                    End_Procedure
                                End_Object

                                Object oFlipYMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip Y"
                                    Set psTooltip to "Flip Y"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotateNoneFlipy
                                    End_Procedure
                                End_Object

                                Object oFlipXYMenuItem is a cCJMenuItem
                                    Set psCaption to "Flip X && Y"
                                    Set psTooltip to "Flip X && Y"

                                    Procedure OnExecute Variant vCommandBarControl
                                        Send RotateImage gpRotateNoneFlipXY
                                    End_Procedure
                                End_Object
                            End_Object
                        End_Object

                        Object oHistogramMenuItem is a cCJMenuItem
                            Set psCaption to "Histogram"
                            Set psImage to "Histogram.ico"
                            Set psToolTip to "Draw a Color Usage Histogram from the current Image"
                            Set pbActiveUpdate to True

                            Function IsEnabled Returns Boolean
                                Boolean bEnabled

                                Get CanCopy of oPersonPhoto_Displayer to bEnabled

                                Function_Return bEnabled
                            End_Function

                            Procedure OnExecute Variant vCommandBarControl
                                Send DrawHistogram of oPersonPhoto_Displayer
                            End_Procedure
                        End_Object
                    End_Object
                End_Object

                Object oPersonPhoto_Displayer is a cDbImageContainer
                    Entry_Item PersonPhoto.Image
                    Set Location to 16 3
                    Set Size to 262 254
                    Set psToolTip to "Photo of this person at the location and time highlighted at the left"
                    Set peImageStyle to ifOriginal
                    Set pcBackColor to (GetSysColor (clBtnFace iand $FFFFFF))

                    Procedure DrawHistogram
                        Handle hoImage

                        Get phoImage to hoImage
                        If (hoImage <> 0) Begin
                            Send DrawHistogram of oHistogramDialog hoImage
                        End
                    End_Procedure
                End_Object
            End_Object

            Object oPhotosGrid is a cDbCJGrid
                Set Size to 189 224
                Set Location to 5 5
                Set pbUseAlternateRowBackgroundColor to True
                Set pbShowRowFocus to True
                Set peVisualTheme to xtpGridThemeVisualStudio2012Light

                Function DeleteThisPersonPhoto Returns Boolean
                    Boolean bDoNotDelete

                    Get Confirm (SFormat ("Delete This Photo Reference of '%1'", Trim (Person.LastName - ',' - Person.FirstName))) to bDoNotDelete

                    Function_Return bDoNotDelete
                End_Function

                Set Verify_Delete_msg to (RefFunc (DeleteThisPersonPhoto))

                Object oCJGridColumnRowIndicator is a cCJGridColumnRowIndicator
                End_Object

                Object oPersonPhoto_Added is a cDbCJGridColumn
                    Entry_Item PersonPhoto.Added
                    Set piWidth to 50
                    Set psCaption to "Added"
                End_Object

                Object oPersonPhoto_MadeInYear is a cDbCJGridColumn
                    Entry_Item PersonPhoto.MadeInYear
                    Set piWidth to 36
                    Set psCaption to "Year"
                End_Object

                Object oPersonPhoto_MakeInMonth is a cDbCJGridColumn
                    Entry_Item PersonPhoto.MakeInMonth
                    Set piWidth to 36
                    Set psCaption to "Month"
                End_Object

                Object oPersonPhoto_Where is a cDbCJGridColumn
                    Entry_Item PersonPhoto.Where
                    Set piWidth to 100
                    Set psCaption to "Where"
                End_Object
            End_Object

            Object oPersonPhoto_Comments is a cDbTextEdit
                Entry_Item PersonPhoto.Comments
                Set Location to 210 5
                Set Size to 81 224
                Set Label to "Comments:"
            End_Object
        End_Object
    End_Object

    //-----------------------------------------------------------------------
    // Change:   Create custom confirmation messages for save and delete
    //           We must create the new functions and assign verify messages
    //           to them.
    //-----------------------------------------------------------------------
    Function ConfirmDeletePerson Returns Integer
        Integer iRetVal

        Get Confirm "Delete this Person?" to iRetVal

        Function_Return iRetVal
    End_Function

    // Only confirm on the saving of new records
    Function ConfirmSavePerson Returns Integer
        Integer iNoSave
        Boolean bOld

        // Check to see if the Person data dictionary already contains
        // a record. This question will only be asked in case of a NEW record.
        Get HasRecord of oPerson_DD to bOld
        If (not (bOld)) Begin
            Get Confirm "Save this NEW Person?" to iNoSave
        End

        Function_Return iNoSave
    End_Function

    // Define alternate confirmation Messages
    Set Verify_Save_Msg to (RefFunc (ConfirmSavePerson))
    Set Verify_Delete_Msg to (RefFunc (ConfirmDeletePerson))
End_Object
