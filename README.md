# Chanales_CurrBio_2017

Here we have made available the main scripts used in the analysis of the data and figure generation from [Chanales, Oza, Favila, and Kuhl, Current Biology 2017]. The raw data in BIDS format from the study can be found on OpenNeuro (https://openneuro.org/datasets/ds000217/versions/00002). Additional data needed to analyze the data including calibration scans and ROI masks can be found on OSF (). Scripts are provided so that readers can see how the data from this study were analyzed; they have not been edited for ease of general use. Note: The data in this study was comprised of two indpendent experiments and therefore there are preprocessing and pattern similiraity scripts for both Experiment 1 and Experiment 2.  

The Matlab scripts require the following dependencies:
1) spm8 (http://www.fil.ion.ucl.ac.uk/spm)
2) fsl 5.0.9 (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki)
3) the princeton mvpa toolbox (http://www.pni.princeton.edu/mvpa)
4) Additional software used can be found in the 'software' folder

To analyze the data perform the following steps:

Organize Data
1) The raw data should be downloaded into the experiment directory in a folder named 'raw_data'
2) Copy the calibration scans for each subject into their "anat" folder in the 'raw_data' directory

Preprocessing
1) First set the directory paths. To do so, open the file scripts>[Exp#]>preprocessing_scripts>par_params_directories_[Exp#].m and set the correct directory path for the experiment folder (the par.pardir field). Do this seperately for each experiment.  
2) Run preprocessing of the fMRI data for each experiment by running the scripts>[Exp#]>preprocessing_scripts>run_preprocesing_[Exp#].m

Pattern Similarity


License:

Copyright (c) 2017 Avi Chanales.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
