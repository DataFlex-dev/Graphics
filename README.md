# Graphics Library

The Graphics Library enables DataFlex applications to display pictures in many nowadays popular graphic formats. The graphic formats supported are Bitmaps (BMP), Icons (ICO), Graphic Interchange Format (GIF). Joint Photographic Experts Group (JPG), Exchangeable Image File Format (EXF), Portable Network Graphics (PNG), Tagged Image File Format (TIFF), Windows Metafile (WMF) and Windows Enhanced Metafile (EMF).

The Graphics Library uses Microsoft Windows GDI+ functions and the classes, therefore, do not rely on an installed ActiveX.

## Library Examples
In the demo workspaces you will find three folders: DataFlex, MSSQL and NoData. They contain projects that showcase the use of the library in different scenarios. Use these examples to study various techniques of handling images in an application.

The DataDemo project is database aware and shows the pictures of people and products where the filenames are stored in the record of a table. 

Other projects are found in the NoData workspace. ImageGallery, for example, is an application that lets you browse through the drives and folders on your computer and shows the images present in each folder in a large icon style view. You can determine the size of the pictures, whether there should be a shadow, black background, which formats to support etc. Clicking an image will open a popup dialog in which the picture will be shown in a usually bigger size. The dialog is resizable. 

---

## Library Information

This repository contains a `Library` directory where the source for the Graphics library is, and the `Demo` directory where you can find three demo workspaces that use the library.


## General Information

| Product  | Version           |
| -------- | ----------------- |
| DataFlex | 23.0, 24.0, 25.0  |
