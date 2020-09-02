# Matlab-code-for-native-MS-imaging.

Supplementary information

Matlab Files

- **SynaptProcessing.m** \- script for zero filling and creating the summed counts matrix, this script requires the following functions
    
    - **CountsMatrixSynapt.m** \- Deals with zero filling the m/z values
        
    - **MZListSynapt.m** \- Creates a matrix of all the counts at the corresponding m/z values in each scan of each pixel
        
- **SynaptIonImage.m** \- script for processing and creating the ion images, this performs baseline correction and TIC normalisation before creating the image. This requires the SynaptProcessing script to already have been run and requires the following functions
    
    - **maxbaseline.m** \- moving maximum
        
    - **medianbaseline.m** \- moving median
        
    - **ProduceFigure.m** \- Formats ion image
        

How to run

1.  Download all the files
    
2.  Change the following inputs in **SynaptProcessing.m**
    
    1.  Path – this is the folder location containing the mzML files
        
    2.  imzMLConverterLocation – location of the imzMLConvertor
        
    3.  Scansstart – change the location of the xlsx file that contains the list of scan starts and scan ends for each pixel and in which cells scan starts for each pixel is located
        
    4.  Scanssend - change the location of the xlsx file that contains the list of scan starts and scan ends for each pixel and in which cells scan ends for each pixel is located
        
3.  Run **SynaptProcessing.m**
    
4.  Change the following variables in **SynaptIonImage.m**
    
    1.  mzvalue – change this to whatever m/z value you want to show an image of
        
5.  Run **SynaptIonImage.m**
