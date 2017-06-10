% getSIFT(frameNum) gives us descriptors, orients, positions, and scales 
% given a frame number. change path to use depending on SIFT and frame 
% locations.
%
% getIm() returns and image matrix given a frameNum. change path to use
% depending on SIFT and frame locations.
%
%
% getHistogram(descriptors,kMeans) returns a kx1 matrix represneting a
% histogram of words contained in descriptors
%
%
% regionQueries is a script which prompts the user to select a region on a
% hard-coded set of images, and finds the images which contain descriptors 
% similar to those contained in the selected region
%
%
% fullFrameQueries is a script which finds finds the most-similar 5 images 
% for each of the set of hard-coded images finding the images which contain 
% descriptors similar to those contained in each query image
%
%
% visualizeVocabulary builds a visual vocabulary and saves it it
% kMeans.mat. It then goes on to display 
%
%
%
%
% rawDescriptorMatches allows the user to select a region on hard-coded
% frame1 and displays the corresponding patches on frame2
%
%
%
% tfidf queries a region similar to regionQueries, but more accurately
% because it deletes common words from the bag of words and uses tfidf
% weighting instead of unweighted histograms
%
%
%